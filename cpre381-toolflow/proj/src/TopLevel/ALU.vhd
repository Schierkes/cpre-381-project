library IEEE;
use IEEE.std_logic_1164.all;

entity ALU is 
    generic(N : integer := 32);
    port(
        i_A: in std_logic_vector(31 downto 0);
        i_B: in std_logic_vector(31 downto 0);
        i_shamt: in std_logic_vector(4 downto 0);
        i_LeftRight: in std_logic;
        i_LogArth: in std_logic;
        i_AddSub: in std_logic;
        i_OpSel: in std_logic_vector(2 downto 0);
        o_ALUOut: out std_logic_vector(31 downto 0);
        o_Zero: out std_logic;
        o_OverFlow: out std_logic
    );
end ALU;

architecture structral of ALU is

    component EightToOneMux is
        port(
            i_Sel: in std_logic_vector(2 downto 0);
            i_000: in std_logic_vector(31 downto 0);
            i_001: in std_logic_vector(31 downto 0);
            i_010: in std_logic_vector(31 downto 0);
            i_011: in std_logic_vector(31 downto 0);
            i_100: in std_logic_vector(31 downto 0);
            i_101: in std_logic_vector(31 downto 0);
            i_110: in std_logic_vector(31 downto 0);
            i_111: in std_logic_vector(31 downto 0);
            o_Out: out std_logic_vector(31 downto 0)
        );
    end component;

    component barrelshifter is 
        port(
            i_in	: in std_logic_vector(31 downto 0); -- input to be shifted
            i_n	: in std_logic_vector(4 downto 0); -- number of bits being shifted
            i_arithmetic	: in std_logic; -- sign value preservation
            i_dir	: in std_logic; -- directional control
            o_out	: out std_logic_vector(31 downto 0)
        ); -- output
    end component;

    component ALUAdder is
        port(
            i_X: in std_logic_vector(N-1 downto 0);
            i_Y: in std_logic_vector(N-1 downto 0);
            i_AddSub: in std_logic;
            o_Sum: out std_logic_vector(N-1 downto 0);
            o_Cout: out std_logic;
            o_OverFlow: out std_logic
        );
    end component;

    component And_N is
        port(
            i_A : in std_logic_vector(31 downto 0);
            i_B : in std_logic_vector(31 downto 0);
            o_Out : out std_logic_vector(31 downto 0)
        );
    end component;

    component Or_N is
        port(
            i_A : in std_logic_vector(31 downto 0);
            i_B : in std_logic_vector(31 downto 0);
            o_Out : out std_logic_vector(31 downto 0)
        );
    end component;

    component Xor_N is
        port(
            i_A : in std_logic_vector(31 downto 0);
            i_B : in std_logic_vector(31 downto 0);
            o_Out : out std_logic_vector(31 downto 0)
        );
    end component;

    component Nor_N is
        port(
            i_A : in std_logic_vector(31 downto 0);
            i_B : in std_logic_vector(31 downto 0);
            o_Out : out std_logic_vector(31 downto 0)
        );
    end component;
    
    component Repl is
        port(
            i_Immediate : in std_logic_vector(31 downto 0);
            o_Out : out std_logic_vector(31 downto 0)
        );
    end component;

    signal s_AdderOut, s_ShifterOut,
           s_AndOut, s_OrOut, s_XorOut, s_NorOut,
           s_ReplOut : std_logic_vector(31 downto 0);
begin
    
    OutSel: EightToOneMux
        port map(
            i_Sel => i_OpSel,
            i_000 => s_AdderOut,
            i_001 => s_ShifterOut,
            i_010 => s_AndOut,
            i_011 => s_OrOut,
            i_100 => s_XorOut,
            i_101 => s_NorOut,
            i_110 => s_ReplOut,
            i_111 => x"00000000",
            o_out => o_ALUOut
        );

    Adder: ALUAdder
        port map(
            i_X => i_A,
            i_Y => i_B,
            i_AddSub => i_AddSub,
            o_Sum => s_AdderOut,
            o_OverFlow => o_OverFlow
        );

    shifter: barrelshifter
        port map(
            i_in => i_A,
            i_n => i_shamt,
            i_arithmetic => i_LogArth,
            i_dir => i_LeftRight,
            o_out => s_ShifterOut
        );

    Ander: And_N
        port map(
            i_A => i_A,
            i_B => i_B,
            o_Out => s_AndOut
        );
        
    Orer: Or_N
        port map(
            i_A => i_A,
            i_B => i_B,
            o_Out => s_OrOut
        );

    Xorer: Xor_N
        port map(
            i_A => i_A,
            i_B => i_B,
            o_Out => s_XorOut
        );

    Norer: Nor_N
        port map(
            i_A => i_A,
            i_B => i_B,
            o_Out => s_NorOut
        );

    Replace: Repl
        port map(
            i_Immediate => i_B,
            o_out => s_ReplOut
        );
    
    o_Zero <= 
            '1' when (s_AdderOut = x"00000000") else
            '0';
end architecture structral;