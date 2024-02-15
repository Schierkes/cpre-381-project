library IEEE;
use IEEE.std_logic_1164.all;

entity FullAdder is
    port(
        iX: in std_logic;
        iY: in std_logic;
        iZ: in std_logic;
        oSum: out std_logic;
        oCarry: out std_logic
    );
end FullAdder;

architecture structure of FullAdder is

    component andg2
		port(
			i_A: in std_logic;
			i_B: in std_logic;
			o_F: out std_logic
		);
	end component;
	
	component org2
		port(
			i_A: in std_logic;
			i_B: in std_logic;
			o_F: out std_logic
		);
	end component;

    component xorg2
        port(
            i_A          : in std_logic;
            i_B          : in std_logic;
            o_F          : out std_logic
        );
    end component;

    component invg
        port(
            i_A          : in std_logic;
            o_F          : out std_logic
        );
    end component;

    -- signals for sum
    signal nX: std_logic;
    signal YxorZ: std_logic;
    signal nXandYxorZ: std_logic;
    signal nYxorZ: std_logic;
    signal XandnYxorZ: std_logic;

    -- signals for carry
    signal YZ: std_logic;
    signal XY: std_logic;
    signal XZ: std_logic;
    signal YZorXY: std_logic;

begin
    g_notX: invg
    port map(
        i_A => iX,
        o_F => nX
    );

    g_YxorZ: xorg2
        port Map(
            i_A => iY,
            i_B => iZ,
            o_F => YxorZ
        );
    
    g_nXYxorZ: andg2
        port Map(
            i_A => nX,
            i_B => YxorZ,
            o_F => nXandYxorZ
        );

    g_nYxorZ: invg
        port Map(
            i_A => YxorZ,
            o_F => nYxorZ
        );

    g_XandnYxorZ: andg2
        port Map(
            i_A => iX,
            i_B => nYxorZ,
            o_F => XandnYxorZ
        );

    g_sum: org2
        port Map(
            i_A => nXandYxorZ,
            i_B => XandnYxorZ,
            o_F => oSum
        );

    
    g_YandZ: andg2
        port Map(
            i_A => iY,
            i_B => iZ,
            o_F => YZ
        );

    g_XandY: andg2
        port Map(
            i_A => iX,
            i_B => iY,
            o_F => XY
        );

    g_XandZ: andg2
        port Map(
            i_A => iX,
            i_B => iZ,
            o_F => XZ
        );

    g_YZorXY: org2
        port Map(
            i_A => YZ,
            i_B => XY,
            o_F => YZorXY
        );

    g_Carry: org2
        port Map(
            i_A => YZorXY,
            i_B => XZ,
            o_F => oCarry
        );
end structure;
