library IEEE;
use IEEE.std_logic_1164.all;

entity Repl is 
    port(
        i_Immediate : in std_logic_vector(31 downto 0);
        o_Out : out std_logic_vector(31 downto 0)
    );
end Repl;

architecture dataflow of Repl is
    signal val : std_logic_vector(7 downto 0);
begin

    val <= i_Immediate(7 downto 0);

    o_Out(31 downto 24) <= val;
    o_Out(23 downto 16) <= val;
    o_Out(15 downto 8) <= val;
    o_Out(7 downto 0) <= val;

end dataflow;