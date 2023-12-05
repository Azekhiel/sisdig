-- library
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- entity
entity my_uart_rx is
port(
	clk: in std_logic;
	rst_n: in std_logic;
	rs232_rx: in std_logic;
	clk_bps: in std_logic;
	bps_start: out std_logic;
	rx_data: out std_logic_vector(15 downto 0);
	rx_int : out std_logic
);
end entity my_uart_rx;



architecture RTL of my_uart_rx is

-- signal for interrupt
	signal rs232_rx0,rs232_rx1,rs232_rx2,rs232_rx3: std_logic;
	signal neg_rs232_rx: std_logic;
	signal bps_start_r: std_logic;
	signal num: unsigned(4 downto 0);
	signal rx_int_i: std_logic;
	signal rx_temp_data, rx_data_r: std_logic_vector(15 downto 0);


begin

----------------------------------------------------------------

process(clk, rst_n)
begin
	if (rst_n = '0') then 
--		begin
			rs232_rx0 <= '0';
			rs232_rx1 <= '0';
			rs232_rx2 <= '0';
			rs232_rx3 <= '0';
		
--		end;
	elsif (clk='1' and clk'event) then
--		begin
			rs232_rx0 <= rs232_rx;
			rs232_rx1 <= rs232_rx0;
			rs232_rx2 <= rs232_rx1;
			rs232_rx3 <= rs232_rx2;
--		end;
	end if;
end process;

	neg_rs232_rx <= rs232_rx3 and rs232_rx2 and (not rs232_rx1) and (not rs232_rx0);

	process( clk, rst_n)
	begin
		if (rst_n = '0') then
				bps_start_r <= 'Z';
				rx_int_i <= '0';
		elsif clk = '1' and clk'event then
			if (neg_rs232_rx= '1') then
				bps_start_r <= '1';	
				rx_int_i <= '1';			
			elsif (num = "10001") then
				bps_start_r <= '0';
				rx_int_i <= '0';		
			end if;
		end if;
	end process;


	bps_start <= bps_start_r;

	process(clk, rst_n)
	begin
		if (rst_n = '0') then
				rx_temp_data <= "0000000000000000";
				num <= "00000";
				rx_data_r <= "0000000000000000";		
		elsif (clk = '1' and clk'event) then
			if (rx_int_i = '1') then
				if(clk_bps = '1') then
						num <= num + "00001";
						case num is
								when "00001" =>  rx_temp_data(0) <= rs232_rx;	--//0bit
								when "00010" =>  rx_temp_data(1) <= rs232_rx;	--//1bit
								when "00011" =>  rx_temp_data(2) <= rs232_rx;	--//2bit
								when "00100" =>  rx_temp_data(3) <= rs232_rx;	--//3bit
								when "00101" =>  rx_temp_data(4) <= rs232_rx;	--//4bit
								when "00110" =>  rx_temp_data(5) <= rs232_rx;	--//5bit
								when "00111" =>  rx_temp_data(6) <= rs232_rx;	--//6bit
								when "01000" =>  rx_temp_data(7) <= rs232_rx;	--//7bit
							    when "01001" =>  rx_temp_data(8) <= rs232_rx;	--//8bit
								when "01010" =>  rx_temp_data(9) <= rs232_rx;	--//9bit
								when "01011" =>  rx_temp_data(10) <= rs232_rx;	--//10bit
								when "01100" =>  rx_temp_data(11) <= rs232_rx;	--//11bit
								when "01101" =>  rx_temp_data(12) <= rs232_rx;	--//12bit
								when "01110" =>  rx_temp_data(13) <= rs232_rx;	--//13bit
								when "01111" =>  rx_temp_data(14) <= rs232_rx;	--//14bit
								when "10000" =>  rx_temp_data(15) <= rs232_rx;	--//15bit
								when others =>  
						end case;
--					end;
				elsif (num = "10001") then
						num <= "00000";			
						rx_data_r <= rx_temp_data;	
				end if;
			end if;
		end if;
	end process;
	rx_data <= rx_data_r;	
	rx_int <= rx_int_i;
	
end architecture;
