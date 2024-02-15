library IEEE;
use IEEE.std_logic_1164.all;

entity tb_shift2bit_26 is
end tb_shift2bit_26;

architecture tb of tb_shift2bit_26 is
    
    component shift2bit_26
        port(iShift : in std_logic_vector(25 downto 0);
             oShift : out std_logic_vector(27 downto 0)); 
    end component;

    signal s_iShift1 : std_logic_vector(25 downto 0);
    signal s_oShift1 : std_logic_vector(27 downto 0);

begin
    DUT1: shift2bit_26
        port map(iShift => s_iShift1, oShift => s_oShift1);

    P_TEST_CASES: process
        begin
            s_iShift1 <= "00000000000000000000000000";
            wait for 50 ns;
            --expected output "0000000000000000000000000000"

            s_iShift1 <= "11111111111111111111111111";
            wait for 50 ns;
            --expected output "1111111111111111111111111100"

            s_iShift1 <= "11111000001111100000111110";
            wait for 50 ns;
            --expected output "1111100000111110000011111000"  

            s_iShift1 <= "10101010101010101010101010";
            wait for 50 ns;
            --expected output "1010101010101010101010101000"

            s_iShift1 <= "01010101010101010101010101";
            wait for 50 ns;
            --expected output "0101010101010101010101010100"
        end process;        
end tb;