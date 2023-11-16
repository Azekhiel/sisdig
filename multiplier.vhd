library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multiplier is
    Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        input_a : in STD_LOGIC_VECTOR(15 downto 0);
        input_b : in STD_LOGIC_VECTOR(15 downto 0);
        result : out STD_LOGIC_VECTOR(31 downto 0);
        overflow : out STD_LOGIC;
        underflow : out STD_LOGIC
    );
end multiplier;

architecture Behavioral of multiplier is
    signal sign_a, sign_b, sign_result : STD_LOGIC;
    signal exponent_a, exponent_b, exponent_result : STD_LOGIC_VECTOR(4 downto 0);
    signal mantissa_a, mantissa_b, mantissa_result : STD_LOGIC_VECTOR(9 downto 0);
    signal product_mantissa : STD_LOGIC_VECTOR(19 downto 0);
    signal sum_exponents : STD_LOGIC_VECTOR(5 downto 0);
    signal result_sign_shifted : STD_LOGIC;
    signal result_exponent_shifted : STD_LOGIC_VECTOR(4 downto 0);
begin

    process (clk, rst, sign_a, sign_b, exponent_a, exponent_b, mantissa_a, mantissa_b, product_mantissa, sum_exponents, result_sign_shifted, result_exponent_shifted)
    begin
        if rst = '1' then
            sign_result <= '0';
            exponent_result <= (others => '0');
            mantissa_result <= (others => '0');
            overflow <= '0';
            underflow <= '0';
        elsif rising_edge(clk) then
            sign_a <= input_a(15);
            exponent_a <= input_a(14 downto 10);
            mantissa_a <= '1' & input_a(9 downto 0);

            sign_b <= input_b(15);
            exponent_b <= input_b(14 downto 10);
            mantissa_b <= '1' & input_b(9 downto 0);

            product_mantissa <= (others => '0');
            for i in 0 to 9 loop
                if mantissa_b(i) = '1' then
                    product_mantissa <= product_mantissa + to_signed(to_integer(unsigned(mantissa_a)), product_mantissa'length);
                end if;
                mantissa_a <= '0' & mantissa_a(8 downto 1);
            end loop;

            sum_exponents <= to_signed(to_integer(unsigned(exponent_a)) + 
                                       to_integer(unsigned(exponent_b)), sum_exponents'length);

            IF sign_a = sign_b then
				result_sign_shifted <= '0';
			ELSE
				result_sign_shifted <= '1';
			END IF;

            mantissa_result <= product_mantissa(19 downto 10);

            result <= result_sign_shifted & sum_exponents & mantissa_result;

            IF sum_exponents(5) = '0' and sum_exponents(4) = '1' THEN
				overflow <= '1';
			ELSE
				overflow <= '0';
			END IF;
			
			IF sum_exponents(5) = '1' and sum_exponents(4) = '0' THEN
				underflow <= '1';
			ELSE underflow <= '0';
			END IF;
        end if;
    end process;

end Behavioral;
