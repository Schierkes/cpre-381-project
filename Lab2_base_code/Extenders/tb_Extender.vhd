library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_Extender is
end tb_Extender;

architecture mixed of tb_Extender is 

    component Extender is
        port(
            i_data: in std_logic_vector(15 downto 0);
            i_signSel: in std_logic;
            o_out: out std_logic_vector(31 downto 0)
        );
    end component;

    signal s_data: std_logic_vector(15 downto 0);
    signal s_signSel: std_logic;
    signal s_out: std_logic_vector(31 downto 0);

begin

    DUT0: Extender
        port map(
            i_data => s_data,
            i_signSel => s_signSel,
            o_out => s_out
        );

    P_TEST_Cases: process
        begin
            s_data <= x"8001";
            s_signSel <= '0';
            wait for 100 ns;

            s_data <= x"8001";
            s_signSel <= '1';
            wait for 100 ns;

            s_data <= x"0001";
            s_signSel <= '1';
            wait for 100 ns;
    end process;
end mixed;