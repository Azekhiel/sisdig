library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity dectobin is
    port ( 
        int_in: in integer;
        float_in: in integer; 
        sign_in: in std_logic;
        out_bin: out std_logic_vector(15 downto 0)
        
      --  tes_int : out std_logic_vector (10 downto 0);
    --    tes_float : out std_logic_vector (10 downto 0);
--        tes_gabungan : out std_logic_vector (32 downto 0);
  --              iterasi_while : out integer range 0 to 40

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
    signal exp : integer;
    signal mantissa : std_logic_vector (9 downto 0);
    signal exp_sementara: std_logic_vector (4 downto 0);
	-- 		  signal zero : std_logic_vector (9 downto 0) := "0000000000";
	signal out_signal_expand : std_logic_vector (32 downto 0);
	
	signal iteraasi_while_1 : integer := 21;



begin

    process (int, float_in)
        variable int: integer;
        variable float1: std_logic_vector(10 downto 0);
        variable int1: std_logic_vector(10 downto 0);
        variable float: integer;
        variable l: integer;
       -- variable k: std_logic;
        variable exp : integer;
        variable mantissa : std_logic_vector (9 downto 0);
        variable exp_sementara: std_logic_vector (4 downto 0);
        
        variable iterasi_while_1: integer :=21;
        
        variable k: std_logic;

    begin
		int :=int_in;
		float:= float_in;
        for i in 0 to 10 loop
            if int mod 2 = 1 then
                int1(i) := '1';
            else
                int1(i) := '0';
            end if;
            int := int / 2;
        end loop;


				
            for j in 10 downto 0 loop            
            float := float * 2;
                if float >= 100000 then
                    float1(j) := '1';
                    float:= float-100000;
                else
                    float1(j) := '0';
                end if;
                

            end loop;
        
        out_signal <= int1 & float1;
        out_signal_expand <= out_signal & "00000000000";
        
        k := out_signal(21);
        iterasi_while_1 := 21;
        while ( k)='0' and iterasi_while_1>=1 loop
        	k := out_signal(iterasi_while_1);
        	iterasi_while_1 := iterasi_while_1-1;

			--if (k = '0') then
				--k <= out_signal(m);
			--if k='1' then 
			--	l := m;
			--	exit ;
			--end if;
        end loop;
        
        --exp_sementara := "00000";
        
        exp := (iterasi_while_1 - 10) + 15 ;
--		  if l>=10 then
        mantissa := out_signal_expand((iterasi_while_1+11) downto (iterasi_while_1 +2));
	--	  else
		--  zero (9 downto (10-l)) <= out_signal((l-1) downto 0);
			--mantissa := zero;
		  --end if;
		out_bin <= sign_in & std_logic_vector(to_unsigned(exp, 5)) & out_signal_expand(iterasi_while_1+11 downto iterasi_while_1 +2);
		--out_bin <= sign_in & std_logic_vector(to_unsigned(exp, 5)) & out_signal_expand(24 downto 15);
		
	--	tes_gabungan <= out_signal_expand;
		--tes_int <= int1;
		--tes_float <= float1;
--		iterasi_while <= iterasi_while_1;
		
		
    end process;

end behavioral;
