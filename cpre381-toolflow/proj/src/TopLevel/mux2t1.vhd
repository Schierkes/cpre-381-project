library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1 is
	port(
		sel: in std_logic;
		a: in std_logic;
		b: in std_logic;
		o: out std_logic
		);
end mux2t1;

architecture structure of mux2t1 is
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

	signal nS: std_logic;
	signal nSB :std_logic;
	signal SA: std_logic;

begin

	nS <= not sel;

	g_and1: andg2
		port MAP(
			i_A => nS,
			i_B => b,
			o_F => nSB
		);
	
	g_and2: andg2
		port MAP(
			i_A => sel,
			i_B => a,
			o_F => SA
		);
	g_or1: org2
		port Map(
			i_A => nSB,
			i_B => SA,
			o_F => o
		);
	
end architecture structure;
	     