library IEEE;
use IEEE.std_logic_1164.all;

entity NBitAdder is 
    generic(N: integer := 32);
    port(
        i_X: in std_logic_vector(N-1 downto 0);
        i_Y: in std_logic_vector(N-1 downto 0);
        i_Cin: in std_logic;
        o_Sum: out std_logic_vector(N-1 downto 0);
        o_Cout: out std_logic;
        o_OverFlow: out std_logic
    );
end NBitAdder;

architecture structure of NBitAdder is

    component FullAdder is
        port(
            iX: in std_logic;
            iY: in std_logic;
            iZ: in std_logic;
            oSum: out std_logic;
            oCarry: out std_logic
        );
    end component;

    signal s_Carry: std_logic_vector(N-1 downto 0);
    
begin
    g_0_Adder: FullAdder
        port map(
            iX => i_X(0),
            iY => i_Y(0),
            iZ => i_Cin,
            oSum => o_Sum(0),
            oCarry => s_Carry(0)
        );

    g_OneToNMinusTwo_Adders: for i in 1 to N-2 generate
        Adders: FullAdder
            port Map(
                iX => i_X(i),
                iY => i_Y(i),
                iZ => s_Carry(i-1),
                oSum => o_Sum(i),
                oCarry => s_Carry(i)
            );
    end generate g_OneToNMinusTwo_Adders;
    
    g_NMinusOneAdder: FullAdder
        port Map(
            iX => i_X(N-1),
            iY => i_Y(N-1),
            iZ => s_Carry(N-2),
            oSum => o_Sum(N-1),
            oCarry => s_Carry(N-1)
        );
    
    o_Cout <= s_Carry(N-1);
    o_OverFlow <= s_Carry(N-1) Xor s_Carry(N-2);
end structure;

