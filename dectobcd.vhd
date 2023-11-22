library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;


entity dectobcd is
    port ( 
        int: in integer;
        float: in real;
        out_bin: out std_logic_vector (15 downto 0)
    );
end dectobcd;

architecture bismillah of dectobcd is
    signal temp: integer;
    signal float1: std_logic_vector (10 downto 0);
    signal int1: std_logic_vector (10 downto 0);
begin
    process (int, float)
    begin
	 if int mod 2 =1 then
    int1(0) <= '1';
	 else
	 int1(0) <='0';
	 end if;
    end process;
end bismillah;
