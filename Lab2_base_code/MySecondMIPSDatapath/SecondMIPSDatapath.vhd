library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity SecondMIPSDatapath is
    generic
        (
            N : integer := 32;
            DATA_WIDTH : natural := 32;
            ADDR_WIDTH : natural := 10
        );

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
end SecondMIPSDatapath;

architecture structure of SecondMIPSDatapath is

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

    component Extender is
        port(
            i_data: in std_logic_vector(15 downto 0);
            i_signSel: in std_logic;
            o_out: out std_logic_vector(31 downto 0)
        );
    end component;

    component mem is
        port(
                clk		: in std_logic;
                addr	: in std_logic_vector((ADDR_WIDTH-1) downto 0);
                data	: in std_logic_vector((DATA_WIDTH-1) downto 0);
                we		: in std_logic := '1';
                q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
            );
    end component;

    component mux2t1_N is
        port(
            i_S          : in std_logic;
            i_D0         : in std_logic_vector(N-1 downto 0);
            i_D1         : in std_logic_vector(N-1 downto 0);
            o_O          : out std_logic_vector(N-1 downto 0)
       );
    end component;

    signal s_A, s_b, s_data, s_immediate, s_adderOut, s_memOut: std_logic_vector(31 downto 0);

begin

    g_fileRegs: RegFile
        port Map(
            i_data => s_data,
            i_address1 => i_rs,
            i_address2 => i_rt,
            i_writeAddress => i_rd,
            i_ReadWrite => i_regWE,
            i_CLK => i_CLK,
            i_CLR => i_CLR,
            o_A => s_A,
            o_B => s_B
        );
    
    g_adder: ImmediAdder
        port Map(
            i_X => s_A,
            i_Y => s_B,
            i_immedi => s_immediate,
            i_AddSub => i_subSel,
            i_ALUSrc => i_immSel,
            o_Sum => s_adderOut
        );

    g_extender: Extender
        port Map(
            i_data => i_immediate,
            i_signSel => i_immExt,
            o_out => s_immediate
        );

    g_mem: mem
        port map(
            clk => i_CLK,
            addr => s_adderOut(9 downto 0),
            data => s_B,
            we => i_memWE,
            q => s_memOut
        );

    g_dataSel: mux2t1_N
        port map(
            i_S => i_regOrMem,
            i_D0 => s_adderOut,
            i_D1 => s_memOut,
            o_O => s_data
        );
end structure;