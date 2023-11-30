library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity perkalian is
    Port ( x : in  STD_LOGIC_VECTOR (15 downto 0);
           y : in  STD_LOGIC_VECTOR (15 downto 0);
           z : out  STD_LOGIC_VECTOR (27 downto 0));
end perkalian;



architecture Behavioral of perkalian is
    signal temp_mantissa : STD_LOGIC_VECTOR (21 downto 0):= (others=>'0') ;
    signal temp_1 : STD_LOGIC_VECTOR (42 downto 0):= (others=>'0') ;
    signal temp_xor : std_logic;
    signal temp_xor_buat_perhitungan : std_logic_vector (21 downto 0);
    --signal temp_carry : STD_LOGIC_VECTOR (21 downto 0) ;
    --signal temp_exp : std_logic_vector (5 downto 0); 
    signal temp_mantissa_x : STD_LOGIC_VECTOR (10 downto 0);
    signal temp_mantissa_y : STD_LOGIC_VECTOR (10 downto 0);

    signal hitung_1 : integer:=0;
    signal count: integer:=0;
    
    signal temp_exp : STD_LOGIC_VECTOR (5 downto 0);
  --  signal temp_exp_fix : STD_LOGIC_VECTOR (5 downto 0);
    signal temp_exp_fix : integer;

    
    begin
        process(x,y)
        variable temp_mantissa : STD_LOGIC_VECTOR (21 downto 0):= (others=>'0') ;
        variable temp_1 : STD_LOGIC_VECTOR(42 downto 0):= (others=>'0') ;
       -- variable temp_carry : STD_LOGIC_VECTOR (21 downto 0) ;
      --  variable temp_exp : std_logic_vector (5 downto 0);
        variable temp_xor : std_logic;
        variable temp_xor_buat_perhitungan : std_logic_vector (21 downto 0);
        variable temp_mantissa_x : STD_LOGIC_VECTOR (10 downto 0);
		variable temp_mantissa_y : STD_LOGIC_VECTOR (10 downto 0);
    
            variable hitung_1 : integer:=0;
			variable count: integer:=0;
			
			
		    variable temp_exp : STD_LOGIC_VECTOR (5 downto 0);
			--variable temp_exp_fix : STD_LOGIC_VECTOR (5 downto 0);
			variable temp_exp_fix : integer;


        begin
         temp_mantissa_x := '1' & x(9 downto 0);
		 temp_mantissa_y := '1' & y(9 downto 0);

    
       -- if (x(14 downto 10) + x(14 downto 10) -15)<0 then
        --z <= (others => '0');
        --else
                --for j in 0 to 21 LOOP
                for i in 0 to 21 LOOP
                for l in 0 to i LOOP
                if i <=10 then
                temp_1(l) := temp_mantissa_x(l) AND  temp_mantissa_y(i-l);
                elsif i>10 and l-i>=0 then
                temp_1(l):=  temp_mantissa_x(l-11) AND  temp_mantissa_y(10-(l-i));
				end if;
                end loop;
                --end loop;
                
                temp_1(42 downto 21) := temp_xor_buat_perhitungan (21 downto 0);

                --for m in 0 to 10 LOOP
				--for n in 10 to m LOOP
				--temp_1(11+m) := 
				
			--	end loop;
				--end loop; 
                
                temp_xor := temp_1(0);
                for k in 1 to 42 LOOP
                temp_xor := temp_xor XOR temp_1(k);
                end loop;
				
				hitung_1 :=0;
                for o in 0 to 42 loop
                    if temp_1(o) = '1' then
                        hitung_1 := hitung_1 +1;
                    end if;
                 end loop;
                 
                hitung_1 := hitung_1 / 2;
				
				for p in 21 downto 0 loop
					if (hitung_1-p)>0 then
						temp_xor_buat_perhitungan(p):='1';
					else
						temp_xor_buat_perhitungan(p):='0';
						end if;
						end loop;





                temp_mantissa(i) := temp_xor;
                temp_1 := "0000000000000000000000000000000000000000000";
                
                
			
                

            end loop;
        temp_exp  := ('0'& x(14 downto 10)) + ('0'&y(14 downto 10)) ;
            
        z(20 downto 0) <= temp_mantissa(20 downto 0);
        --z(26 downto 21) <= ('0'&(x(14 downto 10)-15)) + ('0'&(y(14 downto 10)-15) + 31 -1-20);
        z(26 downto 21) <= temp_exp-1;        
        z(27) <= x(15) XOR y(15);
        --end if;
        end process;
        end behavioral;