library IEEE;
use IEEE.std_logic_1164.all;

entity tb_FileReg is
    generic(N: integer := 32; gCLK_HPER: time := 50 ns);
end entity;

architecture mixed of tb_FileReg is
    constant cCLK_PER  : time := gCLK_HPER * 2;

    component RegFile is 
        port(
            i_data: in std_logic_vector(31 downto 0);
            i_address1: in std_logic_vector(4 downto 0);
            i_address2: in std_logic_vector(4 downto 0);
            i_writeAddress: in std_logic_vector(4 downto 0);
            i_readWrite: in std_logic;
            i_CLR: in std_logic;
            i_CLK: in std_logic;
            o_A: out std_logic_vector(31 downto 0);
            o_B: out std_logic_vector(31 downto 0)
        );
    end component;

    signal s_data, s_A, s_B: std_logic_vector(31 downto 0);
    signal s_address1, s_address2, s_writeAddress : std_logic_vector(4 downto 0);
    signal s_readWrite, s_CLK, s_CLR: std_logic;

begin

    DUT0: RegFile
        port map(
            i_data => s_data,
            i_address1 => s_address1, 
            i_address2 => s_address2,
            i_writeAddress => s_writeAddress,
            i_readWrite => s_readWrite,
            i_CLR => s_CLR,
            i_CLK => s_CLK,
            o_A => s_A,
            o_B => s_B
        );

    P_CLK: process
    begin
        s_CLK <= '0';
        wait for gCLK_HPER;
        s_CLK <= '1';
        wait for gCLK_HPER;
    end process;

    P_TEST_CASES: process
    begin
        s_data <= x"00000000";
        s_address1 <= "00001";
        s_address2 <= "00000";
        s_writeAddress <= "00000";
        s_readWrite <= '0';
        s_CLR <= '1';
        wait for cCLK_PER;

        s_data <= x"00000010";
        s_address1 <= "00001";
        s_address2 <= "00000";
        s_writeAddress <= "00001";
        s_readWrite <= '1';
        s_CLR <= '0';
        wait for cCLK_PER;

        s_data <= x"00000001";
        s_address1 <= "00001";
        s_address2 <= "00010";
        s_writeAddress <= "00010";
        s_readWrite <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;

        s_data <= x"00000001";
        s_address1 <= "00001";
        s_address2 <= "00010";
        s_writeAddress <= "00010";
        s_readWrite <= '1';
        s_CLR <= '0';
        wait for cCLK_PER;

        s_data <= x"00000001";
        s_address1 <= "00001";
        s_address2 <= "00010";
        s_writeAddress <= "00010";
        s_readWrite <= '0';
        s_CLR <= '0';
        wait for cCLK_PER;
    end process;
end mixed;