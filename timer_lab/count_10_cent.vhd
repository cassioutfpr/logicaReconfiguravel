library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity count_10_cent is
	 port( 	clk_count_10_cent 	: in std_logic;
				rst_count_10_cent 	: in std_logic;
				wr_en_count_10_cent 	: in std_logic;
				clr_count_10_cent		: in std_logic;
				data_out_10_cent		: out unsigned(3 downto 0)
 );
 end entity;	
 
architecture a_count_10_cent of count_10_cent is
 
	component count_16 is
		port(
				clk_count_16 		: in std_logic;
				rst_count_16 		: in std_logic;
				wr_en_count_16 	: in std_logic;
				clr_count_16		: in std_logic;
				data_out_16		 	: out unsigned(3 downto 0)
		);
	end component;
	
	signal clear_aux: std_logic;
	signal out_aux: unsigned(3 downto 0);
begin
	
	data_out_10_cent <= out_aux;
	
	top_count_16: count_16 port map(	rst_count_16=> rst_count_10_cent, 
												clk_count_16=>clk_count_10_cent, 
												wr_en_count_16=>wr_en_count_10_cent, 
												clr_count_16=>clear_aux, 
												data_out_16 => out_aux  );
	
	process(out_aux, clr_count_10_cent)
	begin
		if((out_aux = "1001" and clr_count_10_cent = '1') or (out_aux = "0101" and clr_count_10_cent = '1')) then
			clear_aux <= '1';
		else
			clear_aux <= '0';
		end if;
	end process;
 
end architecture;
			
