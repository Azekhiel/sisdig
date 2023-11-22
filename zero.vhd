library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

Entity zero is 
	port (
		s : in std_logic;
		z : out std_logic
	); 
end zero; 

architecture dalam of zero is 
begin 
	z <= '0'; 
end dalam; 