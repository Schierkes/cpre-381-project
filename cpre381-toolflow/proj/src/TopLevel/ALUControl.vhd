library IEEE;
use IEEE.std_logic_1164.all;

entity ALUControl is
    port(
        i_ALUOp: in std_logic_vector(2 downto 0);
        i_Funct: in std_logic_vector(5 downto 0);
        o_OpSel: out std_logic_vector(2 downto 0);
        o_LeftRight: out std_logic;
        o_LogArth: out std_logic;
        o_AddSub: out std_logic
    );
end ALUControl;

architecture dataflow of ALUControl is
begin
    o_OpSel <= 
        "000" when (i_ALUOp = "001") else 
        "000" when (i_ALUOp = "010") else 
        "000" when (i_ALUOp = "000" and i_Funct = "100000") else
        "000" when (i_ALUOp = "000" and i_Funct = "100001") else
        "000" when (i_ALUOp = "000" and i_Funct = "100010") else
        "001" when (i_ALUOp = "110") else 
        "001" when (i_ALUOp = "000" and i_Funct = "000000") else 
        "001" when (i_ALUOp = "000" and i_Funct = "000010") else 
        "001" when (i_ALUOp = "000" and i_Funct = "000011") else 
        "010" when (i_ALUOp = "011") else
        "010" when (i_ALUOp = "000" and i_Funct = "100100") else 
        "011" when (i_ALUOp = "100") else
        "011" when (i_ALUOp = "000" and i_Funct = "100101") else 
        "100" when (i_ALUOp = "101") else
        "100" when (i_ALUOp = "000" and i_Funct = "100110") else 
        "101" when (i_ALUOp = "000" and i_Funct = "100111") else
        "110" when (i_ALUOp = "111") else 
        "XXX";

    o_LeftRight <= 
        '0' when (i_ALUOp = "110") else 
        '0' when (i_ALUOp = "000" and i_Funct = "000000") else
        '1' when (i_ALUOp = "000" and i_Funct = "000010") else 
        '1' when (i_ALUOp = "000" and i_Funct = "000011") else 
        'X';

    o_LogArth <=
        '0' when (i_ALUOp = "110") else 
        '0' when (i_ALUOp = "000" and i_Funct = "000000") else
        '0' when (i_ALUOp = "000" and i_Funct = "000010") else 
        '1' when (i_ALUOp = "000" and i_Funct = "000011") else 
        'X';
    
    o_AddSub <=
        '0' when (i_ALUOp = "001") else
        '1' when (i_ALUOp = "010") else
        '0' when (i_ALUOp = "000" and i_Funct = "100000") else 
        '0' when (i_ALUOp = "000" and i_Funct = "100001") else 
        '1' when (i_ALUOp = "000" and i_Funct = "100010") else
        'X';
    
end architecture dataflow;