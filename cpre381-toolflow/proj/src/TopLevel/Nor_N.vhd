library IEEE;
use IEEE.std_logic_1164.all;

entity Nor_N is 
    generic(N : integer := 32);
    port(
        i_A : in std_logic_vector(31 downto 0);
        i_B : in std_logic_vector(31 downto 0);
        o_Out : out std_logic_vector(31 downto 0)
    );
end Nor_N;

architecture structral of Nor_N is
    
    component norg2 is
        port(
            i_A          : in std_logic;
            i_B          : in std_logic;
            o_F          : out std_logic
        );
    end component;

begin

    G_NBit_Nor: for i in 0 to N-1 generate
        ANDI: norg2 
            port map(
                i_A => i_A(i),
                i_B => i_B(i),
                o_F => o_Out(i)
            );
    end generate G_NBit_Nor;
    
end architecture structral;