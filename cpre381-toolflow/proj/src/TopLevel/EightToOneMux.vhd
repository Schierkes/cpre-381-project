library IEEE;
use IEEE.std_logic_1164.all;

entity EightToOneMux is
    port(
        i_Sel: in std_logic_vector(2 downto 0);
        i_000: in std_logic_vector(31 downto 0);
        i_001: in std_logic_vector(31 downto 0);
        i_010: in std_logic_vector(31 downto 0);
        i_011: in std_logic_vector(31 downto 0);
        i_100: in std_logic_vector(31 downto 0);
        i_101: in std_logic_vector(31 downto 0);
        i_110: in std_logic_vector(31 downto 0);
        i_111: in std_logic_vector(31 downto 0);
        o_Out: out std_logic_vector(31 downto 0)
    );
end EightToOneMux;

architecture dataflow of EightToOneMux is
begin

    With i_Sel Select
        o_Out <=
            i_000 when "000",
            i_001 when "001",
            i_010 when "010",
            i_011 when "011",
            i_100 when "100",
            i_101 when "101",
            i_110 when "110",
            i_111 when "111",
            x"00000000" when others;
    
end architecture dataflow;