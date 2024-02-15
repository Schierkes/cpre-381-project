library IEEE;
use IEEE.std_logic_1164.all;

entity SimpMIPSDatapath is
    generic(N : integer := 32);
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
end SimpMIPSDatapath;

architecture structure of SimpMIPSDatapath is

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

    signal s_A, s_b, s_data: std_logic_vector(31 downto 0);

begin

    g_fileRegs: RegFile
        port Map(
            i_data => s_data,
            i_address1 => i_rs,
            i_address2 => i_rt,
            i_writeAddress => i_rd,
            i_ReadWrite => i_wrEN,
            i_CLK => i_CLK,
            i_CLR => i_CLR,
            o_A => s_A,
            o_B => s_B
        );
    
    g_adder: ImmediAdder
        port Map(
            i_X => s_A,
            i_Y => s_B,
            i_immedi => i_immediate,
            i_AddSub => i_subSel,
            i_ALUSrc => i_immSel,
            o_Sum => s_data
        );
end structure;