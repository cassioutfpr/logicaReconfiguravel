library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 


entity top_level_cronometro_tb is

end entity;

architecture top_level_cronometro_tb of top_level_cronometro_tb is
 	component top_level_cronometro is
 		port( clk_top_level: in std_logic;
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
 	end component;

 signal en_top_level_button,clk_top_level, rst_top_level, switch_top_level, a_c, b_c, c_c, d_c, e_c, f_c,g_c, a_d, b_d, c_d, d_d,e_d,f_d,g_d : std_logic;

begin
	 uut: top_level_cronometro port map(en_top_level_button => en_top_level_button,clk_top_level=>clk_top_level,rst_top_level=>rst_top_level,switch_top_level=>switch_top_level,a_c=>a_c,
	 b_c=>b_c,c_c=>c_c, d_c=>d_c,e_c=>e_c,f_c=>f_c,g_c=>g_c, a_d=>a_d,
	 b_d=>b_d,c_d=>c_d, d_d=>d_d,e_d=>e_d,f_d=>f_d,g_d=>g_d);
	 process -- sinal de clock
	 begin
		 en_top_level_button <= '1';
		 switch_top_level <= '1';
		 clk_top_level <= '0';
		 wait for 10 ns;
		 clk_top_level <= '1';
		 wait for 10 ns;
	 end process;
		 process -- sinal de reset
		 begin
		 rst_top_level <= '1';
		 wait for 50 ns;
		 rst_top_level <= '0';
		 wait for 100000 ns;
	 end process;
end architecture;