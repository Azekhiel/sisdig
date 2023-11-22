library IEEE; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

ENTITY fulladder is 
	port (a,b : In std_logic;
		 carry_in : In std_logic;  
		 S : OUT std_logic;
		 carry_out : out std_logic
		 );
end fulladder;

Architecture ly of fulladder is 
begin
	S <= a XOR b XOR carry_in; 
	carry_out <= (carry_in AND (A XOR B)) OR (A AND B); 
end ly;
	
