library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cronometro is
	 port( 	clk_cronometro 		: in std_logic;
				rst_cronometro 		: in std_logic;
				wr_en_cronometro 		: in std_logic;
				switch_cronometro		:	in std_logic;
				data_out_cent			: out unsigned(3 downto 0);
				
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
 
architecture a_cronometro of cronometro is

	component count_10_cent is
		 port( 		clk_count_10_cent 	: in std_logic;
						rst_count_10_cent 	: in std_logic;
						wr_en_count_10_cent 	: in std_logic;
						clr_count_10_cent		: in std_logic;
						data_out_10_cent		: out unsigned(3 downto 0)
	 );
	 end component;	
	 
		signal clear_cron_to_cent, clear_cron_to_dec, clear_cron_to_seg, clear_cron_to_dez_seg: std_logic;
		signal in_0_c, in_1_c, in_2_c, in_3_c : std_logic;
		signal in_0_d, in_1_d, in_2_d, in_3_d : std_logic;
		signal in_0_s, in_1_s, in_2_s, in_3_s : std_logic;
		signal in_0_ds, in_1_ds, in_2_ds, in_3_ds : std_logic;
		
		signal out_to_cent, out_to_dec, out_to_seg, out_to_seg_dez: unsigned(3 downto 0);
		begin
		count_cent_pm: count_10_cent port map(
														clk_count_10_cent => clk_cronometro,
														rst_count_10_cent => rst_cronometro,
														wr_en_count_10_cent => wr_en_cronometro,
														clr_count_10_cent => clear_cron_to_cent,
														data_out_10_cent => out_to_cent	
													);
													
		count_dec_pm: count_10_cent port map(
														clk_count_10_cent => clk_cronometro,
														rst_count_10_cent => rst_cronometro,
														wr_en_count_10_cent => clear_cron_to_cent,
														clr_count_10_cent => clear_cron_to_dec,
														data_out_10_cent => out_to_dec	
													);
													
		count_seg_pm: count_10_cent port map(
														clk_count_10_cent => clk_cronometro,
														rst_count_10_cent => rst_cronometro,
														wr_en_count_10_cent => clear_cron_to_dec,
														clr_count_10_cent => clear_cron_to_seg,
														data_out_10_cent => out_to_seg	
													);
													
		count_seg_dez_pm: count_10_cent port map(
														clk_count_10_cent => clk_cronometro,
														rst_count_10_cent => rst_cronometro,
														wr_en_count_10_cent => clear_cron_to_seg,
														clr_count_10_cent => clear_cron_to_dez_seg,
														data_out_10_cent => out_to_seg_dez	
													);
		
		in_3_c <= out_to_cent(3);
		in_2_c <= out_to_cent(2);
		in_1_c <= out_to_cent(1);
		in_0_c <= out_to_cent(0);
		
		in_3_d <= out_to_dec(3);
		in_2_d <= out_to_dec(2);
		in_1_d <= out_to_dec(1);
		in_0_d <= out_to_dec(0);
		
		in_3_s <= out_to_seg(3);
		in_2_s <= out_to_seg(2);
		in_1_s <= out_to_seg(1);
		in_0_s <= out_to_seg(0);
		
		in_3_ds <= out_to_seg_dez(3);
		in_2_ds <= out_to_seg_dez(2);
		in_1_ds <= out_to_seg_dez(1);
		in_0_ds <= out_to_seg_dez(0);
		
		
		process(out_to_cent, wr_en_cronometro)
		begin
		if (out_to_cent = "1001" and wr_en_cronometro='1') then
			clear_cron_to_cent <= '1';
		else
			clear_cron_to_cent <= '0';
		end if;	
		
		if (out_to_dec = "1001" and wr_en_cronometro='1' and out_to_cent = "1001") then
			clear_cron_to_dec <= '1';
		else
			clear_cron_to_dec <= '0';
		end if;
		
		if (out_to_seg = "1001" and wr_en_cronometro='1' and out_to_cent = "1001" and out_to_dec = "1001") then
			clear_cron_to_seg <= '1';
		else
			clear_cron_to_seg <= '0';
		end if;
	
		if (out_to_seg_dez = "0101" and wr_en_cronometro='1' and out_to_cent = "1001" and out_to_dec = "1001" and out_to_seg = "1001") then
			clear_cron_to_dez_seg <= '1';
		else
			clear_cron_to_dez_seg <= '0';
		end if;
		
		if(switch_cronometro = '1') then
			a_c <= (((not in_3_c) and (not in_2_c) and (not in_1_c) and (in_0_c) ) or ((in_2_c) and (not in_0_c)) or ((in_3_c) and (in_1_c)) or ((in_3_c) and (in_2_c)));
			b_c <= (((in_2_c) and (not in_1_c) and (in_0_c) ) or ((in_2_c) and (in_1_c) and (not in_0_c)) or ((in_3_c) and (in_1_c)) or ((in_3_c) and (in_2_c)));
			c_c <= (((not in_2_c) and (in_1_c) and (not in_0_c)) or ((in_3_c) and (in_1_c)) or ((in_3_c) and (in_2_c)));
			d_c <= (((not in_2_c) and (not in_1_c) and (in_0_c)) or ((in_2_c) and (not in_1_c) and (not in_0_c)) or ((in_2_c) and (in_1_c) and (in_0_c)) or ((in_3_c) and (in_1_c)) or ((in_3_c) and (in_2_c)));
			e_c <= (((in_0_c)) or ((in_2_c) and (not in_1_c)) or ((in_3_c) and (in_1_c)));
			f_c <= (((not in_3_c) and (not in_2_c) and (in_0_c)) or ((not in_2_c) and (in_1_c)) or ((in_1_c) and (in_0_c)) or ((in_3_c) and (in_2_c)));
			g_c <= (((not in_3_c) and (not in_2_c) and (not in_1_c))  or ((not in_3_c) and (in_2_c) and (in_1_c) and (in_0_c)));
			a_d <= (((not in_3_d) and (not in_2_d) and (not in_1_d) and (in_0_d) ) or ((in_2_d) and (not in_0_d)) or ((in_3_d) and (in_1_d)) or ((in_3_d) and (in_2_d)));
			b_d <= (((in_2_d) and (not in_1_d) and (in_0_d) ) or ((in_2_d) and (in_1_d) and (not in_0_d)) or ((in_3_d) and (in_1_d)) or ((in_3_d) and (in_2_d)));
			c_d <= (((not in_2_d) and (in_1_d) and (not in_0_d)) or ((in_3_d) and (in_1_d)) or ((in_3_d) and (in_2_d)));
			d_d <= (((not in_2_d) and (not in_1_d) and (in_0_d)) or ((in_2_d) and (not in_1_d) and (not in_0_d)) or ((in_2_d) and (in_1_d) and (in_0_d)) or ((in_3_d) and (in_1_d)) or ((in_3_d) and (in_2_d)));
			e_d <= (((in_0_d)) or ((in_2_d) and (not in_1_d)) or ((in_3_d) and (in_1_d)));
			f_d <= (((not in_3_d) and (not in_2_d) and (in_0_d)) or ((not in_2_d) and (in_1_d)) or ((in_1_d) and (in_0_d)) or ((in_3_d) and (in_2_d)));
			g_d <= (((not in_3_d) and (not in_2_d) and (not in_1_d))  or ((not in_3_d) and (in_2_d) and (in_1_d) and (in_0_d)));
		else
			a_c <= (((not in_3_s) and (not in_2_s) and (not in_1_s) and (in_0_s) ) or ((in_2_s) and (not in_0_s)) or ((in_3_s) and (in_1_s)) or ((in_3_s) and (in_2_s)));
			b_c <= (((in_2_s) and (not in_1_s) and (in_0_s) ) or ((in_2_s) and (in_1_s) and (not in_0_s)) or ((in_3_s) and (in_1_s)) or ((in_3_s) and (in_2_s)));
			c_c <= (((not in_2_s) and (in_1_s) and (not in_0_s)) or ((in_3_s) and (in_1_s)) or ((in_3_s) and (in_2_s)));
			d_c <= (((not in_2_s) and (not in_1_s) and (in_0_s)) or ((in_2_s) and (not in_1_s) and (not in_0_s)) or ((in_2_s) and (in_1_s) and (in_0_s)) or ((in_3_s) and (in_1_s)) or ((in_3_s) and (in_2_s)));
			e_c <= (((in_0_s)) or ((in_2_s) and (not in_1_s)) or ((in_3_s) and (in_1_s)));
			f_c <= (((not in_3_s) and (not in_2_s) and (in_0_s)) or ((not in_2_s) and (in_1_s)) or ((in_1_s) and (in_0_s)) or ((in_3_s) and (in_2_s)));
			g_c <= (((not in_3_s) and (not in_2_s) and (not in_1_s))  or ((not in_3_s) and (in_2_s) and (in_1_s) and (in_0_s)));
			a_d <= (((not in_3_ds) and (not in_2_ds) and (not in_1_ds) and (in_0_ds) ) or ((in_2_ds) and (not in_0_ds)) or ((in_3_ds) and (in_1_ds)) or ((in_3_ds) and (in_2_ds)));
			b_d <= (((in_2_ds) and (not in_1_ds) and (in_0_ds) ) or ((in_2_ds) and (in_1_ds) and (not in_0_ds)) or ((in_3_ds) and (in_1_ds)) or ((in_3_ds) and (in_2_ds)));
			c_d <= (((not in_2_ds) and (in_1_ds) and (not in_0_ds)) or ((in_3_ds) and (in_1_ds)) or ((in_3_ds) and (in_2_ds)));
			d_d <= (((not in_2_ds) and (not in_1_ds) and (in_0_ds)) or ((in_2_ds) and (not in_1_ds) and (not in_0_ds)) or ((in_2_ds) and (in_1_ds) and (in_0_ds)) or ((in_3_ds) and (in_1_ds)) or ((in_3_ds) and (in_2_ds)));
			e_d <= (((in_0_ds)) or ((in_2_ds) and (not in_1_ds)) or ((in_3_ds) and (in_1_ds)));
			f_d <= (((not in_3_ds) and (not in_2_ds) and (in_0_ds)) or ((not in_2_ds) and (in_1_ds)) or ((in_1_ds) and (in_0_ds)) or ((in_3_ds) and (in_2_ds)));
			g_d <= (((not in_3_ds) and (not in_2_ds) and (not in_1_ds))  or ((not in_3_ds) and (in_2_ds) and (in_1_ds) and (in_0_ds)));

		end if;
		end process;
		
end architecture;
			
