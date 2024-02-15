library IEEE;
use IEEE.std_logic_1164.all;

entity tb_SimpMIPSDatapath is
    generic(N: integer := 32; gCLK_HPER: time := 50 ns);
end tb_SimpMIPSDatapath;

architecture mixed of tb_SimpMIPSDatapath is
    constant cCLK_PER  : time := gCLK_HPER * 2;
    component SimpMIPSDatapath is
        port(
            i_immediate: in std_logic_vector(31 downto 0);
            i_rs: in std_logic_vector(4 downto 0);
            i_rt: in std_logic_vector(4 downto 0);
            i_rd: in std_logic_vector(4 downto 0);
            i_wrEN: in std_logic;
            i_subSel: in std_logic;
            i_immSel: in std_logic;
            i_CLR: in std_logic;
            i_CLK: in std_logic
        );
    end component;

    signal s_immediate: std_logic_vector(31 downto 0);
    signal s_rs, s_rt, s_rd: std_logic_vector(4 downto 0);
    signal s_wrEN, s_subSel, s_immSel, s_CLR, s_CLK: std_logic;

begin

    DUT0: SimpMIPSDatapath
        port Map(
            i_immediate => s_immediate,
            i_rs => s_rs,
            i_rt => s_rt,
            i_rd => s_rd,
            i_wrEN => s_wrEN,
            i_subSel => s_subSel,
            i_immSel => s_immSel,
            i_CLR => s_CLR,
            i_CLK => s_CLK
        );

    P_CLK:process
    begin
        s_CLK <= '0';
        wait for gCLK_HPER;
        s_CLK <= '1';
        wait for gCLK_HPER;
    end process;

    P_TB:process
    begin
        
        -- addi 1, 0, 1
        s_immediate <= x"00000001";
        s_rs <= "00000";
        s_rt <= "00000";
        s_rd <= "00001";
        s_wrEN <= '1'; 
        s_subSel <= '0'; 
        s_immSel <= '1';
        s_CLR <= '0';
        wait for 125 ns;

        -- addi 2, 0, 2
        s_immediate <= x"00000002";
        s_rs <= "00000";
        s_rt <= "00000";
        s_rd <= "00010";
        s_wrEN <= '1'; 
        s_subSel <= '0'; 
        s_immSel <= '1';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- addi 3, 0, 3
        s_immediate <= x"00000003";
        s_rs <= "00000";
        s_rt <= "00000";
        s_rd <= "00011";
        s_wrEN <= '1'; 
        s_subSel <= '0'; 
        s_immSel <= '1';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- addi 4, 0, 4
        s_immediate <= x"00000004";
        s_rs <= "00000";
        s_rt <= "00000";
        s_rd <= "00100";
        s_wrEN <= '1'; 
        s_subSel <= '0'; 
        s_immSel <= '1';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- addi 5, 0, 5
        s_immediate <= x"00000005";
        s_rs <= "00000";
        s_rt <= "00000";
        s_rd <= "00101";
        s_wrEN <= '1'; 
        s_subSel <= '0'; 
        s_immSel <= '1';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- addi 6, 0, 6
        s_immediate <= x"00000006";
        s_rs <= "00000";
        s_rt <= "00000";
        s_rd <= "00110";
        s_wrEN <= '1'; 
        s_subSel <= '0'; 
        s_immSel <= '1';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- addi 7, 0, 7
        s_immediate <= x"00000007";
        s_rs <= "00000";
        s_rt <= "00000";
        s_rd <= "00111";
        s_wrEN <= '1'; 
        s_subSel <= '0'; 
        s_immSel <= '1';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- addi 8, 0, 8
        s_immediate <= x"00000008";
        s_rs <= "00000";
        s_rt <= "00000";
        s_rd <= "01000";
        s_wrEN <= '1'; 
        s_subSel <= '0'; 
        s_immSel <= '1';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- addi 9, 0, 9
        s_immediate <= x"00000009";
        s_rs <= "00000";
        s_rt <= "00000";
        s_rd <= "01001";
        s_wrEN <= '1'; 
        s_subSel <= '0'; 
        s_immSel <= '1';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- addi 10, 0, 10
        s_immediate <= x"0000000A";
        s_rs <= "00000";
        s_rt <= "00000";
        s_rd <= "01010";
        s_wrEN <= '1'; 
        s_subSel <= '0'; 
        s_immSel <= '1';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- add 11, 1, 2
        s_rs <= "00001";
        s_rt <= "00010";
        s_rd <= "01011";
        s_wrEN <= '1'; 
        s_subSel <= '0'; 
        s_immSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- sub 12, 11, 3
        s_rs <= "01011";
        s_rt <= "00011";
        s_rd <= "01100";
        s_wrEN <= '1'; 
        s_subSel <= '1'; 
        s_immSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- add 13, 12, 4
        s_rs <= "01100";
        s_rt <= "00100";
        s_rd <= "01101";
        s_wrEN <= '1'; 
        s_subSel <= '0'; 
        s_immSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- sub 14, 13, 5
        s_rs <= "01101";
        s_rt <= "00101";
        s_rd <= "01110";
        s_wrEN <= '1'; 
        s_subSel <= '1'; 
        s_immSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- add 15, 14, 6
        s_rs <= "01110";
        s_rt <= "00110";
        s_rd <= "01111";
        s_wrEN <= '1'; 
        s_subSel <= '0'; 
        s_immSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- sub 16, 15, 7
        s_rs <= "01111";
        s_rt <= "00111";
        s_rd <= "10000";
        s_wrEN <= '1'; 
        s_subSel <= '1'; 
        s_immSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- add 17, 16, 8
        s_rs <= "10000";
        s_rt <= "10000";
        s_rd <= "10001";
        s_wrEN <= '1'; 
        s_subSel <= '0'; 
        s_immSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- sub 18, 17, 9
        s_rs <= "10001";
        s_rt <= "01001";
        s_rd <= "10010";
        s_wrEN <= '1'; 
        s_subSel <= '1'; 
        s_immSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- add 19, 18, 10
        s_rs <= "10010";
        s_rt <= "01010";
        s_rd <= "10011";
        s_wrEN <= '1'; 
        s_subSel <= '0'; 
        s_immSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- addi 20, 0, -35
        s_immediate <= x"FFFFFFDD";
        s_rs <= "00000";
        s_rt <= "00000";
        s_rd <= "10100";
        s_wrEN <= '1'; 
        s_subSel <= '0'; 
        s_immSel <= '1';
        s_CLR <= '0';
        wait for cCLK_PER;

        -- add 21, 19, 20
        s_rs <= "10011";
        s_rt <= "10100";
        s_rd <= "10101";
        s_wrEN <= '1'; 
        s_subSel <= '0'; 
        s_immSel <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;
    end process;
end mixed;