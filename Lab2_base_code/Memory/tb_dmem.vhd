library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_dmem is
    generic 
        (
            DATA_WIDTH : natural := 32;
            ADDR_WIDTH : natural := 10;
            gCLK_HPER: time := 50 ns
        );
end tb_dmem;

architecture mixed of tb_dmem is 
    constant cCLK_PER : time := gCLK_HPER * 2;
    component mem is
        port 
            (
                clk		: in std_logic;
                addr	: in std_logic_vector((ADDR_WIDTH-1) downto 0);
                data	: in std_logic_vector((DATA_WIDTH-1) downto 0);
                we		: in std_logic := '1';
                q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
            );
    end component;

    signal s_CLK, s_we: std_logic;
    signal s_addr: std_logic_vector((ADDR_WIDTH-1) downto 0);
    signal s_data, s_q: std_logic_vector((DATA_WIDTH -1) downto 0);


    signal s_temp_addr: integer := 0;
    signal s_temp_out : std_logic_vector((DATA_WIDTH -1) downto 0);
begin

    dmem: mem
        port map(
            clk => s_CLK,
            addr => s_addr,
            data => s_data,
            we => s_we,
            q => s_q
        );
    
    P_Tick:process
        begin
            s_CLK <= '0';
            wait for gCLK_HPER;
            s_CLK <= '1';
            wait for gCLK_HPER;
    end process;

    P_Cases:process
        begin
            s_temp_addr <= 0;
            s_addr <= "0000000000";
            s_data <= x"00000000";
            s_we <= '0';
            wait for cCLK_PER;
            s_data <= s_q;
            s_addr <= std_logic_vector(to_unsigned(s_temp_addr + 256, ADDR_WIDTH));
            s_we <= '1';
            s_temp_addr <= s_temp_addr + 1;
            wait for cCLK_PER;
            
            s_we <= '0';
            s_addr <= std_logic_vector(to_unsigned(s_temp_addr, ADDR_WIDTH));
            wait for cCLK_PER;
            s_data <= s_q;
            s_we <= '1';
            s_addr <= std_logic_vector(to_unsigned(s_temp_addr + 256, ADDR_WIDTH));
            s_temp_addr <= s_temp_addr + 1;
            wait for cCLK_PER;

            s_we <= '0';
            s_addr <= std_logic_vector(to_unsigned(s_temp_addr, ADDR_WIDTH));
            wait for cCLK_PER;
            s_data <= s_q;
            s_we <= '1';
            s_addr <= std_logic_vector(to_unsigned(s_temp_addr + 256, ADDR_WIDTH));
            s_temp_addr <= s_temp_addr + 1;
            wait for cCLK_PER;

            s_we <= '0';
            s_addr <= std_logic_vector(to_unsigned(s_temp_addr, ADDR_WIDTH));
            wait for cCLK_PER;
            s_data <= s_q;
            s_we <= '1';
            s_addr <= std_logic_vector(to_unsigned(s_temp_addr + 256, ADDR_WIDTH));
            s_temp_addr <= s_temp_addr + 1;
            wait for cCLK_PER;

            s_we <= '0';
            s_addr <= std_logic_vector(to_unsigned(s_temp_addr, ADDR_WIDTH));
            wait for cCLK_PER;
            s_data <= s_q;
            s_we <= '1';
            s_addr <= std_logic_vector(to_unsigned(s_temp_addr + 256, ADDR_WIDTH));
            s_temp_addr <= s_temp_addr + 1;
            wait for cCLK_PER;

            s_we <= '0';
            s_addr <= std_logic_vector(to_unsigned(s_temp_addr, ADDR_WIDTH));
            wait for cCLK_PER;
            s_data <= s_q;
            s_we <= '1';
            s_addr <= std_logic_vector(to_unsigned(s_temp_addr + 256, ADDR_WIDTH));
            s_temp_addr <= s_temp_addr + 1;
            wait for cCLK_PER;

            s_we <= '0';
            s_addr <= std_logic_vector(to_unsigned(s_temp_addr, ADDR_WIDTH));
            wait for cCLK_PER;
            s_data <= s_q;
            s_we <= '1';
            s_addr <= std_logic_vector(to_unsigned(s_temp_addr + 256, ADDR_WIDTH));
            s_temp_addr <= s_temp_addr + 1;
            wait for cCLK_PER;

            s_we <= '0';
            s_addr <= std_logic_vector(to_unsigned(s_temp_addr, ADDR_WIDTH));
            wait for cCLK_PER;
            s_data <= s_q;
            s_we <= '1';
            s_addr <= std_logic_vector(to_unsigned(s_temp_addr + 256, ADDR_WIDTH));
            s_temp_addr <= s_temp_addr + 1;
            wait for cCLK_PER;

            s_we <= '0';
            s_addr <= std_logic_vector(to_unsigned(s_temp_addr, ADDR_WIDTH));
            wait for cCLK_PER;
            s_data <= s_q;
            s_we <= '1';
            s_addr <= std_logic_vector(to_unsigned(s_temp_addr + 256, ADDR_WIDTH));
            s_temp_addr <= s_temp_addr + 1;
            wait for cCLK_PER;

            s_we <= '0';
            s_addr <= std_logic_vector(to_unsigned(s_temp_addr, ADDR_WIDTH));
            wait for cCLK_PER;
            s_data <= s_q;
            s_we <= '1';
            s_addr <= std_logic_vector(to_unsigned(s_temp_addr + 256, ADDR_WIDTH));
            s_temp_addr <= s_temp_addr + 1;
            wait for cCLK_PER;
    end process;
end mixed;
