library IEEE;
use IEEE.std_logic_1164.all;

entity ImmediAdder is
    generic(N : integer := 32);
    port(
        i_X: in std_logic_vector(N-1 downto 0);
        i_Y: in std_logic_vector(N-1 downto 0);
        i_immedi: in std_logic_vector(N-1 downto 0);
        i_AddSub: in std_logic;
        i_ALUSrc: in std_logic;
        o_Sum: out std_logic_vector(N-1 downto 0);
        o_Cout: out std_logic
    );
end ImmediAdder;

architecture structure of ImmediAdder is

    component NBitAdder is 
        port(
            i_X: in std_logic_vector(N-1 downto 0);
            i_Y: in std_logic_vector(N-1 downto 0);
            i_Cin: in std_logic;
            o_Sum: out std_logic_vector(N-1 downto 0);
            o_Cout: out std_logic
        );
    end component;

    component OnesComp is 
        port(
            i_num : in std_logic_vector(N-1 downto 0);
            o_O : out std_logic_vector(N-1 downto 0)
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

    Signal input, notInput, valueToAdd: std_logic_vector(N-1 downto 0);

begin

    g_nY: OnesComp
        port map(
            i_num => input,
            o_O => notInput
        );

    g_immediSelect: mux2t1_N
        port map(
            i_S => i_ALUSrc,
            i_D0 => i_Y,
            i_D1 => i_immedi,
            o_O => input
        );

    g_AddorSub: mux2t1_N
        port map(
            i_S => i_AddSub,
            i_D0 => input,
            i_D1 => notInput,
            o_O => valueToAdd
        );

    g_Adder: NBitAdder
        port map(
            i_X => i_X,
            i_Y => valueToAdd,
            i_Cin => i_AddSub,
            o_Sum => o_Sum,
            o_Cout => o_Cout
        );

end architecture structure;