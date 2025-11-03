----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/24/2023 06:32:35 PM
-- Design Name: 
-- Module Name: antinoise - Behavioral
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

entity antinoise_blk is
    generic (
		constant SIZE_muErr		    : natural := 25
		
    );
    Port (  clk                 : in  std_logic;
            rst_n               : in  std_logic;
            enable              : in  std_logic;
            
            id_mode             : in  std_logic;
            
            -- Clocks
            x0                  : in signed (15 downto 0);
            x1                  : in signed (15 downto 0);
            x0_filter           : in signed (15 downto 0);
            x1_filter           : in signed (15 downto 0);
			
			-- gain                : in  std_logic_vector(3 downto 0) ; 
            mu                  : in  std_logic_vector(3 downto 0) ;
            
			-- input signal of notch filter
            inNF	            : in  signed (13 downto 0);
			
            -- signaux pour la cascade
            w0                  : out signed (15 downto 0);
            w1                  : out signed (15 downto 0);
			
            
            error	            : out  signed (15 downto 0);
            antinoise         	: out signed (15 downto 0);
			
			-- status register
			sreg				: out std_logic_vector (7 downto 0)
			
--			sreg(0)		upper than max/2 on Error * Mu
--			sreg(1)		upper than max/2 on w0
--			sreg(2)		upper than max/2 on w1
			
           );
end antinoise_blk;

architecture Behavioral of antinoise_blk is

constant SIZE_muErrXi       : natural := SIZE_muErr + 16 ;
signal mu_4					: std_logic_vector (3 downto 0);
signal error_b    			: signed (SIZE_muErr-1 downto 0);
signal muErr             	: signed (SIZE_muErr-1 downto 0);

signal muErrr_X0            : signed (SIZE_muErrXi-1 downto 0);
signal muErrr_X1            : signed (SIZE_muErrXi-1 downto 0);


signal w0_old, w1_old 		: signed (SIZE_muErrXi-1 downto 0);
signal w0_b, w1_b			: signed (SIZE_muErr-1 downto 0);

signal w0_x0, w1_x1     	: signed (SIZE_muErrXi-1 downto 0);

signal antinoise0_b       	: signed (SIZE_muErrXi-1 downto 0);
signal antinoise0       	: signed (13 downto 0);



begin

----------------------------------------------------------------------
-- Mu * error  (muErr = error / 2^(mu))
----------------------------------------------------------------------
-- get inputs
mu_4 <= mu(3 downto 0) ;

err_process : process (clk,rst_n)
begin
	if ( rst_n = '0' ) then 
		error_b		<= (others => '0');
	elsif (rising_edge(clk)) then
		if (id_mode = '1') then
			error_b		<=  TO_SIGNED (TO_INTEGER(inNF - antinoise0), SIZE_muErr);
		else
			error_b		<=  TO_SIGNED (TO_INTEGER(inNF), SIZE_muErr);
		end if;
	end if;

end process;


error <= TO_SIGNED (TO_INTEGER(error_b), 16);


multi_error_mu : process (mu_4, error_b, clk)
begin
    if (rising_edge(clk)) then
       case mu_4 is
          when "0000" => muErr  <= error_b;
          when "0001" => muErr  <= error_b(SIZE_muErr-2 downto 0)  & "0" ;
          when "0010" => muErr  <= error_b(SIZE_muErr-3 downto 0)  & "00";            
          when "0011" => muErr  <= error_b(SIZE_muErr-4 downto 0)  & "000" ;          
          when "0100" => muErr  <= error_b(SIZE_muErr-5 downto 0)  & "0000" ;         
          when "0101" => muErr  <= error_b(SIZE_muErr-6 downto 0)  & "00000" ;        
          when "0110" => muErr  <= error_b(SIZE_muErr-7 downto 0)  & "000000" ;       
          when "0111" => muErr  <= error_b(SIZE_muErr-8 downto 0)  & "0000000" ;      
          when "1000" => muErr  <= error_b(SIZE_muErr-9 downto 0)  & "00000000" ;     
          when "1001" => muErr  <= error_b(SIZE_muErr-10 downto 0) & "000000000" ;
          when "1010" => muErr  <= error_b(SIZE_muErr-11 downto 0) & "0000000000" ;
          when others => muErr  <= error_b(SIZE_muErr-12 downto 0) & "00000000000" ;    
