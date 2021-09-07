----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/02/2021 04:17:53 PM
-- Design Name: 
-- Module Name: TwiddleX - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TwiddleX is
    Port ( Xr : in STD_LOGIC_VECTOR (15 downto 0);
           Yr : in STD_LOGIC_VECTOR (15 downto 0);
           Xi : in STD_LOGIC_VECTOR (15 downto 0);
           Yi : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           overflow : out STD_LOGIC;
           
           Outr :out STD_LOGIC_VECTOR (31 downto 0);
           Outi: out STD_LOGIC_VECTOR (31 downto 0));
end TwiddleX;

architecture Behavioral of TwiddleX is
component adder_exact
port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           C : out STD_LOGIC_VECTOR (31 downto 0));
end component;
component sub_exact
port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           C : out STD_LOGIC_VECTOR (31 downto 0));
end component;
component mult_exact
port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           C : out STD_LOGIC_VECTOR (31 downto 0));
end component;
signal m0, m1, m2, m3 : STD_LOGIC_VECTOR (31 downto 0);
signal a0, a1 : STD_LOGIC_VECTOR (31 downto 0);
signal ovtx0,ovtx1,ovtx2,ovtx3,ovtxr,ovtxi,ov : STD_LOGIC ;
begin
Mult0 : mult_exact

port map (
   A => Xr,
   B  => Yr,
   C  => m0
);
Mult1 : mult_exact

port map (
   A => Xi,
   B  => Yi,
   C  => m1
);
Mult2 : mult_exact

port map (
   A => Xi,
   B  => Yr,
   C  => m2
);
Mult3 : mult_exact

port map (
   A => Xr,
   B  => Yi,
   C  => m3
);

Add0 : adder_exact

port map (
   A => m0,
   B  => m1,
   C  => a0
);
Sub1 : sub_exact

port map (
   A => m2,
   B  => m3,
   C  => a1
);


ovtx0 <= m0(31) xor a0(31);
ovtx1 <= m0(31) xor m1(31);
ovtx2 <= m2(31) xor a1(31);
ovtx3 <= (not (m3(31))) xor m2(31);
ovtxr <= ovtx0 and (not (ovtx1));
ovtxi <= ovtx2 and (not (ovtx3));
ov <= ovtxr or ovtxi;

Outi <= a1;
Outr <= a0;
overflow <= ov;

end Behavioral;
