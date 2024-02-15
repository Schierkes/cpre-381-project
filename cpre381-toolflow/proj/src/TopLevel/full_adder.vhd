library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder is
    port(i_C    :in std_logic;
         i_A	:in std_logic;
         i_B	:in std_logic;
         o_C	:out std_logic;
	     o_S	:out std_logic);
end full_adder;

architecture add of full_adder is
    begin
        o_S <= i_A xor i_B xor i_C;
        o_C <= (i_A and i_B) or (i_A and i_C) or (i_B and i_C);
    end add;
