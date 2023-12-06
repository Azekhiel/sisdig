library IEEE;
use IEEE.STD_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all; 

entity perkalian is 
	port (
		-- Inputnya 1 bit sign, 5 bit exponent, 10 bit mantissa
		a : in std_logic_vector (15 downto 0);
		b : in std_logic_vector (15 downto 0);
		-- Outputnya 1 bit sign, 6 bit exponent, 21 bit mantissa
		o : out std_logic_vector (27 downto 0)
	); 
end perkalian;

architecture floating_point of perkalian is 
begin 
	process (a,b)
		-- Pemisahan input 
		variable a_sign : std_logic; 
		variable a_exponent : std_logic_vector (5 downto 0);
		variable a_mantissa : std_logic_vector (10 downto 0);
		variable b_sign : std_logic; 
		variable b_exponent : std_logic_vector (5 downto 0);
		variable b_mantissa : std_logic_vector (10 downto 0);
		-- Pemisahan output 
		variable o_sign : std_logic;
		variable o_exponent : std_logic_vector (5 downto 0);
		variable o_mantissa : std_logic_vector (20 downto 0);
		-- Variable yang akan digunakan selama perhitungan
		variable penyimpanan : std_logic_vector (21 downto 0);
		variable proses : std_logic_vector (21 downto 0);
		variable hasil : std_logic_vector (21 downto 0);
		variable carry: std_logic; 
		variable exponent : std_logic_vector (6 downto 0);
		
	
	begin
		a_sign := a(15);
		a_exponent(4 downto 0) := a(14 downto 10);
		a_exponent (5) := '0';
		a_mantissa(9 downto 0) := a(9 downto 0);
		a_mantissa (10) := '0'; 
		
		b_sign := b(15);
		b_exponent(4 downto 0) := b(14 downto 10);
		b_exponent (5):= '0';
		b_mantissa(9 downto 0) := b(9 downto 0);
		b_mantissa (10) := '0';
		
		if ((a_exponent = "000000") and (a_mantissa = 0)) or ((b_exponent = "000000") and (b_mantissa = 0)) then 
			o_sign := '0'; 
			o_exponent := (others => '0');
			o_mantissa := (others => '0');
			
		elsif ((a_exponent = "011111") and ((b_exponent = "011111"))) then 
			o_sign := a_sign XOR b_sign; 
			o_exponent := "111111" ;
			o_mantissa := (others => '0');
		
		else
			
			--Proses Sign 
			o_sign := a_sign XOR b_sign;
			
			-- Proses Mantissa
			hasil := (others => '0');
			for i in 0 to 10 loop 
				penyimpanan := (others => '0');
				if(a_mantissa(i)='1') then			
					penyimpanan((10+i) downto i) := b_mantissa;
				end if; 
				
				proses := hasil;
				-- Full Adder
				carry := '0';
				for I in 0 to 21 loop
					hasil(I) := proses(I) xor penyimpanan(I) xor carry;
					carry  := (penyimpanan(I) and proses(I)) or (penyimpanan(I) and carry) or (proses(I) and carry);
				end loop;
				
			end loop;
			o_mantissa := hasil(20 downto 0);
			 
			 carry := hasil(21);
			-- Proses Exponent
			for I in 0 to 5 loop
				exponent(I) := a_exponent(I) xor b_exponent(I) xor carry ;
				carry := ( a_exponent(I) and b_exponent(I) ) or ( a_exponent(I) and carry ) or ( b_exponent(I) and carry ) ;
			end loop;
			o_exponent := (exponent(5 downto 0));
		end if;
		
		-- Hasil Output
		o(27)<=o_sign;
		o(26 downto 21) <= o_exponent;
		o(20 downto 0)<=o_mantissa;
		
	end process;
end floating_point; 



	