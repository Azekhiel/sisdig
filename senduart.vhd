library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity senduart is
	port (
			depantitik : in integer range 0 to 9;
			belakangtitik1 : in integer range 0 to 9;
			belakangtitik2 : in integer range 0 to 9;
			uartdepan : out std_logic_vector (7 downto 0);
			uartbelakang1 : out std_logic_vector (7 downto 0);
			uartbelakang2 : out std_logic_vector (7 downto 0)
			);
end senduart;

architecture behavioral of senduart is

begin
process (depantitik, belakangtitik1, belakangtitik2)
	
	begin
		if depantitik = 0 then
			uartdepan <= "00110000";
			
		elsif depantitik = 1 then
			uartdepan <= "00110001";
			
		elsif depantitik = 2 then
			uartdepan <= "00110010";
			
		elsif depantitik = 3 then
			uartdepan <= "00110011";
			
		elsif depantitik = 4 then
			uartdepan <= "00110100";
			
		elsif depantitik = 5 then
			uartdepan <= "00110101";
			
		elsif depantitik = 6 then
			uartdepan <= "00110110";
			
		elsif depantitik = 7 then
			uartdepan <= "00110111";
			
		elsif depantitik = 8 then
			uartdepan <= "00111000";
			
		elsif depantitik = 9 then
			uartdepan <= "00111001";
		
		end if;
		
		if belakangtitik1 = 0 then
			uartbelakang1 <= "00110000";
		
		elsif belakangtitik1 = 1 then
			uartbelakang1 <= "00110001";
			
		elsif belakangtitik1 = 2 then
			uartbelakang1 <= "00110010";
			
		elsif belakangtitik1 = 3 then
			uartbelakang1 <= "00110011";
			
		elsif belakangtitik1 = 4 then
			uartbelakang1 <= "00110100";
			
		elsif belakangtitik1 = 5 then
			uartbelakang1 <= "00110101";
			
		elsif belakangtitik1 = 6 then
			uartbelakang1 <= "00110110";
			
		elsif belakangtitik1 = 7 then
			uartbelakang1 <= "00110111";
			
		elsif belakangtitik1 = 8 then
			uartbelakang1 <= "00111000";
			
		elsif belakangtitik1 = 9 then
			uartbelakang1 <= "00111001";
			
		end if;
		
		if belakangtitik2 = 0 then
			uartbelakang2 <= "00110000";
		
		elsif belakangtitik2 = 1 then
			uartbelakang2 <= "00110001";
			
		elsif belakangtitik2 = 2 then
			uartbelakang2 <= "00110010";
			
		elsif belakangtitik2 = 3 then
			uartbelakang2 <= "00110011";
			
		elsif belakangtitik2 = 4 then
			uartbelakang2 <= "00110100";
			
		elsif belakangtitik2 = 5 then
			uartbelakang2 <= "00110101";
			
		elsif belakangtitik2 = 6 then
			uartbelakang2 <= "00110110";
			
		elsif belakangtitik2 = 7 then
			uartbelakang2 <= "00110111";
			
		elsif belakangtitik2 = 8 then
			uartbelakang2 <= "00111000";
			
		elsif belakangtitik2 = 9 then
			uartbelakang2 <= "00111001";
			
		end if;

end process;
end behavioral;