from pynq_scope import PynqScope

def main():
    """
    An example of how to use the PynqScope class.
    """
    try:
        # Initialize the PynqScope. You might need to change "base.bit"
        # to the actual path of your overlay file.
        scope = PynqScope("base.bit")

        # Set acquisition parameters
        # rate_acquisition: A value greater than 10,000,000 can cause issues.
        # packet_size: Must be between 0 and 1023.
        rate_acquisition = 2
        packet_size = 1023

        # Acquire data
        print(f"Acquiring data with rate_acquisition={rate_acquisition} and packet_size={packet_size}...")
        channels = scope.acquire_data(rate_acquisition, packet_size)

        # Print the shape of the received data for verification
        print("Data acquisition successful!")
        for i, channel_data in enumerate(channels):
            print(f"Channel {i} data shape: {channel_data.shape}")
            # You can uncomment the following line to print the first 5 samples of each channel
            # print(f"Channel {i} data (first 5 samples): {channel_data[:5]}")

    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    main()
