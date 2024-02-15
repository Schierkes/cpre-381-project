library IEEE;
use IEEE.std_logic_1164.all;

entity Adder_32 is
  port(i_C          : in std_logic;
       i_A          : in std_logic_vector(31 downto 0);
       i_B          : in std_logic_vector(31 downto 0);
       o_C	        : out std_logic;
       o_S          : out std_logic_vector(31 downto 0));

end Adder_32;

architecture structural of Adder_32 is
  component full_adder
    port(i_C    :in std_logic;
         i_A	:in std_logic;
         i_B	:in std_logic;
         o_C	:out std_logic;
	     o_S	:out std_logic);
  end component;
 
  signal x1:	std_logic_vector(32 downto 0);

begin

  x1(0) <= '0';
  o_C <= x1(31); 

  FA: for i in 0 to 31 generate
    FA_32: full_adder port map(i_C => x1(i), i_A => i_A(i), i_B => i_B(i), o_S => o_S(i), o_C => x1(i+1));
  end generate;

end structural;