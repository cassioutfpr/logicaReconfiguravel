library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity count_16 is
	 port( 	clk_count_16 		: in std_logic;
				rst_count_16 		: in std_logic;
				wr_en_count_16 	: in std_logic;
				clr_count_16		: in std_logic;
				data_out_16			: out unsigned(3 downto 0)
 );
 end entity;
 
 architecture a_count_16 of count_16 is
	signal out_aux: unsigned(3 downto 0);
 begin
 
	process(clk_count_16, rst_count_16)
	begin
		if rst_count_16 = '1' then
			out_aux <= "0000";
		else
			if clk_count_16'event and clk_count_16 = '1' then
				if clr_count_16 = '1' then
					out_aux <= "0000";
				else
					if wr_en_count_16 = '1' then
						out_aux <= out_aux + 1;
					end if;
				end if; 
			end if;
		end if;
	end process;
	
	data_out_16 <= out_aux;
	
end architecture;
			
