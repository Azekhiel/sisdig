library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.all;
	entity kalkulator is
		port(
		input1, input2: in std_logic_vector(15 downto 0); -- input angka
        in_sel : in std_logic_vector(1 downto 0);
		result: out std_logic_vector(27 downto 0) -- output hasil operasi
		);
	end kalkulator;

	architecture kalkulator_arc of kalkulator is
		-- komponen selektor
		component mode is
			port(
			operasi: in std_logic_vector (1 downto 0);
			adder, subtractor, multiplication, divider: in std_logic_vector (3 downto 0);
			a, b: in std_logic_vector (15 downto 0);
			output: out std_logic_vector (3 downto 0)
			);
		end component;

		-- komponen operasi komparasi
		component comparator is
			port(
			reset: in std_logic;
			a, b: in std_logic_vector(15 downto 0);
			output: out std_logic_vector(3 downto 0)
			);
		end component;

		-- komponen operasi multiplier
		component multiplier is
			port(
			a : in std_logic_vector (15 downto 0);
			b : in std_logic_vector (15 downto 0);
			o : out std_logic_vector (27 downto 0)
			);
		end component;

		-- komponen operasi pembagian
		component divider is
			port(
			x : in  STD_LOGIC_VECTOR (15 downto 0);
           	y : in  STD_LOGIC_VECTOR (15 downto 0);
           	z : out  STD_LOGIC_VECTOR (27 downto 0)
			);
		end component;
		
		-- komponen operasi pengurangan
		component subtractor is
			port(
			A,B : In std_logic_vector (15 downto 0);
		 	borrow_in : In std_logic; 
		 	mode : in std_logic_vector (1 downto 0);  
		 	D : OUT std_logic_vector (27 downto 0);
		 	borrow_out : out std_logic
			);
		end component;

		-- komponen operasi penjumlahan
		component adder is
			port(
			A,B : In std_logic_vector (15 downto 0);
		 	carry_in : In std_logic; 
		 	mode : in std_logic_vector (1 downto 0);  
		 	S : OUT std_logic_vector (27 downto 0);
		 	carry_out : out std_logic
			);
		end component;
		
        
        signal r_result : std_logic_vector(27 downto 0); -- hasil
        signal x_in, x_out : std_logic; -- borrow_in/out, carry_in/out
        signal mode : std_logic_vector(1 downto 0); -- mode
        

	begin
		-- alur data
        if in_sel = "00" then
            X_ADDER : adder port map(input1, input2, r_result, x_in, x_out, mode) ;

        elsif in_sel = "01" then
            X_SUBTRACTOR : subtractor port map(input1, input2, r_result, x_in, x_out, mode);

        elsif in_sel = "10" then
            X_MULTIPLIER : multiplier port map(input1, input2, r_result);

        elsif in_sel = "11" then
            X_DIVIDER : divider port map(input1, input2, r_result);
        
        end if;

		-- hasil
		result <= r_result;

end kalkulator_arc;