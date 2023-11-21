library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity mode is
    port (
	reset : in std_logic; 
        operasi: in std_logic_vector (1 down to 0);
        adder, subtractor, multiplication, divider: in std_logic_vector (3 down to 0);
        a, b: in std_logic_vector (15 down to 0);
        output: out std_logic_vector (3 down to 0)
	);
end mode;

architechture mode_arc of mode is
begin
    process (adder, subtractor, multiplication, divider, reset)
    begin
		if reset = '1' then 
			output <= "0000"; -- Do Nothing
        elsif mode = "00" then
            if a(15) xor b(15) = ('0') then
                output <= adder;
            else
                output <= subtractor;
            end if;

        elsif mode = "01" then
            if a(15) xor b(15) = ('0') then
                output <= subtractor;
            else
                output <= adder;
            end if;

        elsif mode = ("10") then
            output <= multiplication;
        
        elsif mode = ("11") then
            output <= divider;
        
        else
            output <= ('0000'); -- Do Nothing
        
        end if;

    end process;
end mode_arc;
