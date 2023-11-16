library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity comparator is 
	port (
			reset : in std_logic;
			a,b : in std_logic_vector (15 downto 0); 
			output : out std_logic; 
			); 
end comparator; 

architecture comparator_arc of comparator is
begin 
	proses (a,b, reset) 
	begin
	if (X > Y) then 
		output <= '0';
	else
		output <= '1';
	end if; 
	end process; 
end comparator_arc; 
