library IEEE; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

ENTITY fullsub is 
	port (a,b : In std_logic;
		 borrow_in : In std_logic;  
		 D : OUT std_logic;
		 borrow_out : out std_logic
		 );
end fullsub;

Architecture arc of fullsub is 
begin
	D <= (a XOR b) XOR borrow_in; 
	borrow_out <= ((not a) and b) or (borrow_in and (not(a xor b))); 
end arc;
	
