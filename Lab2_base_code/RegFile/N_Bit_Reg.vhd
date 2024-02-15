library IEEE;
use IEEE.std_logic_1164.all;

entity N_Bit_Reg is
    generic(N: integer := 32);
    port(
        i_ReadWrite: in std_logic;
        i_Data : in std_logic_vector(N-1 downto 0);
        i_CLK : in std_logic;
        i_CLR : in std_logic;
        o_Output : out std_logic_vector(N-1 downto 0)
    );
end N_Bit_Reg;

architecture mixed of N_Bit_Reg is

    component dffg is
        port(
            i_CLK        : in std_logic;     -- Clock input
            i_RST        : in std_logic;     -- Reset input
            i_WE         : in std_logic;     -- Write enable input
            i_D          : in std_logic;     -- Data value input
            o_Q          : out std_logic
        ); 
    end component;

begin

    g_Register: for i in 0 to N-1 generate
        flipFlops: dffg
            port map(
                i_CLK => i_CLK,
                i_RST => i_CLR,
                i_WE => i_ReadWrite,
                i_D => i_Data(i),
                o_Q => o_Output(i)
            );
    end generate;

end mixed; 