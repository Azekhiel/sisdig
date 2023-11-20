library IEEE; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity penjumlahan is 
	port(A,B : In std_logic_vector (15 downto 0);
		 carry_in : In std_logic; 
		 mode : in std_logic_vector (1 downto 0);  
		 S : OUT std_logic_vector (16 downto 0);
		 carry_out : out std_logic
		 );
end penjumlahan;

architecture ling of penjumlahan is 
	signal carry : std_logic_vector (13 downto 0); 
	component comparator is 
		port(
			a, b : in std_logic_vector(15 downto 0);
			mode : in std_logic_vector (1 downto 0);
			s : out std_logic
		);
	end component; 
	
	component fulladder is 
		port (a,b : In std_logic;
			carry_in : In std_logic;  
			S : OUT std_logic;
			carry_out : out std_logic
			);
	end component; 
	
	component zero is 
		port (
			s : in std_logic;
			z : out std_logic
		); 
	end component; 
	
begin 
FA0 : zero Port MAP (s => A(0));
FA1 : zero Port MAP (s => A(0));
FA2 : zero Port MAP (s => A(0));
FA3 : zero Port MAP (s => A(0));
FA4 : zero Port MAP (s => A(0));
FA5 : zero Port MAP (s => A(0));
FA6 : zero Port MAP (s => A(0));
FA7 : zero Port MAP (s => A(0));
FA8 : zero Port MAP (s => A(0));
FA9 : zero Port MAP (s => A(0));
FA10 : zero Port MAP (s => A(0));
FA11 : zero Port MAP (s => A(0));
FA12: fulladder PORT MAP (a => A(0), b=> B(0), carry_in => carry_in, S => S(0), carry_out => carry(0));
FA13 : fulladder PORT MAP (a => A(1), b=> B(1), carry_in => carry(0), S => S(1), carry_out => carry(1));
FA14 : fulladder PORT MAP (a => A(2), b=> B(2), carry_in => carry(1), S => S(2), carry_out => carry(2));
FA15 : fulladder PORT MAP (a => A(3), b=> B(3), carry_in => carry(2), S => S(3), carry_out => carry(3));
FA16 : fulladder PORT MAP (a => A(4), b=> B(4), carry_in => carry(3), S => S(4), carry_out => carry(4));
FA17 : fulladder PORT MAP (a => A(5), b=> B(5), carry_in => carry(4), S => S(5), carry_out => carry(5));
FA18 : fulladder PORT MAP (a => A(6), b=> B(6), carry_in => carry(5), S => S(6), carry_out => carry(6));
FA19 : fulladder PORT MAP (a => A(7), b=> B(7), carry_in => carry(6), S => S(7), carry_out => carry(7));
FA20 : fulladder PORT MAP (a => A(8), b=> B(8), carry_in => carry(7), S => S(8), carry_out => carry(8));
-- Exponent
FA21 : fulladder PORT MAP (a => A(9), b=> B(9), carry_in => carry(8), S => S(9), carry_out => carry(9));
FA22 : fulladder PORT MAP (a => A(10), b=> B(10), carry_in => carry(9), S => S(10), carry_out => carry(10));
FA23 : fulladder PORT MAP (a => A(11), b=> B(11), carry_in => carry(10), S => S(11), carry_out => carry(11));
FA24 : fulladder PORT MAP (a => A(12), b=> B(12), carry_in => carry(11), S => S(12), carry_out => carry(12));
FA25 : fulladder PORT MAP (a => A(13), b=> B(13), carry_in => carry(12), S => S(13), carry_out => carry(13));
FA26 : fulladder PORT MAP (a => A(14), b=> B(14), carry_in => carry(13), S => S(14), carry_out => carry_out);
-- Sign
FS27 : comparator PORT MAP (a => A, b => B, mode => mode);

end ling;
		

