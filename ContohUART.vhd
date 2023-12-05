-- library
library ieee;
use ieee.std_logic_1164.all;

-- entity
entity ContohUART is
	port(
		clk 				: in std_logic;
		rst_n 			: in std_logic;
		
-- paralel part
		Seven_Segment	: out std_logic_vector(7 downto 0) ;
		Digit_SS			: out std_logic_vector(3 downto 0) ;
		
-- serial part
		rs232_rx 		: in std_logic; --buat masukin input operasi
		rs232_tx 		: out std_logic --keluarin hasil
	
	);
End entity;


Architecture RTL of ContohUART is

	Component my_uart_top is
	port(
			clk 			: in std_logic;
			rst_n 		: in std_logic;
			send 			: in std_logic;
			send_data	: in std_logic_vector(7 downto 0) ; --ganti downto
			receive 		: out std_logic;
			receive_data: out std_logic_vector(7 downto 0) ; --ganti downto
			rs232_rx 	: in std_logic;
			rs232_tx 	: out std_logic
	);
	end Component;
	
	Component kalkulator is
	port(
			input1, input2: in std_logic_vector(15 downto 0); -- input angka
			in_sel : in std_logic_vector(1 downto 0);
			result: out std_logic_vector(27 downto 0) -- output hasil operasi
	);
	end Component;
	
	Component bintodec is
	port(
			inp_bin		: in std_logic_vector (27 downto 0); 
			out_dec 	: out integer
	);
	end Component;
	
	Component register_out is
	port(
			reg_in   : IN STD_LOGIC_VECTOR (7 DOWNTO 0); -- input.
			ld  : IN STD_LOGIC; -- load/enable.
			clr : IN STD_LOGIC; -- async. clear.
			clk : IN STD_LOGIC; -- clock.
			reg_out   : OUT STD_LOGIC_VECTOR (32 DOWNTO 0) -- output
	);
	end Component;
	
	signal send_data,receive_data	: std_logic_vector(7 downto 0);
	signal receive		: std_logic;
	signal receive_c	: std_logic;
	signal out_dec		: std_logic;
	signal rs232_tx_i	: std_logic_vector(7 downto 0);
	signal rs232_tx_t	: std_logic_vector(7 downto 0); --ada t sama r mesti ganti downto nya
	signal rs232_tx_r	: std_logic_vector(7 downto 0);
	signal receive_data_t: std_logic_vector(7 downto 0);
	
begin

	UART: my_uart_top 
	port map (
			clk 			=> clk, --dalam komponen => luar komponen
			rst_n 		=> rst_n,
			send 			=> button,
			send_data	=> send_data,
			receive 		=> receive,
			receive_data=> receive_data,
			rs232_rx 	=> rs232_rx,
			rs232_tx 	=> rs232_tx_i
	);
	
	send_data <= "01010101";
	
	Converter: bintodec
	port map (
			inp_bin		=> rs232_tx_t,
			out_dec		=> rs232_tx_r
	);
	
	Calculator: Calculator
	port map (
			input1		=> receive_data_t(), --apa harusnya receive_data and pararela
			input2		=> receive_data_t(),
			in_sel		=> receive_data_t(),
			result		=> send_data --apa harusnya ke send data and pararel
	);
	
	Register_Luar: register_out
	port map (
			reg_in		=> rs232_tx_i,
			reg_out		=> rs232_tx_t
	);
	
--	dectoascii kalo perlu andaikan terminal gabisa masukin integer value
	
	Process(clk)
	begin
		if ((clk = '1') and clk'event) then
			receive_c <= receive;
			if ((receive = '0') and (receive_c = '1'))then
--			if (receive = '1') then
				seven_segment <= receive_data;
			end if;
		end if;
	
	Digit_SS <= "0101";

end architecture;
	
	Digit_SS <= "0101";

end architecture;


