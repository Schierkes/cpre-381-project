library ieee;
use ieee.std_logic_1164.all;

entity tb_mux2t1_32 is
end tb_mux2t1_32;

architecture tb of tb_mux2t1_32 is
    component mux2t1_32 
        port(i_Select : in std_logic;
             i_D0     : in std_logic_vector(31 downto 0);
             i_D1     : in std_logic_vector(31 downto 0);
             o_Out    : out std_logic_vector(31 downto 0));
    end component;

    signal s_Select : std_logic;
    signal s_D0, s_D1, s_Out : std_logic_vector(31 downto 0);

begin

    UUT: entity work.mux2t1_32
            port map (i_Select => s_Select, i_D0 => s_D0, i_D1 => s_D1, o_out => s_Out);

            s_Select <= '0', '1' after 80 ns;
            s_D1 <= x"00000000", x"11111111" after 40 ns, x"00000000" after 80 ns, x"11111111" after 120 ns;
            s_D0 <= x"00000000", x"11111111" after 20 ns, x"00000000" after 40 ns, x"11111111" after 60 ns, x"00000000" after 80 ns, x"11111111" after 100 ns, x"00000000" after 120 ns, x"11111111" after 140 ns;

end tb;