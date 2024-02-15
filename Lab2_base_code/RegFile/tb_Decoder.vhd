library IEEE;
use IEEE.std_logic_1164.all;

entity tb_Decoder is
end tb_Decoder;

architecture mixed of tb_Decoder is

    component Decoder is
        port(
            i_SEL: in std_logic_vector(4 downto 0);
            i_WE: in std_logic;
            o_OUT: out std_logic_vector(31 downto 0)
        );
    end component;

    signal s_Sel: std_logic_vector(4 downto 0);
    signal s_WE: std_logic;
    signal s_OUT: std_logic_vector(31 downto 0);

begin

    DUT0: Decoder
        port map(
            i_SEL => s_Sel,
            i_WE => s_WE,
            o_OUT => s_OUT
        );
    
    P_TEST_CASES: process
        begin
            s_WE <= '1';
            s_SEL <= "00000";
            wait for 50 ns;

            s_WE <= '1';
            s_SEL <= "00111";
            wait for 50 ns;

            s_WE <= '1';
            s_SEL <= "11110";
            wait for 50 ns;

            s_WE <= '1';
            s_SEL <= "11111";
            wait for 50 ns;

            s_WE <= '0';
            s_SEL <= "11111";
            wait for 50 ns;
        end process;
end mixed;