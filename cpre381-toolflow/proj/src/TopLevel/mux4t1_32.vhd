library IEEE;
use IEEE.std_logic_1164.all;

entity mux4t1_5 is
    port(i_Select : in std_logic_vector(1 downto 0);
         i_D0     : in std_logic_vector(4 downto 0);
         i_D1     : in std_logic_vector(4 downto 0);
         i_D2     : in std_logic_vector(4 downto 0);
         i_D3     : in std_logic_vector(4 downto 0);
         o_Out    : out std_logic_vector(4 downto 0));
end mux4t1_5;

architecture dataflow of mux4t1_5 is
    begin
        with i_Select select 
            o_Out <= i_D3 when "11", i_D2 when "10", i_D1 when "01", i_D0 when "00", "00000" when others;
    end dataflow;