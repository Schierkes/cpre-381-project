library IEEE;
use IEEE.std_logic_1164.all;

entity OnesComp is
    generic(N : integer := 32);
    port(
        i_num : in std_logic_vector(N-1 downto 0);
        o_O : out std_logic_vector(N-1 downto 0)
    );
end OnesComp;

architecture structure of OnesComp is

    component invg is
        port(
            i_A : in std_logic;
            o_F : out std_logic
        );
    end component;

begin
    
    G_NBit_OnesComp: for i in 0 to N-1 generate
        Inverter: invg port map(
            i_A => i_num(i),
            o_F => o_O(i)
        );
    end generate G_NBit_OnesComp;

end structure;