-- library
library ieee;
use ieee.std_logic_1164.all;

-- entity
entity ContohUART is
	port(
		clk 				: in std_logic;
		rst_n 			: in std_logic;
		
-- paralel part
		button 			: in std_logic;
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
	
	signal send_data,receive_data	: std_logic_vector(7 downto 0);
	signal receive		: std_logic;
	signal receive_c	: std_logic;
	
begin

	UART: my_uart_top 
	port map (
			clk 			=> clk,
			rst_n 		=> rst_n,
			send 			=> button,
			send_data	=> send_data,
			receive 		=> receive,
			receive_data=> receive_data,
			rs232_rx 	=> rs232_rx,
			rs232_tx 	=> rs232_tx
	);
	
	send_data <= "01010101";
	
	
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


