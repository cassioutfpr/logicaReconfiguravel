library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level_cronometro is
	 port( 	clk_top_level: in std_logic;
				rst_top_level: in std_logic;
				switch_top_level: in std_logic;
				en_top_level_button: in std_logic;
				a_c: out std_logic;
				b_c: out std_logic;
				c_c: out std_logic;
				d_c: out std_logic;
				e_c: out std_logic;
				f_c: out std_logic;
				g_c: out std_logic;

				a_d: out std_logic;
				b_d: out std_logic;
				c_d: out std_logic;
				d_d: out std_logic;
				e_d: out std_logic;
				f_d: out std_logic;
				g_d: out std_logic
 );
 end entity;	
 
architecture a_top_level_cronometro of top_level_cronometro is

	component DIVISOR is
		port	(	CLK: in std_logic;
					RST: in std_logic;
					DIV50: out std_logic
				);
	 end component;	

	component cronometro is
	 	port( 	clk_cronometro 		: in std_logic;
				rst_cronometro 		: in std_logic;
				wr_en_cronometro 		: in std_logic;
				switch_cronometro		:	in std_logic;
				a_c: out std_logic;
				b_c: out std_logic;
				c_c: out std_logic;
				d_c: out std_logic;
				e_c: out std_logic;
				f_c: out std_logic;
				g_c: out std_logic;

				a_d: out std_logic;
				b_d: out std_logic;
				c_d: out std_logic;
				d_d: out std_logic;
				e_d: out std_logic;
				f_d: out std_logic;
				g_d: out std_logic
 		);
 	end component;
	 
		signal rst_top_level_signal, en_top_level_signal, en_to_cron,en_top_level_button_signal,switch_top_level_signal: std_logic;
		signal out_to_cent, out_to_dec, out_to_seg, out_to_seg_dez: unsigned(3 downto 0);
		begin
		
		divisor_pm: DIVISOR port map(
										CLK => clk_top_level,
										RST => rst_top_level,
										DIV50 => en_top_level_signal
										);

		cronometro_pm: cronometro port map(
											clk_cronometro	=> clk_top_level,
											rst_cronometro 	=> rst_top_level,
											switch_cronometro => switch_top_level,
											wr_en_cronometro => en_to_cron,
											a_c => a_c,
											b_c => b_c,
											c_c => c_c,
											d_c => d_c,
											e_c => e_c,
											f_c => f_c,
											g_c => g_c,
											a_d => a_d,
											b_d => b_d,
											c_d => c_d,
											d_d => d_d,
											e_d => e_d,
											f_d => f_d,
											g_d => g_d 
											);
											
				
			process(en_top_level_button, en_top_level_button_signal)
			begin
				if(rst_top_level = '1') then
					en_top_level_button_signal <= '0';
				end if;
				
				if(en_top_level_button_signal = '0') then
					en_to_cron <= en_top_level_signal;
				else 
					en_to_cron <= '0';
				end if;
				
				if(en_top_level_button = '0') then
					en_top_level_button_signal <= '1';
					end if;

			end process;
		
												
end architecture;
			
 