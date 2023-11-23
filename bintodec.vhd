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

signal init : integer;
signal init2 : integer;
signal hasil_dec : integer;
signal hasil_mant : integer;

begin

process(inp_bin)
variable int1 : integer;
variable int2 : integer;

begin
	for i in 27 downto 22 loop
		for j in 5 downto 0 loop
			if inp_bin(i) = '1' then
				int1 := (2**j);
				hasil_dec <= init + int1;
				init <= int1;
			end if;
		end loop;
	end loop;

	for k in 21 downto 0 loop
		for u in -1 downto -22 loop
			if inp_bin(k) = '1' then
				int2 := (2**u);
				hasil_mant <= init2 + int2;
				init2 <= int2;
			end if;
		end loop;
	end loop;
	
end process;
end behavioral;
	