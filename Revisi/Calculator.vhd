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
			adder, subtractor, multiplication, divider: in std_logic_vector (27 downto 0);
			a, b: in std_logic_vector (15 downto 0);
			output: out std_logic_vector (27 downto 0)
			);
		end component;

-- komponen operasi penjumlahan
	component penjumlahan is
		port(
			A,B : In std_logic_vector (15 downto 0);
		 	carry_in : In std_logic; 
		 	mode : in std_logic_vector (1 downto 0);  
		 	S : OUT std_logic_vector (27 downto 0);
		 	carry_out : out std_logic
			);
	end component;

-- komponen operasi pengurangan
	component pengurangan is
		port(
			A,B : In std_logic_vector (15 downto 0);
		 	borrow_in : In std_logic; 
		 	mode : in std_logic_vector (1 downto 0);  
		 	D : OUT std_logic_vector (27 downto 0);
		 	borrow_out : out std_logic
			);
	end component;

signal r_adder, r_subtractor, r_multiplication, r_divider: std_logic_vector (27 downto 0);
signal r_mux : std_logic_vector (27 downto 0);  
signal borrow_in, borrow_out : std_logic;
signal carry_in, carry_out : std_logic;
  
begin 
	-- Alur Data
	Hasil_Penjumlahan : penjumlahan port map (input1,input2,carry_in, in_sel, r_adder, carry_out);
	H_Pengurangan : pengurangan port map (input1,input2, borrow_in, in_sel, r_subtractor, borrow_out);
	MuX : mode port map (in_sel, r_adder, r_subtractor, r_multiplication, r_divider, input1, input2, r_mux);
	-- Hasil
	result <= r_mux;
	
end kalkulator_arc;