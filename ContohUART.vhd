-- library
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;
-- entity
entity UART is
	port(
		button : in std_logic;
		clk 			: in std_logic;
		rst_n 			: in std_logic;
		
-- paralel part
		Seven_Segment	: out std_logic_vector(7 downto 0) ;
		Digit_SS		: out std_logic_vector(3 downto 0) ;
		
-- serial part
		rs232_rx 		: in std_logic_vector(7 downto 0); --buat masukin input operasi
		rs232_tx 		: out std_logic_vector(7 downto 0) --keluarin hasil
	
	);
End entity;


Architecture RTL of UART is

	Component my_uart_top is
	port(
			clk 			: in std_logic;
			rst_n 		: in std_logic;
			send 			: in std_logic;
			send_data	: in std_logic_vector(7 downto 0) ; --ganti downto
			receive 		: out std_logic;
			receive_data: out std_logic_vector(7 downto 0) ; --ganti downto
			rs232_rx 	: in std_logic_vector(7 downto 0);
			rs232_tx 	: out std_logic_vector(7 downto 0)
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
	
	Component register_in is
	port(
			reg_in   : IN STD_LOGIC_VECTOR (7 DOWNTO 0); -- input.
			ld  : IN STD_LOGIC; -- load/enable.
			clr : IN STD_LOGIC; -- async. clear.
			clk : IN STD_LOGIC; -- clock.
			reg_out   : OUT STD_LOGIC_VECTOR (119 DOWNTO 0) -- output
	);
	end Component;
	
	component dectobin is
    port ( 
        int_in: in integer;
        float_in: in integer; 
        exp_in: in integer;
        sign_in: in std_logic;
        out_bin: out std_logic_vector(15 downto 0)
    );
	end component;
	
	component perhitungan_raw is
    port ( 
        int_in: in integer range 0 to 9;
        float_in: in integer range 0 to 99; 
        exp_in: in integer range 0 to 9;
        sign_in: in std_logic;
		  int_out: buffer integer ;
		  float_out : buffer integer ;
		  exp_out : buffer integer ;
		  out_bin : buffer std_logic_vector (15 downto 0)
    );
	end component;
	
	component selektor is
	port (
		ascii_op 			: in std_logic_vector(7 downto 0);
		bin_out				: out std_logic_vector(1 downto 0)
		);
	end component;
	
	signal int_in : integer;
	signal float_in : integer;
	signal exp_in : integer;
	signal sign_in : std_logic;
	
	
	signal send_data,receive_data	: std_logic_vector(7 downto 0);
	signal receive		: std_logic;
	signal receive_c	: std_logic;
	signal out_dec		: std_logic ;
	signal rs232_tx_i	: std_logic_vector(7 downto 0);
	signal rs232_tx_t	: std_logic_vector(7 downto 0); --ada t sama r mesti ganti downto nya
	signal rs232_tx_r	: integer; 
	signal input1,input2		: std_logic_vector(15 downto 0);
	signal receive_data_t: std_logic_vector(119 downto 0);
	signal ld : std_logic;
	signal clr : std_logic; 
	signal sel : std_logic_vector(1 downto 0);
	signal int_out_1 :  integer;
	signal float_out_1 :  integer;
	signal exp_out_1 :  integer;
	signal out_bin_1 :  std_logic_vector (15 downto 0);
	signal int_out_2 :  integer;
	signal float_out_2 :  integer;
	signal exp_out_2 :  integer;
	signal out_bin_2 :  std_logic_vector (15 downto 0);
	
begin
	UART: my_uart_top 
	port map (
			clk 		=> clk, --dalam komponen => luar komponen
			rst_n 		=> rst_n,
			send 		=> button,
			send_data	=> send_data,
			receive 	=> receive,
			receive_data=> receive_data,
			rs232_rx 	=> rs232_rx,
			rs232_tx 	=> rs232_tx_i 
	);
	
	Converter: bintodec
	port map (
			inp_bin		=> rs232_tx_t,
			out_dec		=> rs232_tx_r
	);
	
	selektor_1: selektor
	port map (
			ascii_op	=> receive_data_t(63 downto 56),
			bin_out		=> sel);
	
	Calculator: kalkulator
	port map (
			input1		=> input1, --apa harusnya receive_data and pararela
			input2		=> input2,
			in_sel		=> sel, --ini  mungkin bwntrook sama tipe data
			result		=> send_data --apa harusnya ke send data and pararel
	);
	
	angka_to_raw_1: perhitungan_raw
	port map (
			int_in		=> to_integer(unsigned(receive_data_t(107 downto 104))),
			float_in	=> to_integer(unsigned(receive_data_t(91 downto 88)))*10+to_integer(unsigned(receive_data_t(83 downto 80))), 
			exp_in		=> to_integer(unsigned(receive_data_t(67 downto 64))),
			sign_in		=> (receive_data_t(114)),
			int_out		=> int_out_1,
			float_out   => float_out_1,
			exp_out 	=> exp_out_1,
			out_bin     => out_bin_1
	);
	
	angka_to_raw_2: perhitungan_raw --input 2
	port map (
			int_in		=> to_integer(unsigned(receive_data_t(47 downto 40))),
			float_in	=> to_integer(unsigned(receive_data_t(27 downto 24)))*10+ to_integer(unsigned(receive_data_t(19 downto 16))),
			exp_in		=> to_integer(unsigned(receive_data_t(3 downto 0))),
			sign_in		=> receive_data_t(50),
			int_out		=> int_out_2,
			float_out   => float_out_2,
			exp_out 	=> exp_out_2,
			out_bin     => out_bin_2
	);
	
	Register_Luar: register_out
	port map (
			reg_in		=> rs232_tx_i,
			ld => ld,
			clr => clr,
			clk  => clk,
			reg_out		=> rs232_tx_t
	);
	
	Register_Dalam: register_in
	port map (
			reg_in		=> receive_data,
			ld => ld,
			clr => clr,
			clk  => clk,
			reg_out		=> receive_data_t
	);
	
	--translate condition exp
	
	Decimal_Biner1: dectobin --input 1
	port map (
			int_in		=> int_out_1,
			float_in	=> float_out_1,
			exp_in		=> exp_out_1,
			sign_in		=> (receive_data_t(114)),
			out_bin		=> input1
	);
	
	Decimal_Biner2: dectobin --input 2
	port map (
			int_in		=> int_out_2,
			float_in	=> float_out_2,
			exp_in		=> exp_out_2,
			sign_in		=> receive_data_t(50),
			out_bin		=> input2
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

end process;
end architecture;