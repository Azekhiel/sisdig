library IEEE; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity hasil is 
	port(C : in std_logic;
		H : out std_logic
		);
end hasil;

architecture dalam of hasil is
begin
process (C)
begin
	H <= C;
end process;
end dalam; 