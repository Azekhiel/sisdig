library IEEE; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity comparator is 
	port (a, b : in std_logic_vector (15 downto 0);
		 mode : in std_logic_vector (1 downto 0); 
		  s : out std_logic
	);
end comparator;

architecture komparasi of comparator is
		begin
		process (a,b, mode)
		begin
		if (a(14) > b(14)) and ((mode = "00") or (mode = "01")) then
			s <= a(15); 
		elsif (a(14) < b(14)) then
			if mode = "00" then 
				s <= b(15); 
			elsif mode = "01" then 
			    s <= not b(15);
			end if;
		else
			for i IN 13 downto 0 loop 
				if (a(i) > b(i)) and ((mode = "00") or (mode = "01")) then
					s <= a(15); 
					exit; 
				elsif (a(i) < b(i)) then
					if mode = "00" then 
						s <= b(15); 
						exit; 
					elsif mode = "01" then 
						s <= not b(15);
						exit;
					end if;
				else 
					if (a(0) = b(0)) then
						if (mode = "00") then
							s <= a(0) AND b(0);
						elsif (mode = "01") then 
							s <= a(0) AND Not b(0);
						end if; 
					end if; 
				end if;
			end loop;
		end if;
		end process;
end komparasi; 
		
			
		