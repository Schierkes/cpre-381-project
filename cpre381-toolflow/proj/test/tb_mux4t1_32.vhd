library ieee;
use ieee.std_logic_1164.all;

entity tb_mux4t1_32 is
end tb_mux4t1_32;

architecture tb of tb_mux4t1_32 is
    component mux4t1_32 
        port(i_Select : in std_logic_vector(1 downto 0);
             i_D0     : in std_logic_vector(4 downto 0);
             i_D1     : in std_logic_vector(4 downto 0);
             i_D2     : in std_logic_vector(4 downto 0);
             i_D3     : in std_logic_vector(4 downto 0);
             o_Out    : out std_logic_vector(4 downto 0));
    end component;

    signal s_Select : std_logic_vector(1 downto 0);
    signal s_D0, s_D1, s_D2, s_D3, s_Out : std_logic_vector(4 downto 0);

begin

    UUT: entity work.mux4t1_32
            port map (i_Select => s_Select, i_D0 => s_D0, i_D1 => s_D1, i_D2 => s_D2, i_D3 => s_D3, o_out => s_Out);

            s_Select <= "00", "01" after 40 ns, "10" after 80 ns, "11" after 120 ns;
            s_D3 <= "00000", "11111" after 140 ns;
            s_D2 <= "00000", "11111" after 100 ns, "00000" after 120 ns;
            s_D1 <= "00000", "11111" after 60 ns, "00000" after 80 ns;
            s_D0 <= "00000", "11111" after 20 ns, "00000" after 40 ns;
end tb;