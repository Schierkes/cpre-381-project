library IEEE;
use IEEE.std_logic_1164.all;

entity Control is 
    port(
        i_Opcode: in std_logic_vector(5 downto 0);
        i_Funct: in std_logic_vector(5 downto 0);
        o_ALUOp: out std_logic_vector(2 downto 0);
        o_ALUSrc: out std_logic;
        o_ZeroSignExt: out std_logic;
        o_RegToMem: out std_logic;
        o_RegWr: out std_logic;
        o_RegDst: out std_logic_vector(1 downto 0);
        o_DMemWr: out std_logic;
        o_Branch: out std_logic;
        o_BranchNeq: out std_logic;
        o_Jump: out std_logic;
        o_Jr: out std_logic;
        o_Jal: out std_logic;
        o_Movn: out std_logic
    );
end Control;

architecture dataflow of Control is
begin
    with i_Opcode select
        o_ALUOp <= 
            "000" when "000000",
            "010" when "000100",
            "010" when "000101",
            "001" when "001000",
            "001" when "001001",
            "010" when "001010",
            "011" when "001100",
            "100" when "001101", 
            "101" when "001110", 
            "110" when "001111", 
            "111" when "011111",
            "001" when "100011", 
            "001" when "101011",
            "XXX" when others;

    with i_Opcode select
        o_ALUSrc <= 
            '0' when "000000",
            '0' when "000100",
            '0' when "000101",
            '1' when "001000",
            '1' when "001001",
            '1' when "001010",
            '1' when "001100",
            '1' when "001101", 
            '1' when "001110", 
            '1' when "001111", 
            '1' when "011111", 
            '1' when "100011", 
            '1' when "101011",
            'X' when others;

    with i_Opcode select
        o_ZeroSignExt <= 
            '1' when "001000",
            '1' when "001001",
            '1' when "001010",
            '0' when "001100",
            '0' when "001101", 
            '0' when "001110", 
            '0' when "001111", 
            '0' when "011111",
            '1' when "100011", 
            '1' when "101011",
            'X' when others;

    with i_Opcode select
        o_RegToMem <= 
            '0' when "000000",
            '0' when "001000",
            '0' when "001001",
            '0' when "001010",
            '0' when "001100",
            '0' when "001101", 
            '0' when "001110", 
            '0' when "001111", 
            '0' when "011111",
            '1' when "100011", 
            '0' when "101011",
            'X' when others;
    
    o_RegWr <= 
        '1' when (i_Opcode = "000000" and i_Funct /= "001000") else 
        '0' when (i_Opcode = "000000" and i_Funct = "001000") else
        '0' when (i_Opcode = "000010") else
        '1' when (i_Opcode = "000011") else
        '0' when (i_Opcode = "000100") else
        '0' when (i_Opcode = "000101") else
        '1' when (i_Opcode = "001000") else
        '1' when (i_Opcode = "001001") else
        '1' when (i_Opcode = "001010") else
        '1' when (i_Opcode = "001100") else
        '1' when (i_Opcode = "001101") else
        '1' when (i_Opcode = "001110") else
        '1' when (i_Opcode = "001111") else
        '1' when (i_Opcode = "011111") else
        '1' when (i_Opcode = "100011") else
        '0' when (i_Opcode = "101011") else
        'X';

    o_RegDst <= 
        "01" when (i_Opcode = "000000" and i_Funct /= "001011") else
        "11" when (i_Opcode = "000000" and i_Funct = "001011") else 
        "10" when (i_Opcode = "000011") else
        "00" when (i_Opcode = "001000") else
        "00" when (i_Opcode = "001001") else
        "00" when (i_Opcode = "001010") else
        "00" when (i_Opcode = "001100") else
        "00" when (i_Opcode = "001101") else
        "00" when (i_Opcode = "001110") else
        "00" when (i_Opcode = "001111") else
        "00" when (i_Opcode = "011111") else
        "00" when (i_Opcode = "100011") else
        "00" when (i_Opcode = "101011") else
        "XX";

    with i_Opcode select
        o_DMemWr <= 
            '1' when "101011",
            '0' when others;
    
    with i_Opcode select
        o_Branch <= 
            '1' when "000100",
            '0' when others;

    with i_Opcode select
        o_BranchNeq <= 
            '1' when "000101",
            '0' when others;

    o_Jump <= 
        '1' when (i_Funct = "001000") else 
        '1' when (i_Opcode = "000010") else 
        '1' when (i_Opcode = "000011") else 
        '0';

    o_Jr <=
        '1' when (i_Funct = "001000") else
        '0';

    with i_Opcode select
        o_Jal <= 
            '1' when "000011",
            '0' when others;

    o_Movn <= 
        '1' when (i_Opcode = "000000" and i_Funct = "001011") else
        '0';
end dataflow;