library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity dectobin is
    port ( 
        int_in: in integer;
        float_in: in integer; 
        out_bin: out std_logic_vector(14 downto 0)
    );
end dectobin;

architecture behavioral of dectobin is
    signal int: integer;
    signal float1: std_logic_vector(10 downto 0);
    signal int1: std_logic_vector(10 downto 0);
    signal float: integer;
    signal out_signal: std_logic_vector(21 downto 0);
    signal l: integer;
    signal k: std_logic;
	 signal exp : std_logic_vector (4 downto 0);
	 signal mantissa : std_logic_vector (9 downto 0);

begin

    process (int, float_in)
        variable int: integer;
        variable float1: std_logic_vector(10 downto 0);
        variable int1: std_logic_vector(10 downto 0);
        variable float: integer;
        variable l: integer;
        variable k: std_logic;
		  variable exp : std_logic_vector (4 downto 0);
		  variable mantissa : std_logic_vector (9 downto 0);

    begin
        int := int_in;
        float := float_in;
        
        -- Integer part to BCD
        for i in 0 to 10 loop
            if int mod 2 = 1 then
                int1(i) := '1';
            else
                int1(i) := '0';
            end if;
            int := int / 2;
        end loop;

        -- Float part to BCD
        if float > 0 then
            while float < 1000000000 and float > 0 loop
                float := float * 10;
            end loop;
            
            float := float * 2;
            for j in 10 downto 0 loop
                if float / 10000000000 = 1 then
                    float1(j) := '1';
                else
                    float1(j) := '0';
                end if;
                
                if float < 10000000000 then
                    float := float - 10000000000;
                end if;
            end loop;
        end if;
        
        out_signal <= int1 & float1;
        
        k := out_signal(21);
        l := 21;
        while k = '0' and l > 0 loop
            l := l - 1;
            k := out_signal(l);
        end loop;
			
		exp := "00000" + (l - 1) + 15 - 11;
		mantissa := out_signal((l - 1) downto (l - 10));

		out_bin <= exp & mantissa;
		
    
	 end process;

end behavioral;
