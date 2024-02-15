library IEEE;
use IEEE.std_logic_1164.all;

entity tb_N_Bit_Reg is
    generic(N: integer := 32; gCLK_HPER: time := 50 ns);
end tb_N_Bit_Reg;

architecture mixed of tb_N_Bit_Reg is
    constant cCLK_PER  : time := gCLK_HPER * 2;
    component N_Bit_Reg is
        port(
            i_ReadWrite: in std_logic;
            i_Data : in std_logic_vector(N-1 downto 0);
            i_CLK : in std_logic;
            i_CLR : in std_logic;
            o_Output : out std_logic_vector(N-1 downto 0)
        );
    end component;

    signal s_RW, s_CLK, s_CLR: std_logic;
    signal s_D, s_OUT: std_logic_vector(N-1 downto 0);

begin

    DUT0: N_Bit_Reg
        port map(
            i_ReadWrite => s_RW,
            i_CLK => s_CLK,
            i_CLR => s_CLR,
            i_Data => s_D,
            o_Output => s_OUT
        );

    P_CLK: process
    begin
        s_CLK <= '0';
        wait for gCLK_HPER;
        s_CLK <= '1';
        wait for gCLK_HPER;
    end process;

    P_TB: process
    begin
        s_CLR <= '1';
        s_D <= x"00000000";
        s_RW <= '0';
        wait for cCLK_PER;

        s_CLR <= '0';
        s_D <= x"11111111";
        s_RW <= '1';
        wait for cCLK_PER;

        s_CLR <= '0';
        s_D <= x"00000000";
        s_RW <= '0';
        wait for cCLK_PER;

        s_CLR <= '1';
        s_D <= x"11111111";
        s_RW <= '0';
        wait for cCLK_PER;

    end process;
end mixed;