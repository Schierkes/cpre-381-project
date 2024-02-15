library IEEE;
use IEEE.std_logic_1164.all;

entity tb_shift2bit is
end tb_shift2bit;

architecture tb of tb_shift2bit is
    
    component shift2bit
        port(iShift : in std_logic_vector(31 downto 0);
             oShift : out std_logic_vector(31 downto 0)); 
    end component;

    signal s_iShift : std_logic_vector(31 downto 0);
    signal s_oShift : std_logic_vector(31 downto 0);

begin
    DUT0: shift2bit
        port map(iShift => s_iShift, oShift => s_oShift);

    P_TEST_CASES: process
        begin
            s_iShift <= x"00000000";
            wait for 50 ns;
            --expected output "00000000"

            s_iShift <= x"FFFFFFFF";
            wait for 50 ns;
            --expected output "FFFFFFFC"

            s_iShift <= x"0F0F3333";
            wait for 50 ns;
            --expected output "3C3CCCCC"

            s_iShift <= x"F0F0F0F0";
            wait for 50 ns;
            --expected output "C3C3C3C0"

            s_iShift <= x"AAAAAAAA";
            wait for 50 ns;
            --expected output "AAAAAAA8"
        end process;        
end tb;