library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.all;
	entity kalkulator is
		port(
		in_reset: in std_logic; 
		input1, input2: in std_logic_vector(15 downto 0); -- input angka
		in_sel: in std_logic_vector(1 downto 0); -- selektor operasi
		result: out std_logic_vector(3 downto 0); -- output hasil operasi
		);
	end kalkulator;

	architecture kalkulator_arc of kalkulator is
		-- komponen selektor
		component mode is
			port(
			reset: in std_logic;
			mode: in std_logic_vector(1 downto 0);
			adder, subtractor, multiplication, divider: in std_logic_vector(15 downto 0);
			output: out std_logic_vector(3 downto 0)
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
			clk : in STD_LOGIC;
			rst : in STD_LOGIC;
			input_a : in STD_LOGIC_VECTOR(15 downto 0);
			input_b : in STD_LOGIC_VECTOR(15 downto 0);
			result : out STD_LOGIC_VECTOR(31 downto 0);
			overflow : out STD_LOGIC;
			underflow : out STD_LOGIC
			);
		end component;

		-- komponen operasi pengurangan
		component subtractor is
			port(
			x, y: in std_logic_vector(3 downto 0);
			output: out std_logic_vector(3 downto 0)
			);
		end component;

		-- komponen operasi penjumlahan
		component adder is
			port(
			x, y: in std_logic_vector(3 downto 0);
			output: out std_logic_vector(3 downto 0)
			);
		end component;
		
		signal r_comparator, r_subtractor, r_adder, r_mode: std_logic_vector(15 downto 0);

	begin
		-- alur data
		X_SUBTRACTOR: subtractor port map(input1, input2, r_subtractor);
		X_ADDER: adder port map(input1, input2, r_adder);
		X_MODE: mode port map(in_sel, in_reset, r_adder, r_subtractor, r_multiplication, r_divider);

		-- hasil
		result <= r_mode;

end kalkulator_arc;