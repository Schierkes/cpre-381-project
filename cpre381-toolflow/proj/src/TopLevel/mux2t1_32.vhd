library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1_32 is
    port(i_Select : in std_logic;
         i_D0     : in std_logic_vector(31 downto 0);
         i_D1     : in std_logic_vector(31 downto 0);
         o_Out    : out std_logic_vector(31 downto 0));
end mux2t1_32;

architecture dataflow of mux2t1_32 is
    begin
        with i_Select select 
            o_Out <= i_D1 when '1', i_D0 when '0', x"00000000" when others;
    end dataflow;