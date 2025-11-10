import tkinter as tk
from tkinter import ttk
import matplotlib.pyplot as plt
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
import numpy as np
import socket
import threading
import struct

class PynqScopeGUI:
    def __init__(self, master):
        self.master = master
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
        self.ip_entry.insert(0, "192.168.1.10")

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
            self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self.socket.connect((self.ip_entry.get(), int(self.port_entry.get())))
            self.is_connected = True
            self.connect_button.config(state=tk.DISABLED)
            self.disconnect_button.config(state=tk.NORMAL)
            self.start_button.config(state=tk.NORMAL)
            self.send_config_button.config(state=tk.NORMAL)
        except Exception as e:
            print(f"Error connecting: {e}")

    def disconnect(self):
        if self.is_connected:
            self.stop_acquisition()
            self.socket.close()
            self.is_connected = False
            self.connect_button.config(state=tk.NORMAL)
            self.disconnect_button.config(state=tk.DISABLED)
            self.start_button.config(state=tk.DISABLED)
            self.send_config_button.config(state=tk.DISABLED)

    def send_config(self):
        if self.is_connected:
            rx_size = self.rx_size_entry.get()
            ndesc = self.ndesc_entry.get()
            config_str = f"config,{rx_size},{ndesc}"
            self.socket.sendall(config_str.encode())

    def start_acquisition(self):
        if self.is_connected and not self.is_acquiring:
            self.is_acquiring = True
            self.start_button.config(state=tk.DISABLED)
            self.stop_button.config(state=tk.NORMAL)
            self.acquisition_thread = threading.Thread(target=self.acquisition_loop)
            self.acquisition_thread.start()

    def stop_acquisition(self):
        if self.is_acquiring:
            self.is_acquiring = False
            self.socket.sendall(b"stop")
            if self.acquisition_thread:
                self.acquisition_thread.join()
            self.start_button.config(state=tk.NORMAL)
            self.stop_button.config(state=tk.DISABLED)

    def acquisition_loop(self):
        self.socket.sendall(b"start")
        buffer_size = int(self.rx_size_entry.get())

        while self.is_acquiring:
            try:
                # Receive the complete buffer
                data = bytearray()
                while len(data) < buffer_size:
                    packet = self.socket.recv(buffer_size - len(data))
                    if not packet:
                        break
                    data.extend(packet)

                if len(data) != buffer_size:
                    print("Incomplete data received, stopping.")
                    break

                # Unpack the data
                values = struct.unpack(f"{len(data)//2}H", data)

                # Update the plot
                self.line.set_ydata(values)
                self.ax.set_xlim(0, len(values))
                self.canvas.draw()
            except Exception as e:
                print(f"Error in acquisition loop: {e}")
                break

if __name__ == "__main__":
    root = tk.Tk()
    app = PynqScopeGUI(root)
    root.mainloop()
