----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/20/2024 09:06:17 AM
-- Design Name: 
-- Module Name: axis2vector - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity axis2vector is
generic (
    AXIS_DATA_WIDTH     : integer := 16;  -- Width of the AXI Stream data
    VECTOR_DATA_WIDTH   : integer := 14;
    LEFT_SHIFT          : integer := 0    -- Number of bits to shift the output
  );
port (
    -- AXI-Stream slave interface
    clk             : in  std_logic;
    rst_n           : in  std_logic;
    
    axis_tvalid     : in  std_logic;
    axis_tdata      : in  std_logic_vector(AXIS_DATA_WIDTH-1 downto 0);
    axis_tready     : out std_logic;
    
    -- Output vector
    vector_out : out std_logic_vector(VECTOR_DATA_WIDTH-1 downto 0)
  );
  
end axis2vector;

architecture Behavioral of axis2vector is
    signal data_shifted : std_logic_vector(VECTOR_DATA_WIDTH-1 downto 0);
begin
  -- Scout toujours... pret !!!
    axis_tready <= '1';
 
  
        u1: if (LEFT_SHIFT > 0) generate
            u2: if (AXIS_DATA_WIDTH + LEFT_SHIFT <  VECTOR_DATA_WIDTH) generate
              -- cas Remplissage de zero en MSB et LSB (B) 
                 vector_out(VECTOR_DATA_WIDTH-1 downto AXIS_DATA_WIDTH + LEFT_SHIFT)     <= (others => '0');     -- MSB filled with zero
                 vector_out(AXIS_DATA_WIDTH-1+LEFT_SHIFT downto LEFT_SHIFT) <= axis_tdata(AXIS_DATA_WIDTH-1 downto 0) ; -- data
                 vector_out(LEFT_SHIFT downto 0)     <= (others => '0');     -- MSB filled with zero
             end generate;
            u3: if (AXIS_DATA_WIDTH + LEFT_SHIFT >=  VECTOR_DATA_WIDTH) generate
              -- cas remplissage de zero en LSB (C et E et I)
                 vector_out(VECTOR_DATA_WIDTH-1 downto LEFT_SHIFT) <= axis_tdata(VECTOR_DATA_WIDTH-LEFT_SHIFT-1 downto 0) ; -- data
                 vector_out(LEFT_SHIFT-1 downto 0)     <= (others => '0');     -- MSB filled with zero
             end generate;
            end generate;
        u4: if (LEFT_SHIFT <= 0) generate
            u5 : if (AXIS_DATA_WIDTH + LEFT_SHIFT <  VECTOR_DATA_WIDTH) generate
            -- cas remplissage de zero en MSB (A et D et J)
                vector_out(VECTOR_DATA_WIDTH-1 downto AXIS_DATA_WIDTH + LEFT_SHIFT)     <= (others => '0');     -- MSB filled with zero
                vector_out(  AXIS_DATA_WIDTH + LEFT_SHIFT-1 downto 0              )     <= axis_tdata(AXIS_DATA_WIDTH-1 downto 0-LEFT_SHIFT) ; -- data
            end generate;    
            u6: if (AXIS_DATA_WIDTH + LEFT_SHIFT >=  VECTOR_DATA_WIDTH) generate
              -- cas pas de remplissage (G et F et H et K)
                 vector_out(VECTOR_DATA_WIDTH-1 downto 0)  <= axis_tdata(VECTOR_DATA_WIDTH-LEFT_SHIFT-1 downto 0 - LEFT_SHIFT) ;   
            end generate;
        end generate;

end Behavioral;
