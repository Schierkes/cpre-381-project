library IEEE;
use IEEE.std_logic_1164.all;

entity tb_ImmediAdder is
    generic(N : integer := 32);
end tb_ImmediAdder;

architecture mixed of tb_ImmediAdder is

    component ImmediAdder is
        port(
            i_X: in std_logic_vector(N-1 downto 0);
            i_Y: in std_logic_vector(N-1 downto 0);
            i_immedi: in std_logic_vector(N-1 downto 0);
            i_AddSub: in std_logic;
            i_ALUSrc: in std_logic;
            o_Sum: out std_logic_vector(N-1 downto 0);
            o_Cout: out std_logic
        );
    end component;

    signal s_ALUSrc, s_AddSub, s_Cout: std_logic;
    signal s_X, s_Y, s_Sum, s_immedi: std_logic_vector(N-1 downto 0);

begin 
    
    DUT0: ImmediAdder
        port map(
            i_X => s_X,
            i_Y => s_Y,
            i_immedi => s_immedi,
            i_AddSub => s_AddSub,
            i_ALUSrc => s_ALUSrc,
            o_Sum => s_Sum,
            o_Cout => s_Cout
        );

    P_TEST_CASES: process
    begin

        s_X <= x"00001010";
        s_Y <= x"00001011";
        s_immedi <= x"00000001";
        s_AddSub <= '0';
        s_ALUSrc <= '0';
        wait for 100 ns;

        s_X <= x"00001010";
        s_Y <= x"00001011";
        s_immedi <= x"00000001";
        s_AddSub <= '1';
        s_ALUSrc <= '0';
        wait for 100 ns;

        s_X <= x"00001010";
        s_Y <= x"00001011";
        s_immedi <= x"00000001";
        s_AddSub <= '0';
        s_ALUSrc <= '1';
        wait for 100 ns;

        s_X <= x"00001010";
        s_Y <= x"00001011";
        s_immedi <= x"00000001";
        s_AddSub <= '1';
        s_ALUSrc <= '1';
        wait for 100 ns;
        
    end process;
end mixed;