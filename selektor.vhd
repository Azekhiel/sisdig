-- library
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- entity
entity selektor is
	port(
		ascii_op 			: in std_logic_vector(7 downto 0);
		bin_out				: out std_logic_vector(1 downto 0)
		);
end entity;

Architecture RTL of selektor is
begin
	process(ascii_op)
	begin
		if ascii_op(3 downto 0) = "1010" then
			bin_out <= "10"; --kali
		elsif ascii_op(3 downto 0) = "1011" then
			bin_out <= "00"; --tambah
		elsif ascii_op(3 downto 0) = "1101" then
			bin_out <= "01"; --kurang
		else
			bin_out <= "11";
		end if;
end process;
end architecture;