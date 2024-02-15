library IEEE;
use IEEE.std_logic_1164.all;

--Shifter used in fetch logic that takes a 32 bit input and shifts it left by two bits

entity shift2bit_26 is
    port(iShift : in std_logic_vector(25 downto 0);
         oShift : out std_logic_vector(27 downto 0));
end shift2bit_26;

architecture behavioral of shift2bit_26 is
    
begin
    oShift(0) <= '0'; --2 leftmost bits are always "0"
    oShift(1) <= '0';
    oShift(2) <= iShift(0); --All other bits are set to be two off of the input
    oShift(3) <= iShift(1);
    oShift(4) <= iShift(2);
    oShift(5) <= iShift(3);
    oShift(6) <= iShift(4);
    oShift(7) <= iShift(5);
    oShift(8) <= iShift(6);
    oShift(9) <= iShift(7);
    oShift(10) <= iShift(8);
    oShift(11) <= iShift(9);
    oShift(12) <= iShift(10);
    oShift(13) <= iShift(11);
    oShift(14) <= iShift(12);
    oShift(15) <= iShift(13);
    oShift(16) <= iShift(14);
    oShift(17) <= iShift(15);
    oShift(18) <= iShift(16);
    oShift(19) <= iShift(17);
    oShift(20) <= iShift(18);
    oShift(21) <= iShift(19);
    oShift(22) <= iShift(20);
    oShift(23) <= iShift(21);
    oShift(24) <= iShift(22);
    oShift(25) <= iShift(23);
    oShift(26) <= iShift(24);
    oShift(27) <= iShift(25);
end behavioral;