import tkinter as tk
from tkinter import ttk
import matplotlib.pyplot as plt
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
import numpy as np
import socket
import threading
import struct
import argparse

class PynqScopeGUI:
    def __init__(self, master, verbose=False):
        self.master = master
        self.verbose = verbose
        master.title("PYNQ Scope")

        # Create the main frame
        self.main_frame = ttk.Frame(master, padding="10")
        self.main_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))

        # Create the plot
        self.fig, self.ax = plt.subplots()
        self.line, = self.ax.plot([])
        self.ax.set_ylim(0, 65535) # ADC is likely 16-bit
        self.canvas = FigureCanvasTkAgg(self.fig, master=self.main_frame)
        self.canvas.get_tk_widget().grid(row=0, column=0, columnspan=4)

        # Create the controls
        self.ip_label = ttk.Label(self.main_frame, text="IP Address:")
        self.ip_label.grid(row=1, column=0, sticky=tk.W)
        self.ip_entry = ttk.Entry(self.main_frame)
        self.ip_entry.grid(row=1, column=1, sticky=(tk.W, tk.E))
        self.ip_entry.insert(0, "192.168.144.26")

        self.port_label = ttk.Label(self.main_frame, text="Port:")
        self.port_label.grid(row=2, column=0, sticky=tk.W)
        self.port_entry = ttk.Entry(self.main_frame)
        self.port_entry.grid(row=2, column=1, sticky=(tk.W, tk.E))
        self.port_entry.insert(0, "8080")

        self.connect_button = ttk.Button(self.main_frame, text="Connect", command=self.connect)
        self.connect_button.grid(row=3, column=0, sticky=tk.W)

        self.disconnect_button = ttk.Button(self.main_frame, text="Disconnect", command=self.disconnect, state=tk.DISABLED)
        self.disconnect_button.grid(row=3, column=1, sticky=tk.W)

        # Create the acquisition controls
        self.start_button = ttk.Button(self.main_frame, text="Start", command=self.start_acquisition, state=tk.DISABLED)
        self.start_button.grid(row=4, column=0, sticky=tk.W)

        self.stop_button = ttk.Button(self.main_frame, text="Stop", command=self.stop_acquisition, state=tk.DISABLED)
        self.stop_button.grid(row=4, column=1, sticky=tk.W)

        # Configuration controls
        self.rx_size_label = ttk.Label(self.main_frame, text="RX Size:")
        self.rx_size_label.grid(row=1, column=2, sticky=tk.W)
        self.rx_size_entry = ttk.Entry(self.main_frame)
        self.rx_size_entry.grid(row=1, column=3, sticky=(tk.W, tk.E))
        self.rx_size_entry.insert(0, "8192")

        self.ndesc_label = ttk.Label(self.main_frame, text="Num. Descriptors:")
        self.ndesc_label.grid(row=2, column=2, sticky=tk.W)
        self.ndesc_entry = ttk.Entry(self.main_frame)
        self.ndesc_entry.grid(row=2, column=3, sticky=(tk.W, tk.E))
        self.ndesc_entry.insert(0, "8")

        self.send_config_button = ttk.Button(self.main_frame, text="Send Config", command=self.send_config, state=tk.DISABLED)
        self.send_config_button.grid(row=3, column=2, sticky=tk.W)

        # Status bar
        self.status_bar = ttk.Label(self.main_frame, text="Ready", relief=tk.SUNKEN, anchor=tk.W)
        self.status_bar.grid(row=5, column=0, columnspan=4, sticky=(tk.W, tk.E))

        # Networking
        self.socket = None
        self.is_connected = False
        self.is_acquiring = False
        self.acquisition_thread = None

        # Interactive plot
        self.fig.canvas.mpl_connect('motion_notify_event', self.on_mouse_move)

    def on_mouse_move(self, event):
        if event.inaxes:
            x, y = event.xdata, event.ydata
            self.status_bar.config(text=f"x={x:.2f}, y={y:.2f}")
        else:
            self.status_bar.config(text="Ready")

    def connect(self):
        try:
            ip = self.ip_entry.get()
            port = int(self.port_entry.get())
            if self.verbose:
                print(f"Connecting to {ip}:{port}")
            self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self.socket.connect((ip, port))
            self.is_connected = True
            self.connect_button.config(state=tk.DISABLED)
            self.disconnect_button.config(state=tk.NORMAL)
            self.start_button.config(state=tk.NORMAL)
            self.send_config_button.config(state=tk.NORMAL)
            self.status_bar.config(text=f"Connected to {ip}:{port}")
        except Exception as e:
            self.status_bar.config(text=f"Error connecting: {e}")
            if self.verbose:
                print(f"Error connecting: {e}")

    def disconnect(self):
        if self.is_connected:
            if self.verbose:
                print("Disconnecting")
            self.stop_acquisition()
            self.socket.close()
            self.is_connected = False
            self.connect_button.config(state=tk.NORMAL)
            self.disconnect_button.config(state=tk.DISABLED)
            self.start_button.config(state=tk.DISABLED)
            self.send_config_button.config(state=tk.DISABLED)
            self.status_bar.config(text="Disconnected")

    def send_config(self):
        if self.is_connected:
            try:
                rx_size = self.rx_size_entry.get()
                ndesc = self.ndesc_entry.get()
                config_str = f"config,{rx_size},{ndesc}"
                if self.verbose:
                    print(f"Sending config: {config_str}")
                self.socket.sendall(config_str.encode())
                self.status_bar.config(text="Config sent")
            except Exception as e:
                self.status_bar.config(text=f"Error sending config: {e}")
                if self.verbose:
                    print(f"Error sending config: {e}")

    def start_acquisition(self):
        if self.is_connected and not self.is_acquiring:
            if self.verbose:
                print("Starting acquisition")
            self.is_acquiring = True
            self.start_button.config(state=tk.DISABLED)
            self.stop_button.config(state=tk.NORMAL)
            self.acquisition_thread = threading.Thread(target=self.acquisition_loop)
            self.acquisition_thread.start()
            self.status_bar.config(text="Acquisition started")

    def stop_acquisition(self):
        if self.is_acquiring:
            if self.verbose:
                print("Stopping acquisition")
            self.is_acquiring = False
            try:
                self.socket.sendall(b"stop")
            except Exception as e:
                self.status_bar.config(text=f"Error stopping acquisition: {e}")
                if self.verbose:
                    print(f"Error stopping acquisition: {e}")
            if self.acquisition_thread:
                self.acquisition_thread.join()
            self.start_button.config(state=tk.NORMAL)
            self.stop_button.config(state=tk.DISABLED)
            self.status_bar.config(text="Acquisition stopped")

    def acquisition_loop(self):
        try:
            if self.verbose:
                print("Sending start command")
            self.socket.sendall(b"start")
            while self.is_acquiring:
                # Receive data from the server
                data = self.socket.recv(8192)
                if not data:
                    break
                if self.verbose:
                    print(f"Received {len(data)} bytes")

                # Unpack the data
                values = struct.unpack(f"{len(data)//2}H", data)

                # Update the plot
                x_values = np.arange(len(values))
                self.line.set_data(x_values, values)
                self.ax.set_xlim(0, len(values))
                self.canvas.draw()
        except Exception as e:
            self.status_bar.config(text=f"Error in acquisition loop: {e}")
            if self.verbose:
                print(f"Error in acquisition loop: {e}")
            self.stop_acquisition()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="PYNQ Scope GUI")
    parser.add_argument("--verbose", action="store_true", help="Enable verbose output")
    args = parser.parse_args()

    root = tk.Tk()
    app = PynqScopeGUI(root, verbose=args.verbose)
    root.mainloop()
