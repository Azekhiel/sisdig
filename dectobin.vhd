library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity dectobin is
    port ( 
        int: in integer;
        float_in: in std_logic_vector(31 downto 0); -- Input floating-point value
        out_bin: out std_logic_vector(15 downto 0)
    );
end dectobin;

architecture behavioral of dectobcd is
    signal temp: integer;
    signal float1: std_logic_vector(10 downto 0);
    signal int1: std_logic_vector(10 downto 0);
    signal float: std_logic_vector(37 downto 0); -- Adjusted to 37 bits

begin
    float <= '0' & float_in & "0000"; -- Padding '0' at MSB and "0000" at LSB to make it 37-bit

    process (int, float)
    begin
        -- Integer part to BCD
        if int mod 2 = 1 then
            int1(0) <= '1';
        else
            int1(0) <= '0';
        end if;

        -- Mantissa part to BCD
        for i in 0 to 10 loop
            if float(36) = '1' then -- Check the sign bit for float
                float <= float(35 downto 0) + "1"; -- Add 1 to the mantissa if negative
            end if;

            if float(35) = '1' then
                float <= float(34 downto 0) & '0'; -- Shift mantissa left if MSB is 1
            else
                float <= '0' & float(34 downto 0); -- Shift mantissa left if MSB is 0
            end if;

            float1(i) <= float(36); -- Store MSB of mantissa in BCD
        end loop;

    end process;
end behavioral;
