library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity subtractor is 
	port (
		reset : in std_logic;
		a,b : in std_logic (15 downto 0);
		s : in std_logic (1 downto 0);
		output : out std_logic (28 downto 0); 
	); 
end subtractor; 

architecture subtractor_arc of subtractor is
begin 
	process (a,b,s, reset)
	begin 
	if (reset = '1') then
		output <= "0000";
	elsif (s = '1') then
		output <= (x - y);
	else
		output <= x + y; 
	end if
	end process
end subtractor_arc; 
	