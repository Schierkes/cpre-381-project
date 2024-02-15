library IEEE;
use IEEE.std_logic_1164.all;

entity RegFile is 
    generic(N: integer := 32);
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
end RegFile;

architecture structure of RegFile is

    component mux2t1 
        port(
            sel: in std_logic;
            a: in std_logic;
            b: in std_logic;
            o: out std_logic
            );
    end component;

    component Decoder
        port(
            i_SEL: in std_logic_vector(4 downto 0);
            i_WE: in std_logic;
            o_OUT: out std_logic_vector(31 downto 0)
        );
    end component;

    component N_Bit_Reg
        port(
            i_ReadWrite: in std_logic;
            i_Data : in std_logic_vector(N-1 downto 0);
            i_CLK : in std_logic;
            i_CLR : in std_logic;
            o_Output : out std_logic_vector(N-1 downto 0)
        );
    end component;

    component ThirtyOneToOne_Mux
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

    type reg is array(0 to 31) of std_logic_vector(31 downto 0);

    signal s_writeBus: std_logic_vector(31 downto 0);
    signal reg_outs: reg;

begin

    g_Decoder: Decoder
        port map(
            i_SEL => i_writeAddress,
            i_WE => i_readWrite,
            o_OUT => s_writeBus
        );

    g_regZero: N_Bit_Reg
        port map(
            i_data => i_data,
            i_ReadWrite => s_writeBus(0),
            i_CLR => '1',
            i_CLK => i_CLK,
            o_Output => reg_outs(0)
        );

    g_Registers: for i in 1 to N-1 generate
        regi: N_Bit_Reg
            port map(
                i_data => i_data,
                i_ReadWrite => s_writeBus(i),
                i_CLR => i_CLR,
                i_CLK => i_CLK,
                o_Output => reg_outs(i)
            );
    end generate;

    g_output1_Mux: ThirtyOneToOne_Mux
        port map(
            i_SEL => i_address1,
            i_D0 => reg_outs(0),
            i_D1 => reg_outs(1),
            i_D2 => reg_outs(2),
            i_D3 => reg_outs(3),
            i_D4 => reg_outs(4),
            i_D5 => reg_outs(5),
            i_D6 => reg_outs(6),
            i_D7 => reg_outs(7),
            i_D8 => reg_outs(8),
            i_D9 => reg_outs(9),
            i_D10 => reg_outs(10),
            i_D11 => reg_outs(11),
            i_D12 => reg_outs(12),
            i_D13 => reg_outs(13),
            i_D14 => reg_outs(14),
            i_D15 => reg_outs(15),
            i_D16 => reg_outs(16),
            i_D17 => reg_outs(17),
            i_D18 => reg_outs(18),
            i_D19 => reg_outs(19),
            i_D20 => reg_outs(20),
            i_D21 => reg_outs(21),
            i_D22 => reg_outs(22),
            i_D23 => reg_outs(23),
            i_D24 => reg_outs(24),
            i_D25 => reg_outs(25),
            i_D26 => reg_outs(26),
            i_D27 => reg_outs(27),
            i_D28 => reg_outs(28),
            i_D29 => reg_outs(29),
            i_D30 => reg_outs(30),
            i_D31 => reg_outs(31),
            o_Out => o_A
        );

    g_output2_Mux: ThirtyOneToOne_Mux
        port map(
            i_SEL => i_address2,
            i_D0 => reg_outs(0),
            i_D1 => reg_outs(1),
            i_D2 => reg_outs(2),
            i_D3 => reg_outs(3),
            i_D4 => reg_outs(4),
            i_D5 => reg_outs(5),
            i_D6 => reg_outs(6),
            i_D7 => reg_outs(7),
            i_D8 => reg_outs(8),
            i_D9 => reg_outs(9),
            i_D10 => reg_outs(10),
            i_D11 => reg_outs(11),
            i_D12 => reg_outs(12),
            i_D13 => reg_outs(13),
            i_D14 => reg_outs(14),
            i_D15 => reg_outs(15),
            i_D16 => reg_outs(16),
            i_D17 => reg_outs(17),
            i_D18 => reg_outs(18),
            i_D19 => reg_outs(19),
            i_D20 => reg_outs(20),
            i_D21 => reg_outs(21),
            i_D22 => reg_outs(22),
            i_D23 => reg_outs(23),
            i_D24 => reg_outs(24),
            i_D25 => reg_outs(25),
            i_D26 => reg_outs(26),
            i_D27 => reg_outs(27),
            i_D28 => reg_outs(28),
            i_D29 => reg_outs(29),
            i_D30 => reg_outs(30),
            i_D31 => reg_outs(31),
            o_Out => o_B
        );
        
end structure;