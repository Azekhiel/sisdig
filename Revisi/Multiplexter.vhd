library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity mode is
    port ( 
        operasi: in std_logic_vector (1 downto 0);
        adder, subtractor, multiplication, divider: in std_logic_vector (27 downto 0);
        a, b: in std_logic_vector (15 downto 0);
        output: out std_logic_vector (27 downto 0)
	);
end mode;

architecture mode_arc of mode is
begin
    process (adder, subtractor, multiplication, divider)
    begin
        if operasi = "00" then
            if (a(15) xor b(15)) = '0' then
                output <= adder;
            else
                output <= subtractor;
            end if;

        elsif operasi = "01" then
            if (a(15) xor b(15)) = ('0') then
                output <= subtractor;
            else
                output <= adder;
            end if;
         elsif operasi = "10" then
                output <= multiplication;
         elsif operasi = "11" then
                output <= divider;  
        end if;
    end process;
end mode_arc;