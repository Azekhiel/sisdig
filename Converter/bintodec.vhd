library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity bintodec is
port(
    input : in std_logic_vector(27 downto 0);
    pangkat_1 : out std_logic_vector (7 downto 0);
    pangkat_2 : out std_logic_vector (7 downto 0);
    angka_1 : out std_logic_vector (7 downto 0);
    angka_2 : out std_logic_Vector (7 downto 0);
    sign_exp: out std_logic_vector (7 downto 0);
    sign : out std_logic_vector (7 downto 0);
    
	temp_out : out integer
);
end bintodec;

architecture behavioral of bintodec is
	
	constant exp : integer :=to_integer(unsigned(input (26 downto 21))) -31 -21;
	--signal exp_temp: integer;

	
	begin
	process (input)
	--variable exp_temp: integer;
	variable temp: integer;
	variable pangkat_10 : integer;
	variable pangkat_10_2: integer;
	
	variable iterasi_while_1 : integer;
	
	variable pembatas : integer;
	
	
	variable temp_buat_cek : integer;
	variable temp_buat_string: integer;
	variable cek: integer;
	
	variable temp_temp: integer;

	
	begin
	temp := to_integer(unsigned('1'&input(20 downto 0)));
	pangkat_10 := 0;
	
	if temp>=10000000 then
	temp := temp/10;
	pangkat_10 := pangkat_10 +1;
	end if;

	pembatas:= 1;
	while pembatas<=temp loop
	pembatas := pembatas*10;
	end loop;
	
	
	if exp >=0 then
		for i in to_integer(unsigned(input (26 downto 21))) -31 -21 downto 1 loop
			temp := temp*2;
			if temp> pembatas then
				temp := temp/10;
				pangkat_10 := pangkat_10+1;
			end if;
		
		end loop;
	else
	for i in to_integer(unsigned(input (26 downto 21))) -31 -21 to -1 loop
	if temp mod 2 = 1 then
		if temp<=1000000 then
			temp := temp * 10;
			pangkat_10 := pangkat_10 +1;
		end if;
	temp := temp/2;
	else
	temp := temp/2;
	end if;
	end loop;
	end if;
	
	temp_buat_cek := temp;
	pangkat_10_2 := 0;
	
	iterasi_while_1 := 0;
	while temp_buat_cek > 0 and iterasi_while_1 < 20  loop
	temp_buat_cek :=  temp_buat_cek/10;
	pangkat_10_2 := pangkat_10_2 +1;
	iterasi_while_1 := iterasi_while_1 +1;
	end loop;
	pangkat_10_2 := pangkat_10_2-1;
	
	
	if exp<0 then
	pangkat_1 <= "0011"&std_logic_vector(to_unsigned((pangkat_10-pangkat_10_2)/10, 4));
	pangkat_2 <= "0011"&std_logic_vector(to_unsigned((pangkat_10-pangkat_10_2) mod 10, 4));
	sign_exp <= "00101101";
	else
	pangkat_1 <= "0011"&std_logic_vector(to_unsigned((pangkat_10_2 + pangkat_10)/10, 4));
	pangkat_2 <= "0011"&std_logic_vector(to_unsigned((pangkat_10_2 + pangkat_10) mod 10, 4));
	sign_exp <= "00101011";
	end if;
	
	temp_temp := temp;
	while temp_temp<10000000 and temp_temp>=1 loop
	temp_temp := temp_temp*10;
	end loop;
	while temp_temp>=100000000 and temp_temp<=5000000000 loop
	temp_temp:= temp_temp/10;
	end loop;
	
	if temp = 0 then
	angka_1 <= "00110000";
	angka_2 <= "00110000";
	sign <= "00101011";

	else
	angka_1 <= "0011"&std_logic_vector(to_unsigned(temp_temp/10000000, 4));
	
	angka_2 <= "0011"&std_logic_vector(to_unsigned(((temp_temp mod 10000000)/1000000), 4));
	
	sign <= "00101" & input(27) & not input(27) & "1"; 
	
	end if;
	
	temp_out <= temp;
	end process;
	end behavioral;
	
