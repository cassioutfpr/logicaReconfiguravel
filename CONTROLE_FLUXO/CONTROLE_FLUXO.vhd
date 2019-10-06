library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


--SE FOR PASSAR PRA PLACA E USAR O DIVISOR50 PARA FAZER O CLOCK, PROVAVELMENTE UM TOP_LEVEL TERÁ QUE SER FEITO,
--AÍ ESSE ARQUIVO DE MÁQUINA DE ESTADOS SÓ VAI TER CLOCK E RESET COMO ENTRADA E OS ESTADOS COMO SAÍDA PARA GERENCIAR 
--O RESTO DOS ENABLES, SEJA PRA LER/GUARDAR NAS BRAMS.

entity CONTROLE_FLUXO is
	 port( 	populating_ram_with_data : IN STD_LOGIC;
				clock : IN STD_LOGIC ;
				reset : IN STD_LOGIC ;
				data	: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
				rdaddress	: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
				wraddress	: IN STD_LOGIC_VECTOR (9 DOWNTO 0)
 );
 end entity;	
 
architecture a_CONTROLE_FLUXO of CONTROLE_FLUXO is
	
	-- Build an enumerated type for the state machine
   --PENSEI EM FAZER 3 ESTADOS - RESET, READ E WRITE
	type state_type is (rst_state, write_state, read_state);


	component FIFO is
		port	(			clock					: IN STD_LOGIC ;
							data					: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
							rdreq					: IN STD_LOGIC ;
							wrreq					: IN STD_LOGIC ;
							almost_empty		: OUT STD_LOGIC ;
							almost_full			: OUT STD_LOGIC ;
							empty					: OUT STD_LOGIC ;
							full					: OUT STD_LOGIC ;
							q						: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
							usedw					: OUT STD_LOGIC_VECTOR (8 DOWNTO 0)
				);
	 end component;	
	 
	component BRAM is
		port	(			clock			: IN STD_LOGIC;
							data			: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
							rdaddress	: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
							wraddress	: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
							wren			: IN STD_LOGIC;
							q				: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
				);
	 end component;	
	
	signal out_bram_read_to_fifo,out_fifo_to_bram_write: STD_LOGIC_VECTOR (7 DOWNTO 0);
	signal out_bram_write : STD_LOGIC_VECTOR (7 DOWNTO 0); -- NAO SERA USADO, SÓ PARA CONECTAR
	signal almost_empty_from_fifo, almost_full_from_fifo, empty_fifo, full_fifo, enable_bram_write: std_logic;
	signal address_used_to_write_on_bram_write : STD_LOGIC_VECTOR (9 DOWNTO 0);
	signal number_of_addresses_used : STD_LOGIC_VECTOR (8 DOWNTO 0); --NAO SEI PRA QUE SERIA USADO, MAS DEIXEI CONECTADO
	signal estado_read, estado_write : std_logic; --ESTAO CONECTADOS À FIFO PARA LER OU ESCREVER. SETAR QUANDO MUDAR DE ESTADO
	signal state : state_type;
	begin
	
	-- fazer um processo para enable_bram_write <= '1' ou '0' se almost_empty_from_fifo = 1 ou  almost_full_from_fifo = 1
	
	bram_read_pm: BRAM port map(
										wren => populating_ram_with_data,
										data => 	data, --QUANDO TIVER ASSIM, O SEGUNDO PARAMETRO SE REFERE AO DATA DO CONTROLE_FLUXO
										clock => clock,
										wraddress => wraddress,
										rdaddress => rdaddress, 
										q => out_bram_read_to_fifo
									);
	
	bram_write_pm: BRAM port map(
											wren => enable_bram_write, 
											clock => clock,
											data => out_fifo_to_bram_write,
											wraddress => address_used_to_write_on_bram_write,
											rdaddress => address_used_to_write_on_bram_write, --CONECTADO AO MESMO, MAS SÓ PRA CONECTAR, POIS NAO SERA USADO
											q => out_bram_write
										);

	fifo_pm: FIFO port map(
										clock => clock,
										almost_empty => almost_empty_from_fifo,
										almost_full => almost_full_from_fifo,
										q => out_fifo_to_bram_write,
										data => out_bram_read_to_fifo,
										empty => empty_fifo,
										full => full_fifo,
										usedw => number_of_addresses_used,
										rdreq => estado_read,
										wrreq => estado_write
								  );
	
	process (clock, reset)
	variable time : integer := 0;
	begin
		if reset = '1' then
			state <= rst_state;
			time := 0;
		elsif (rising_edge(clock)) then
			time := time + 1;
--			case state is
--				when rst_state=>
--					
--				when write_state=>
--
--				when read_state=>
--					
--			end case;
		end if;
	end process;
													
end architecture;
			