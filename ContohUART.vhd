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
	
	signal send_data,receive_data	: std_logic_vector(7 downto 0);
	signal receive		: std_logic;
	signal receive_c	: std_logic;
	signal out_dec		: std_logic;
	
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
			rs232_tx 	=> rs232_tx
	);
	
	send_data <= "01010101";
	
	Converter: bintodec
	port map (
			inp_bin		=> rs232_tx
			out_dec		=> out_dec
	
	Calculator: Calculator
	port map (
			input1		=> receive()
			input2		=> receive()
			in_sel		=> receive()
			result		=> send
	
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
	end process;
	
	Digit_SS <= "0101";

end architecture;


