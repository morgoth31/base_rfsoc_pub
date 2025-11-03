library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_ip is
  generic (
    DATA_WIDTH : integer := 32;  -- Configurable data width for AXI4-Stream
    AXI_WIDTH  : integer := 32;  -- Configurable data width for AXI input/output
    NUM_OUTPUTS : integer := 4   -- Configurable number of AXI interconnect outputs
  );
  port (
    -- AXI4-Stream Input Interface
    axi_in_tdata  : in  std_logic_vector(DATA_WIDTH-1 downto 0);
    axi_in_tvalid : in  std_logic;
    axi_in_tready : out std_logic;

    -- AXI4-Stream Output Interface
    axi_out_tdata  : out std_logic_vector(DATA_WIDTH-1 downto 0);
    axi_out_tvalid : out std_logic;
    axi_out_tready : in  std_logic;

    -- AXI Input Interface
    axi_in_data  : in  std_logic_vector(AXI_WIDTH-1 downto 0);
    axi_in_valid : in  std_logic;
    axi_in_ready : out std_logic;

    -- AXI Output Interfaces (Configurable number)
    axi_out_data  : out std_logic_vector(AXI_WIDTH-1 downto 0);
    axi_out_valid : out std_logic;
    axi_out_ready : in  std_logic;

    axi_interconnect_out_data : out std_logic_vector(AXI_WIDTH-1 downto 0);
    axi_interconnect_out_valid : out std_logic_vector(NUM_OUTPUTS-1 downto 0);
    axi_interconnect_out_ready : in  std_logic_vector(NUM_OUTPUTS-1 downto 0);

    -- Clock and Reset
    clk  : in std_logic;
    rstn : in std_logic  -- Active-low reset
  );
end entity top_ip;

architecture Behavioral of top_ip is
  -- Internal signals for AXI4-Stream
  signal data_reg : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
  signal valid_reg : std_logic := '0';

  -- Internal signals for AXI Input/Output
  signal axi_data_reg : std_logic_vector(AXI_WIDTH-1 downto 0) := (others => '0');
  signal axi_valid_reg : std_logic := '0';

  -- Internal signals for AXI Interconnect
  type axi_interconnect_array is array (0 to NUM_OUTPUTS-1) of std_logic_vector(AXI_WIDTH-1 downto 0);
  signal axi_interconnect_data : axi_interconnect_array := (others => (others => '0'));
  signal axi_interconnect_valid : std_logic_vector(NUM_OUTPUTS-1 downto 0) := (others => '0');

begin
  -- Process to implement simple AXI4-Stream pass-through behavior
  process(clk, rstn)
  begin
    if rstn = '0' then
      -- Reset logic for AXI4-Stream
      data_reg <= (others => '0');
      valid_reg <= '0';
      axi_in_tready <= '0';

      -- Reset logic for AXI Input/Output
      axi_data_reg <= (others => '0');
      axi_valid_reg <= '0';
      axi_in_ready <= '0';

      -- Reset logic for AXI Interconnect
      axi_interconnect_data <= (others => (others => '0'));
      axi_interconnect_valid <= (others => '0');
    elsif rising_edge(clk) then
      -- AXI4-Stream handshake
      if axi_in_tvalid = '1' and axi_in_tready = '1' then
        data_reg <= axi_in_tdata;  -- Latch input data
        valid_reg <= '1';          -- Set valid for output
      elsif axi_out_tvalid = '1' and axi_out_tready = '1' then
        valid_reg <= '0';          -- Clear valid once output is consumed
      end if;

      -- Ready signal generation for AXI4-Stream
      if axi_out_tready = '1' or valid_reg = '0' then
        axi_in_tready <= '1';
      else
        axi_in_tready <= '0';
      end if;

      -- AXI Input/Output handshake
      if axi_in_valid = '1' and axi_in_ready = '1' then
        axi_data_reg <= axi_in_data;  -- Latch AXI input data
        axi_valid_reg <= '1';         -- Set valid for AXI output
      elsif axi_out_valid = '1' and axi_out_ready = '1' then
        axi_valid_reg <= '0';         -- Clear valid once AXI output is consumed
      end if;

      -- Ready signal generation for AXI Input/Output
      if axi_out_ready = '1' or axi_valid_reg = '0' then
        axi_in_ready <= '1';
      else
        axi_in_ready <= '0';
      end if;

      -- AXI Interconnect logic
      for i in 0 to NUM_OUTPUTS-1 loop
        if axi_interconnect_out_ready(i) = '1' and axi_interconnect_valid(i) = '1' then
          axi_interconnect_data(i) <= axi_data_reg;  -- Broadcast input data to outputs
          axi_interconnect_valid(i) <= '1';
        else
          axi_interconnect_valid(i) <= '0';
        end if;
      end loop;
    end if;
  end process;

  -- Output assignments for AXI4-Stream
  axi_out_tdata <= data_reg;
  axi_out_tvalid <= valid_reg;

  -- Output assignments for AXI Input/Output
  axi_out_data <= axi_data_reg;
  axi_out_valid <= axi_valid_reg;

  -- AXI Interconnect output assignments
  axi_interconnect_out_data <= axi_data_reg;
  axi_interconnect_out_valid <= axi_interconnect_valid;

end architecture Behavioral;
