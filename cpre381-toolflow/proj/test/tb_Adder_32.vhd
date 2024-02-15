library IEEE;
use IEEE.std_logic_1164.all;

entity tb_Adder_32 is 
end tb_Adder_32;

architecture tb of tb_Adder_32 is
    component Adder_32
        port(i_C          : in std_logic;
             i_A          : in std_logic_vector(31 downto 0);
             i_B          : in std_logic_vector(31 downto 0);
             o_C	        : out std_logic;
             o_S          : out std_logic_vector(31 downto 0));
    end component;

    signal s_iC,s_oC : std_logic;
    signal s_A, s_B, s_s : std_logic_vector(31 downto 0);

begin

    UUT: entity work.Adder_32
            port map (i_C => s_iC, i_A => s_A, i_B => s_B, o_C => s_oC, o_S => s_S);

            s_iC <= '0';
            s_A <= x"00000000", x"11111111" after 40 ns, x"11100000" after 80 ns, x"11000111" after 120 ns;
            s_B <= x"00000000", x"00000000" after 40 ns, x"00000000" after 80 ns, x"00000011" after 120 ns;
end tb;