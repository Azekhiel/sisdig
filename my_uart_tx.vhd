-- library
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- entity
entity my_uart_tx is
port(
				clk,rst_n : in std_logic;
				tx_data : in std_logic_vector(27 downto 0);
				tx_int : in std_logic;
				rs232_tx : out std_logic;
				clk_bps: in std_logic;
				bps_start : out std_logic
);
end entity my_uart_tx;

--architecture

architecture RTL of my_uart_tx is
	signal tx_int0,tx_int1,tx_int2, rs232_tx_r : std_logic;
	signal neg_tx_int : std_logic;
	signal tx_data_i : std_logic_vector(27 downto 0);
	signal bps_start_r : std_logic;
	signal tx_en: std_logic;
	signal num : unsigned(4 downto 0);

	
begin
-- The process below is to ensure 'neg_rx_int' react to negative edge of rx interrupt 
	process (clk,rst_n)
	begin
		if rst_n = '0' then
			tx_int0 <='0';
			tx_int1 <='0';
			tx_int2 <='0';
		elsif (clk = '1' and clk'event) then
			tx_int0 <= tx_int;
			tx_int1 <= tx_int0;
			tx_int2 <= tx_int1;		
		end if;
	end process;

	neg_tx_int <=  ((not tx_int1) and tx_int2);
-- The process below is to control the transmission process:
-- --> take data from input (freeze the data)
-- --> generate bps_start_r signal
-- --> enable transmit signal (tx_en)

	process( clk, rst_n)
	begin
		if rst_n = '0' then
			bps_start_r <= 'Z';
			tx_en <= '0';
			tx_data_i <= "0000000000000000000000000000";
		elsif (clk= '1' and clk'event) then
			if (neg_tx_int = '1') then
				bps_start_r <= '1';
				tx_data_i <= tx_data;
				tx_en <= '1';
			elsif (num = "11100") then
				bps_start_r <= '0';
				tx_en <= '0';				
			end if;
		end if;
	end process;
	
	bps_start <= bps_start_r;


-- The process below send the data through the rs232_tx_r when tx_en is '1':
-- --> take data from input (freeze the data)
-- --> generate bps_start_r signal
-- --> enable transmit signal (tx_en)
	
	process(clk, rst_n)
	begin
		if (rst_n = '0') then
			num <= "00000";
			rs232_tx_r <= '1';
		elsif (clk = '1' and clk'event) then
			if(tx_en = '1') then
				if(clk_bps = '1')	then
						num <= num + "00001";
						case num is
							when "00000" => rs232_tx_r <= '0' ; 	
							when "00001" => rs232_tx_r <= tx_data_i(0);	
							when "00010" => rs232_tx_r <= tx_data_i(1);	
							when "00011" => rs232_tx_r <= tx_data_i(2);	
							when "00100" => rs232_tx_r <= tx_data_i(3);	
							when "00101" => rs232_tx_r <= tx_data_i(4);	
							when "00110" => rs232_tx_r <= tx_data_i(5);	
							when "00111" => rs232_tx_r <= tx_data_i(6);	
							when "01000" => rs232_tx_r <= tx_data_i(7);	
							when "01001" => rs232_tx_r <= tx_data_i(8);	
							when "01010" => rs232_tx_r <= tx_data_i(9);	
							when "01011" => rs232_tx_r <= tx_data_i(10);	
							when "01100" => rs232_tx_r <= tx_data_i(11);	
							when "01101" => rs232_tx_r <= tx_data_i(12);	
							when "01110" => rs232_tx_r <= tx_data_i(13);	
							when "01111" => rs232_tx_r <= tx_data_i(14);	
							when "10000" => rs232_tx_r <= tx_data_i(15);	
							when "10001" => rs232_tx_r <= tx_data_i(16);	
							when "10010" => rs232_tx_r <= tx_data_i(17);
							when "10011" => rs232_tx_r <= tx_data_i(18);	
							when "10100" => rs232_tx_r <= tx_data_i(19);	
							when "10101" => rs232_tx_r <= tx_data_i(20);	
							when "10110" => rs232_tx_r <= tx_data_i(21);	
							when "10111" => rs232_tx_r <= tx_data_i(22);	
							when "11000" => rs232_tx_r <= tx_data_i(23);	
							when "11001" => rs232_tx_r <= tx_data_i(24);	
							when "11010" => rs232_tx_r <= tx_data_i(25);	
							when "11011" => rs232_tx_r <= tx_data_i(26);
							when "11100" => rs232_tx_r <= tx_data_i(27);
							when others => rs232_tx_r <= '1';
						end case;
				elsif(num= "11101") then
					num <= "00000"; 
				end if;	
			end if;		
		end if;
	end process;

 rs232_tx <= rs232_tx_r;

end architecture;
