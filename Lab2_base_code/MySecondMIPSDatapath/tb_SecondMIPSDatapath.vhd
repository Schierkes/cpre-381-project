library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_SecondMIPSDatapath is
    generic(
        N : integer := 32;
        DATA_WIDTH : natural := 32;
        ADDR_WIDTH : natural := 10;
        gCLK_HPER: time := 50 ns
    );
end tb_SecondMIPSDatapath;

architecture mixed of tb_SecondMIPSDatapath is
    constant cCLK_PER  : time := gCLK_HPER * 2;
    component SecondMIPSDatapath is
        port(
            i_immediate: in std_logic_vector(15 downto 0);
            i_rs: in std_logic_vector(4 downto 0);
            i_rt: in std_logic_vector(4 downto 0);
            i_rd: in std_logic_vector(4 downto 0);
            i_regOrMem: in std_logic;
            i_immExt: in std_logic;
            i_memWE: in std_logic;
            i_regWE: in std_logic;
            i_subSel: in std_logic;
            i_immSel: in std_logic;
            i_CLR: in std_logic;
            i_CLK: in std_logic
        );
    end component;

    signal s_immediate: std_logic_vector(15 downto 0);
    signal s_rs, s_rt, s_rd: std_logic_vector(4 downto 0);
    signal s_regOrMem, s_immExt, s_memWE, s_regWE, s_subSel, s_immSel,
           s_CLR, s_CLK: std_logic;

