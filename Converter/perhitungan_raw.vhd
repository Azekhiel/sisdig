library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity perhitungan_raw is
    port ( 
        int_in: in integer range 0 to 9;
        float_in: in integer range 0 to 9; 
        exp_in: in integer range -9 to 9;
        sign_in: in std_logic;
		int_out: buffer integer  range 0 to 100000;
		float_out : buffer integer range 0 to 100000 ;
		exp_out : buffer integer range 0 to 100;
		out_bin : buffer std_logic_vector (15 downto 0)
    );
end perhitungan_raw;

architecture behavioral of perhitungan_raw is
	 constant exp_temp : integer := exp_in;
    signal int: integer;
    signal float: integer;
    signal exp : integer range 0 to 100;
	 signal pengali: integer;

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
        variable exp : integer range 0 to 100;
		  variable pengali: integer ;


    begin
			pengali := 1;
        if exp_in>=1 then
		  for i in exp_temp downto 1 loop
            pengali := pengali *10;
			end loop;
			int:= int_in*pengali + float_in*pengali/10;

        elsif exp_in=0 then
            int := int_in;
            float:= float_in;
      
		elsif exp_in>=-5 then
            int := 0;
				pengali := 100000;
				for j in  (-1)*exp_temp downto 1 loop
				pengali := pengali/10;
				end loop;
				float:= int_in*pengali + float_in*pengali/10;
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
