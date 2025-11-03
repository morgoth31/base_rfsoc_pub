----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/10/2024 12:00:20 PM
-- Design Name: 
-- Module Name: Clk_generator - Behavioral
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

entity Clk_generator is
    generic (
        constant SIZE_ANGLE         : natural := 12;
        constant SIZE_COMPTEUR      : natural := 28
    );
    Port (
        clk                 : in  std_logic;
        rst_n               : in  std_logic;
        enable              : in  std_logic;
        
        -- configuration
        idfreq              : in  unsigned (SIZE_COMPTEUR-1 downto 0);  -- idfreq= ((2^28/Fck)*NF_Freq);
        idphi_ang           : in  unsigned (SIZE_ANGLE-1 downto 0);
        
        x0                  : out signed (15 downto 0); -- 16bit max
        x1                  : out signed (15 downto 0); -- 16bit max
        x0_filter           : out signed (15 downto 0); -- 16bit max
        x1_filter           : out signed (15 downto 0) -- 16bit max
        
    );
end Clk_generator;

architecture Behavioral of Clk_generator is

-- declaration de la table de cosinus
component cos_12table16 is
    Port ( clk          : in std_logic;
           angle_12b    : in unsigned (SIZE_ANGLE-1 downto 0);
           cos_16       : out signed (15 downto 0)
           );
end component ;

-- generation des X0,X1,X0_filtered et X1_filtered
signal cmpt                 : unsigned(SIZE_COMPTEUR-1 downto 0);

-- valeur en angle
signal X_0_ang              : unsigned(SIZE_ANGLE-1 downto 0);
signal X_1_ang              : unsigned(SIZE_ANGLE-1 downto 0);
signal X_0_filter_ang       : unsigned(SIZE_ANGLE-1 downto 0);
signal X_1_filter_ang       : unsigned(SIZE_ANGLE-1 downto 0);

-- registre interne 
signal x0_reg               : signed (15 downto 0); -- 16bit max
signal x1_reg               : signed (15 downto 0); -- 16bit max
signal x0_filter_reg        : signed (15 downto 0); -- 16bit max
signal x1_filter_reg        : signed (15 downto 0); -- 16bit max


begin

----------------------------------------------------------------------
-- Notch filter frequency generator
----------------------------------------------------------------------
-- compteur rotatif 
-- compte a 268 435 456 (2^28)
-- pour avoir la bonne frequence freq = (2^28/125*10^6)* frequence voulue
freq_generator:process (clk,rst_n)
begin
    if (rst_n='0') then
        cmpt <= (others => '0') ;
    elsif (rising_edge(clk)) then
        if (enable = '1') then
            cmpt <= cmpt + idfreq;
        end if;
    end if;
end process;

  
-- recupere les bits de poids fort
-- correspont a un cercle decoupé en 4096 (12 bits)
-- ajoute des dephasages ou delay
-- ces valeurs addressent la table de cosinus    
xi_angle_gene:process (clk)
begin
    if (rising_edge(clk)) then
        X_0_ang         <= cmpt(SIZE_COMPTEUR-1 downto SIZE_COMPTEUR-SIZE_ANGLE) + (2**SIZE_ANGLE)/4 ;      -- x0= sin(w0*t)
        X_1_ang         <= cmpt(SIZE_COMPTEUR-1 downto SIZE_COMPTEUR-SIZE_ANGLE);                           -- x1= cos(w0*t)
        
--        X_0_filter_ang  <= cmpt(SIZE_COMPTEUR-1 downto SIZE_COMPTEUR-SIZE_ANGLE) + (2**SIZE_ANGLE)/4 + s0 ; -- x0= sin(w0*t+s0)
--        X_1_filter_ang  <= cmpt(SIZE_COMPTEUR-1 downto SIZE_COMPTEUR-SIZE_ANGLE) + s1 ;                     -- x1= cos(w0*t+s1)  
        X_0_filter_ang  <= X_0_ang + idphi_ang ; -- x0= sin(w0*t+s0)
        X_1_filter_ang  <= X_1_ang + idphi_ang ; -- x1= cos(w0*t+s1)  
        end if;
end process;


-- conversion des angles 12 bits en cosinus 16 bit signés (normalisé)

cos_10table16_X_0_ang_inst : cos_12table16
Port map(  
    clk        => clk           ,
    angle_12b  => X_0_ang       ,
    cos_16     => x0_reg     
);
 cos_10table16_X_1_ang_inst : cos_12table16
Port map(  
    clk        => clk           ,
    angle_12b  => X_1_ang       ,
    cos_16     => x1_reg      
);
cos_10table16_X_0_filter_ang_inst : cos_12table16
Port map(  
    clk        => clk               ,
    angle_12b  => X_0_filter_ang    ,
    cos_16     => x0_filter_reg     
);
cos_10table16_X_1_filter_ang_inst : cos_12table16
Port map(  
    clk        => clk               ,
    angle_12b  => X_1_filter_ang    ,
    cos_16     => x1_filter_reg     
);

-- connection des registres internes aux sorties de la fonction
x0          <= x0_reg           ; 
x1          <= x1_reg           ;
x0_filter   <= x0_filter_reg    ;   
x1_filter   <= x1_filter_reg    ;



end Behavioral;