begin

    DUT0: SecondMIPSDatapath
        port map(
            i_immediate => s_immediate,
            i_rs => s_rs,
            i_rt => s_rt,
            i_rd => s_rd,
            i_regOrMem => s_regOrMem,
            i_immExt => s_immExt,
            i_memWE => s_memWE,
            i_regWE => s_regWE,
            i_subSel => s_subSel,
            i_immSel => s_immSel,
            i_CLR => s_CLR,
            i_CLK => s_CLK
        );

    P_Clock: process
    begin
        s_CLK <= '0';
        wait for gCLK_HPER;
        s_CLK <= '1';
        wait for gCLK_HPER;
    end process;

    P_TEST_CASES: process
    begin
        -- addi 25, 0, 0
        s_rd <= "11001";
        s_rs <= "00000";
        s_rt <= "00000";
        s_immediate <= x"0000";
        s_regWE <= '1';
        s_memWE <= '0';
        s_regOrMem <= '0';
        s_immExt <= '1';
        s_immSel <= '1';
        s_subSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- addi 26, 0, 256
        s_rd <= "11010";
        s_rs <= "00000";
        s_rt <= "00000";
        s_immediate <= x"0100";
        s_regWE <= '1';
        s_memWE <= '0';
        s_regOrMem <= '0';
        s_immExt <= '1';
        s_immSel <= '1';
        s_subSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- lw 1, 0(25)
        s_rd <= "00001";
        s_rs <= "11001";
        s_rt <= "00000";
        s_immediate <= x"0000";
        s_regWE <= '1';
        s_memWE <= '0';
        s_regOrMem <= '1';
        s_immExt <= '1';
        s_immSel <= '1';
        s_subSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- lw 2, 4(25)
        s_rd <= "00010";
        s_rs <= "11001";
        s_rt <= "00000";
        s_immediate <= x"0004";
        s_regWE <= '1';
        s_memWE <= '0';
        s_regOrMem <= '1';
        s_immExt <= '1';
        s_immSel <= '1';
        s_subSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- Add 1, 1, 2
        s_rd <= "00001";
        s_rs <= "00001";
        s_rt <= "00010";
        s_immediate <= x"0000";
        s_regWE <= '1';
        s_memWE <= '0';
        s_regOrMem <= '0';
        s_immExt <= '1';
        s_immSel <= '0';
        s_subSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- sw 1, 0(26)
        s_rd <= "00000";
        s_rs <= "11010";
        s_rt <= "00001";
        s_immediate <= x"0000";
        s_regWE <= '0';
        s_memWE <= '1';
        s_regOrMem <= '1';
        s_immExt <= '1';
        s_immSel <= '1';
        s_subSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- lw 2, 8 (25)
        s_rd <= "00010";
        s_rs <= "11001";
        s_rt <= "00000";
        s_immediate <= x"0008";
        s_regWE <= '1';
        s_memWE <= '0';
        s_regOrMem <= '1';
        s_immExt <= '1';
        s_immSel <= '1';
        s_subSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- add 1, 1, 2
        s_rd <= "00001";
        s_rs <= "00001";
        s_rt <= "00010";
        s_immediate <= x"0000";
        s_regWE <= '1';
        s_memWE <= '0';
        s_regOrMem <= '0';
        s_immExt <= '1';
        s_immSel <= '0';
        s_subSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- sw 1, 4(26)
        s_rd <= "00000";
        s_rs <= "11010";
        s_rt <= "00001";
        s_immediate <= x"0004";
        s_regWE <= '0';
        s_memWE <= '1';
        s_regOrMem <= '1';
        s_immExt <= '1';
        s_immSel <= '1';
        s_subSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- lw 2, 12(25)
        s_rd <= "00010";
        s_rs <= "11001";
        s_rt <= "00000";
        s_immediate <= x"000C";
        s_regWE <= '1';
        s_memWE <= '0';
        s_regOrMem <= '1';
        s_immExt <= '1';
        s_immSel <= '1';
        s_subSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- add 1, 1, 2
        s_rd <= "00001";
        s_rs <= "00001";
        s_rt <= "00010";
        s_immediate <= x"0000";
        s_regWE <= '1';
        s_memWE <= '0';
        s_regOrMem <= '0';
        s_immExt <= '1';
        s_immSel <= '0';
        s_subSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- sw 1, 8(26)
        s_rd <= "00000";
        s_rs <= "11010";
        s_rt <= "00001";
        s_immediate <= x"0008";
        s_regWE <= '0';
        s_memWE <= '1';
        s_regOrMem <= '1';
        s_immExt <= '1';
        s_immSel <= '1';
        s_subSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- lw 2, 16(25)
        s_rd <= "00010";
        s_rs <= "11001";
        s_rt <= "00000";
        s_immediate <= x"0010";
        s_regWE <= '1';
        s_memWE <= '0';
        s_regOrMem <= '1';
        s_immExt <= '1';
        s_immSel <= '1';
        s_subSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- add 1, 1, 2
        s_rd <= "00001";
        s_rs <= "00001";
        s_rt <= "00010";
        s_immediate <= x"0000";
        s_regWE <= '1';
        s_memWE <= '0';
        s_regOrMem <= '0';
        s_immExt <= '1';
        s_immSel <= '0';
        s_subSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- sw 1, 12(26)
        s_rd <= "00000";
        s_rs <= "11010";
        s_rt <= "00001";
        s_immediate <= x"000C";
        s_regWE <= '0';
        s_memWE <= '1';
        s_regOrMem <= '1';
        s_immExt <= '1';
        s_immSel <= '1';
        s_subSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- lw 2, 20(25)
        s_rd <= "00010";
        s_rs <= "11001";
        s_rt <= "00000";
        s_immediate <= x"0014";
        s_regWE <= '1';
        s_memWE <= '0';
        s_regOrMem <= '1';
        s_immExt <= '1';
        s_immSel <= '1';
        s_subSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- add 1, 1, 2
        s_rd <= "00001";
        s_rs <= "00001";
        s_rt <= "00010";
        s_immediate <= x"0000";
        s_regWE <= '1';
        s_memWE <= '0';
        s_regOrMem <= '0';
        s_immExt <= '1';
        s_immSel <= '0';
        s_subSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- sw 1, 16(26)
        s_rd <= "00000";
        s_rs <= "11010";
        s_rt <= "00001";
        s_immediate <= x"0010";
        s_regWE <= '0';
        s_memWE <= '1';
        s_regOrMem <= '1';
        s_immExt <= '1';
        s_immSel <= '1';
        s_subSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- lw 2, 24(25)
        s_rd <= "00010";
        s_rs <= "11001";
        s_rt <= "00000";
        s_immediate <= x"0018";
        s_regWE <= '1';
        s_memWE <= '0';
        s_regOrMem <= '1';
        s_immExt <= '1';
        s_immSel <= '1';
        s_subSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- add 1, 1, 2
        s_rd <= "00001";
        s_rs <= "00001";
        s_rt <= "00010";
        s_immediate <= x"0000";
        s_regWE <= '1';
        s_memWE <= '0';
        s_regOrMem <= '0';
        s_immExt <= '1';
        s_immSel <= '0';
        s_subSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- addi 27, 0, 512
        s_rd <= "11011";
        s_rs <= "00000";
        s_rt <= "00000";
        s_immediate <= x"0200";
        s_regWE <= '1';
        s_memWE <= '0';
        s_regOrMem <= '0';
        s_immExt <= '1';
        s_immSel <= '1';
        s_subSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- sw 1, 16(26)
        s_rd <= "00000";
        s_rs <= "11011";
        s_rt <= "00001";
        s_immediate <= x"1100";
        s_regWE <= '0';
        s_memWE <= '1';
        s_regOrMem <= '1';
        s_immExt <= '1';
        s_immSel <= '1';
        s_subSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;
    end process;
end mixed;

    