--          when "1010" => muErr  <= error_b(SIZE_muErr-11 downto 0) & "0000000000" ;   
--          when "1011" => muErr  <= error_b(SIZE_muErr-12 downto 0) & "00000000000" ;  
--          when "1100" => muErr  <= error_b(SIZE_muErr-13 downto 0) & "000000000000" ; 
--          when "1101" => muErr  <= error_b(SIZE_muErr-14 downto 0) & "0000000000000" ;    
--          when "1110" => muErr  <= error_b(SIZE_muErr-15 downto 0) & "00000000000000";
--          when "1111" => muErr  <= error_b(SIZE_muErr-16 downto 0) & "000000000000000" ;
       end case;
   end if;
end process;


sreg(0) <= (muErr(SIZE_muErr-1) XOR  muErr(SIZE_muErr-2));	-- upper than max/2 on Error * Mu

----------------------------------------------------------------------
-- wi = integrator(Mu * Error * Xi_Filter)
----------------------------------------------------------------------
-- 2 DSPs (SIZE_muErr*16) en mode MACC
multi_muErrXi_process : process (clk,rst_n)
    begin
        if ( rst_n = '0' ) then
            muErrr_X0	<= (others => '0')	;
            muErrr_X1	<= (others => '0')	;
            w0_old	<= (others => '0')	;
            w1_old	<= (others => '0')	;
        elsif (rising_edge(clk)) then
            w0_old	<=  w0_old + muErrr_X0;
            w1_old	<=  w1_old + muErrr_X1;
            if (id_mode = '1') then
                muErrr_X0	<=  muErr * x0;
                muErrr_X1	<=  muErr * x1;
            else
                muErrr_X0	<=  muErr * x0_filter;
                muErrr_X1	<=  muErr * x1_filter;
            end if;
    end if;
end process;

--integrator_process : process (clk,rst_n)
--    begin
--        if ( rst_n = '0' ) then
--            w0_old	<= (others => '0')	;
--            w1_old	<= (others => '0')	;
--        elsif (rising_edge(clk)) then
--            w0_old	<=  w0_old + muErrr_X0;
--            w1_old	<=  w1_old + muErrr_X1;
--    end if;
--end process;

w0_b <=  w0_old(SIZE_muErrXi-1 downto SIZE_muErrXi-25);  	-- div by 2^(16)
w1_b <=  w1_old(SIZE_muErrXi-1 downto SIZE_muErrXi-25);  	-- div by 2^(16)

sreg(1) <= (w0_b(SIZE_muErr-1) XOR w0_b(SIZE_muErr-2));		-- upper than max/2 on w0
sreg(2) <= (w1_b(SIZE_muErr-1) XOR w1_b(SIZE_muErr-2));		-- upper than max/2 on w1

w0 <= w0_b(SIZE_muErr-1 downto SIZE_muErr-16) ;  	-- div by 2^(16)
w1 <= w1_b(SIZE_muErr-1 downto SIZE_muErr-16) ;  	-- div by 2^(16)

----------------------------------------------------------------------
-- antinoise generation
----------------------------------------------------------------------
-- 2 DSPs (SIZE_muErr x 16) en mode MACC
antinoise_mult_process : process (clk,rst_n)
    begin
        if ( rst_n = '0' ) then 
            antinoise0_b <= (others => '0');
        elsif (rising_edge(clk)) then
            antinoise0_b <= (w0_b * x0) + (w1_b * x1);
        end if;
end process;

--antinoise_mult_process : process (clk,rst_n)
--    begin
--        if ( rst_n = '0' ) then 
--            w0_x0	<= (others => '0');
--            w1_x1	<= (others => '0');
            
--        elsif (rising_edge(clk)) then          
--            w0_x0	<= w0_b * x0;
--            w1_x1   <= w1_b * x1;
--            antinoise0_b <= w0_x0 + w1_x1  ;
--        end if;
--end process;

--antinoise_add_process : process (clk,rst_n)
--    begin
--        if ( rst_n = '0' ) then 
--            antinoise0_b <= (others => '0');
--        elsif (rising_edge(clk)) then          
--            antinoise0_b <= w0_x0 + w1_x1  ;
--        end if;
--end process;

antinoise0 <=  antinoise0_b(SIZE_muErrXi-1) & antinoise0_b(38 downto 26);  	-- div by 2^26

sreg(3) <= (antinoise0(13) XOR antinoise0(12));	-- upper than max/2 on antinoise0

----------------------------------------------------------------------
-- out
----------------------------------------------------------------------
antinoise <= TO_SIGNED (TO_INTEGER (antinoise0), 16) when id_mode='0' else x0;


end Behavioral;