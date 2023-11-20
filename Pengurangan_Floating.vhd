library IEEE; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pengurangan is 
	port(A,B : In std_logic_vector (15 downto 0);
		 borrow_in : In std_logic; 
		 mode : in std_logic_vector (1 downto 0);  
		 D : OUT std_logic_vector (27 downto 0);
		 borrow_out : out std_logic
		 );
end pengurangan;

architecture ling of pengurangan is 
	signal borrow : std_logic_vector (13 downto 0); 
	component comparator is 
		port(
			a, b : in std_logic_vector(15 downto 0);
			mode : in std_logic_vector (1 downto 0);
			s : out std_logic
		);
	end component; 
	
	component fullsub is 
		port (a,b : In std_logic;
			  borrow_in : In std_logic;  
			  D : OUT std_logic;
			  borrow_out : out std_logic
		 );
	end component; 
	
	component zero is 
		port (
			s : in std_logic;
			z : out std_logic
		); 
	end component; 
	
begin 
-- Mantissa
FS1 : zero Port MAP (s => A(0));
FS2 : zero Port MAP (s => A(0));
FS3 : zero Port MAP (s => A(0));
FS4 : zero Port MAP (s => A(0));
FS5 : zero Port MAP (s => A(0));
FS6 : zero Port MAP (s => A(0));
FS7 : zero Port MAP (s => A(0));
FS8 : zero Port MAP (s => A(0));
FS9 : zero Port MAP (s => A(0));
FS10 : zero Port MAP (s => A(0));
FS11: fullsub PORT MAP (a => A(0), b => B(0), borrow_in => borrow_in, D => D(0), borrow_out => borrow(0));
FS12 : fullsub PORT MAP (a => A(1), b => B(1), borrow_in => borrow(0), D => D(1), borrow_out => borrow(1));
FS13: fullsub PORT MAP (a => A(2), b => B(2), borrow_in => borrow(1), D => D(2), borrow_out => borrow(2));
FS14: fullsub PORT MAP (a => A(3), b => B(3), borrow_in => borrow(2), D => D(3), borrow_out => borrow(3));
FS15: fullsub PORT MAP (a => A(4), b => B(4), borrow_in => borrow(3), D => D(4), borrow_out => borrow(4));
FS16: fullsub PORT MAP (a => A(5), b => B(5), borrow_in => borrow(4), D => D(5), borrow_out => borrow(5));
FS17: fullsub PORT MAP (a => A(6), b => B(6), borrow_in => borrow(5), D => D(6), borrow_out => borrow(6));
FS18: fullsub PORT MAP (a => A(7), b => B(7), borrow_in => borrow(6), D => D(7), borrow_out => borrow(7));
FS19: fullsub PORT MAP (a => A(8), b => B(8), borrow_in => borrow(7), D => D(8), borrow_out => borrow(8));
FS20: fullsub PORT MAP (a => A(9), b => B(9), borrow_in => borrow(8), D => D(9), borrow_out => borrow(9));
-- Eksponen
FS21 : fullsub PORT MAP (a => A(10), b => B(10), borrow_in => borrow(9), D => D(10), borrow_out => borrow(10));
FS22 : fullsub PORT MAP (a => A(11), b => B(11), borrow_in => borrow(10), D => D(11), borrow_out => borrow(11));
FS23 : fullsub PORT MAP (a => A(12), b => B(12), borrow_in => borrow(11), D => D(12), borrow_out => borrow(12));
FS24 : fullsub PORT MAP (a => A(13), b => B(13), borrow_in => borrow(12), D => D(13), borrow_out => borrow(13));
FS25 : fullsub PORT MAP (a => A(14), b => B(14), borrow_in => borrow(13), D => D(14), borrow_out => borrow_out);
FS26 : zero Port MAP (s => A(0));
-- Sign
FS27 : comparator PORT MAP (a => A, b => B, mode => mode);
end ling;
		

