----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/26/2023 11:10:19 AM
-- Design Name: 
-- Module Name: cascade - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cascade is
    generic (
        --constant SIZE_ANGLE         : natural := 12;
        --constant SIZE_COMPTEUR      : natural := 28;
		--constant SIZE_muErr		    : natural := 32;
		--constant SIZE_muErrXi       : natural := 48;
		
		constant DATA_WIDTH 					: integer := 14;  -- Data bus width
        constant ADDR_WIDTH 					: integer := 12   -- Address bus width  (11 ou 12
		

    );
    Port ( clk              : in  STD_LOGIC;
           rst_n            : in  STD_LOGIC;
           enable           : in  std_logic;
           
           antinoise        : in  signed (15 downto 0);
           id_delta         : in  unsigned (11 downto 0);     -- id_delta = (phi/(2*PI)) * (1/NF_Freq)/PERIOD
           in0              : in  signed (13 downto 0);
           in_next          : out signed (13 downto 0)
           );
end cascade;

architecture Behavioral of cascade is

    -- Calcul de la memoire
    -- Optimisation for 36k dual port RAM
    -- 36000/
    --(2^11=2048 taille buffer) (2048*14 = 28672 donc rentre dans un bloc 36K aussi avec 16bit au lieu de 14
    

    -- declaration de la memoire
    type memory_array is array (0 to 2**DATA_WIDTH-1) of signed(DATA_WIDTH-1 downto 0);
    signal mem : memory_array;

	signal antinoise_b :  signed(13 downto 0) ;
	signal data_out    :  signed(13 downto 0) ;
    
	-- Counter for write address
    signal counter : unsigned(ADDR_WIDTH-1 downto 0) ;

    -- Read address signal
    signal read_address : unsigned(ADDR_WIDTH-1 downto 0);
	

begin

 -- conversion en 14 bits de antinoise
	antinoise_b <= antinoise(13 downto 0) ;

    -- compteur buffer circulaire
    process(clk, rst_n)
    begin
        if rst_n = '0' then
            counter <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                counter <= counter + 1;
            end if;
        end if;
    end process;
	
	    -- Write data to memory
    process(clk)
    begin
        if rising_edge(clk) then
             mem(to_integer(counter)) <= antinoise_b;
        end if;
    end process;
	
	    -- read data from memory
    process(clk)
    begin
        if rising_edge(clk) then
            data_out <= mem(to_integer(read_address));
        end if;
    end process;


    -- calcul de l'address de lecture
    read_address <= counter - id_delta;
	
	
	in_next <= in0 + data_out;

end Behavioral;