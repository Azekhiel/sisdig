library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity perhitungan_raw is
    port ( 
        int_in: in integer range 0 to 9;
        float_in: in integer range 0 to 99; 
        exp_in: in integer range 0 to 9;
        sign_in: in std_logic;
		  int_out: buffer integer ;
		  float_out : buffer integer ;
		  exp_out : buffer integer ;
		  out_bin : buffer std_logic_vector (15 downto 0)
    );
end perhitungan_raw;

architecture behavioral of perhitungan_raw is
	 constant exp_temp : integer := exp_in;
    signal int: integer;
    signal float: integer;
    signal exp : integer;

	component dectobin is
	port(
	     int_in: in integer;
        float_in: in integer; 
        exp_in: in integer;
        sign_in: in std_logic;
        out_bin: out std_logic_vector(15 downto 0)
	);
	end component;
begin

    process (int_in, float_in)
        variable int: integer;
        variable float: integer;
        variable exp : integer;


    begin
        if exp_in>=2 then
		  for i in exp_temp downto 0 loop
            int := int_in * (10);
				if i>=2 then
				int := int + float_in*10;
				end if;
				end loop;
            float:= 0;
        
        elsif exp_in=1 then
            int := int_in*10 + float_in/10;
            float:= float_in mod 10;
        
        elsif exp_in=0 then
            int := int_in;
            float:= float_in;
      
		elsif exp_in>=-5 then
            int := 0;
				for j in  (7+exp_temp) downto 0 loop
            float:= int_in*(10);
				end loop;
				for k in  (5+exp_temp) downto 0 loop
				float:= float_in*(10);
				end loop;
        end if;
		  int_out <= int;
		  float_out <= float;
		  exp_out <= exp;
		end process;
		
		Jawaban: dectobin PORT MAP (
		int_in => int_out,
		float_in => float_out,
		exp_in => exp_out,
		sign_in => sign_in,
		out_bin => out_bin
		);
		
		end behavioral;