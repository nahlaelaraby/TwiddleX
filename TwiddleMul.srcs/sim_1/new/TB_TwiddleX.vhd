----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/07/2021 07:40:59 PM
-- Design Name: 
-- Module Name: TB_TwiddleX - Behavioral
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

entity TB_TwiddleX is
    Port ( clk : in STD_LOGIC);
end TB_TwiddleX;

architecture Behavioral of TB_TwiddleX is
component TwiddleX is
    Port ( Xr : in STD_LOGIC_VECTOR (15 downto 0);
           Yr : in STD_LOGIC_VECTOR (15 downto 0);
           Xi : in STD_LOGIC_VECTOR (15 downto 0);
           Yi : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           overflow : out STD_LOGIC;
           
           Outr :out STD_LOGIC_VECTOR (31 downto 0);
           Outi: out STD_LOGIC_VECTOR (31 downto 0));
end component;
signal SXr :  STD_LOGIC_VECTOR (15 downto 0);
   signal        SYr: STD_LOGIC_VECTOR (15 downto 0);
 signal          SXi:  STD_LOGIC_VECTOR (15 downto 0);
  signal         SYi:  STD_LOGIC_VECTOR (15 downto 0);
   signal        Sclk:  STD_LOGIC;
   signal        Soverflow:  STD_LOGIC;
           
    signal       SOutr:  STD_LOGIC_VECTOR (31 downto 0);
      signal     SOuti: STD_LOGIC_VECTOR (31 downto 0);

constant startR : integer := 0 ;
constant endR   : integer := 65536;



begin

 

  UUT : TwiddleX 
    Port map ( Xr => SXr,
           Yr => SYr,
           Xi => SXi ,
           Yi => SYi,
           clk => Sclk,
           overflow => Soverflow,
           
           Outr => SOutr,
           Outi => SOuti);
 


process 
begin
SXi <= std_logic_vector(to_unsigned(12,16)); 
    SYi <= std_logic_vector(to_unsigned(20,16));  
--                           
        for i in startR to endR -1 loop
            SXr <= std_logic_vector(to_unsigned(i,16)); 
            wait for 1 ns;
            for j in startR to endR -1 loop
                SYr <= std_logic_vector(to_unsigned(j,16));  
                wait for 1 ns;
--					 for ii in startR to endR -1 loop
--                        SXi <= std_logic_vector(to_unsigned(i,16)); 
--                        wait for 1 ns;
--                        for jj in startR to endR -1 loop
--                            SYi <= std_logic_vector(to_unsigned(j,16));  
--                            wait for 1 ns;
					 
--                        end loop;
--			         end loop;
            end loop; 
        end loop;   
end process;


end Behavioral;
