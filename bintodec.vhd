library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity bintodec is
    port ( 
        inp_bin: in std_logic_vector (27 downto 0); 
		  out_dec : out integer
    );
end bintodec;

architecture behavioral of bintodec is

signal init : integer := 0;
signal init2 : integer := 0;
signal hasil_dec : integer;
signal hasil_mant : integer;
signal kali1 : integer := 0;
signal kali2 : integer := -1;

begin

process(inp_bin)
variable int1 : integer;
variable int2 : integer;


begin
	for i in 22 to 27 loop
		if inp_bin(i) = '1' then
			int1 := (2**kali1);
			kali1 <= kali1 + 1;
			hasil_dec <= init + int1;
			init <= int1;
		else
			kali1 <= kali1 + 1;
		end if;
	end loop;

	for j in 21 downto 0 loop
		if inp_bin(j) = '1' then
			int2 := (2**kali2);
			kali2 <= kali2 - 1;
			hasil_mant <= init2 + int2;
			init2 <= int2;
		else
			kali2 <= kali2 - 1;
		end if;
	end loop;
	
end process;
end behavioral;
