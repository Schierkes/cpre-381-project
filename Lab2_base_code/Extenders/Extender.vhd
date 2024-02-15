library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Extender is 
    port(
        i_data: in std_logic_vector(15 downto 0);
        i_signSel: in std_logic;
        o_out: out std_logic_vector(31 downto 0)
    );
end Extender;

architecture behavior of Extender is
begin
    o_out(15 downto 0) <= i_data;
    with i_signSel SELECT
        o_out(31 downto 16) <= (others => '0') WHEN '0',
                               (others => i_data(15)) WHEN '1',
                               (others => '0') WHEN others;
end behavior;