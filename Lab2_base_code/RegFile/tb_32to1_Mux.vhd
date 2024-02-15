library IEEE;
use IEEE.std_logic_1164.all;

entity tb_32to1_Mux is
end tb_32to1_Mux;

architecture mixed of tb_32to1_Mux is

    component ThirtyOneToOne_Mux is
        port(
            i_SEL: in std_logic_vector(4 downto 0);
            i_D0: in std_logic_vector(31 downto 0);
            i_D1: in std_logic_vector(31 downto 0);
            i_D2: in std_logic_vector(31 downto 0);
            i_D3: in std_logic_vector(31 downto 0);
            i_D4: in std_logic_vector(31 downto 0);
            i_D5: in std_logic_vector(31 downto 0);
            i_D6: in std_logic_vector(31 downto 0);
            i_D7: in std_logic_vector(31 downto 0);
            i_D8: in std_logic_vector(31 downto 0);
            i_D9: in std_logic_vector(31 downto 0);
            i_D10: in std_logic_vector(31 downto 0);
            i_D11: in std_logic_vector(31 downto 0);
            i_D12: in std_logic_vector(31 downto 0);
            i_D13: in std_logic_vector(31 downto 0);
            i_D14: in std_logic_vector(31 downto 0);
            i_D15: in std_logic_vector(31 downto 0);
            i_D16: in std_logic_vector(31 downto 0);
            i_D17: in std_logic_vector(31 downto 0);
            i_D18: in std_logic_vector(31 downto 0);
            i_D19: in std_logic_vector(31 downto 0);
            i_D20: in std_logic_vector(31 downto 0);
            i_D21: in std_logic_vector(31 downto 0);
            i_D22: in std_logic_vector(31 downto 0);
            i_D23: in std_logic_vector(31 downto 0);
            i_D24: in std_logic_vector(31 downto 0);
            i_D25: in std_logic_vector(31 downto 0);
            i_D26: in std_logic_vector(31 downto 0);
            i_D27: in std_logic_vector(31 downto 0);
            i_D28: in std_logic_vector(31 downto 0);
            i_D29: in std_logic_vector(31 downto 0);
            i_D30: in std_logic_vector(31 downto 0);
            i_D31: in std_logic_vector(31 downto 0);
            o_Out: out std_logic_vector(31 downto 0)
        );
    end component;

    signal s_Sel: std_logic_vector(4 downto 0);
    signal s_D0: std_logic_vector(31 downto 0) := x"00000001";
    signal s_D1: std_logic_vector(31 downto 0);
    signal s_D2: std_logic_vector(31 downto 0);
    signal s_D3: std_logic_vector(31 downto 0);
    signal s_D4: std_logic_vector(31 downto 0);
    signal s_D5: std_logic_vector(31 downto 0);
    signal s_D6: std_logic_vector(31 downto 0);
    signal s_D7: std_logic_vector(31 downto 0);
    signal s_D8: std_logic_vector(31 downto 0);
    signal s_D9: std_logic_vector(31 downto 0);
    signal s_D10: std_logic_vector(31 downto 0);
    signal s_D11: std_logic_vector(31 downto 0);
    signal s_D12: std_logic_vector(31 downto 0);
    signal s_D13: std_logic_vector(31 downto 0);
    signal s_D14: std_logic_vector(31 downto 0);
    signal s_D15: std_logic_vector(31 downto 0) := x"10101010";
    signal s_D16: std_logic_vector(31 downto 0);
    signal s_D17: std_logic_vector(31 downto 0);
    signal s_D18: std_logic_vector(31 downto 0);
    signal s_D19: std_logic_vector(31 downto 0);
    signal s_D20: std_logic_vector(31 downto 0);
    signal s_D21: std_logic_vector(31 downto 0);
    signal s_D22: std_logic_vector(31 downto 0);
    signal s_D23: std_logic_vector(31 downto 0);
    signal s_D24: std_logic_vector(31 downto 0);
    signal s_D25: std_logic_vector(31 downto 0);
    signal s_D26: std_logic_vector(31 downto 0);
    signal s_D27: std_logic_vector(31 downto 0);
    signal s_D28: std_logic_vector(31 downto 0);
    signal s_D29: std_logic_vector(31 downto 0);
    signal s_D30: std_logic_vector(31 downto 0);
    signal s_D31: std_logic_vector(31 downto 0) := x"11111100";
    signal s_OUT: std_logic_vector(31 downto 0);

begin

    DUT0: ThirtyOneToOne_Mux
        port map(
            i_SEL => s_Sel,
            i_D0 => s_D0,
            i_D1 => s_D1,
            i_D2 => s_D2,
            i_D3 => s_D3,
            i_D4 => s_D4,
            i_D5 => s_D5,
            i_D6 => s_D6,
            i_D7 => s_D7,
            i_D8 => s_D8,
            i_D9 => s_D9,
            i_D10 => s_D10,
            i_D11 => s_D11,
            i_D12 => s_D12,
            i_D13 => s_D13,
            i_D14 => s_D14,
            i_D15 => s_D15,
            i_D16 => s_D16,
            i_D17 => s_D17,
            i_D18 => s_D18,
            i_D19 => s_D19,
            i_D20 => s_D20,
            i_D21 => s_D21,
            i_D22 => s_D22,
            i_D23 => s_D23,
            i_D24 => s_D24,
            i_D25 => s_D25,
            i_D26 => s_D26,
            i_D27 => s_D27,
            i_D28 => s_D28,
            i_D29 => s_D29,
            i_D30 => s_D30,
            i_D31 => s_D31,
            o_OUT => s_OUT
        );
    
    P_TEST_CASES: process
        begin
            s_SEL <= "00000";
            wait for 50 ns;

            s_SEL <= "11111";
            wait for 50 ns;

            s_SEL <= "01111";
            wait for 50 ns;
        end process;
end mixed;