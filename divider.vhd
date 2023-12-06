library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity divider is
    Port ( x : in  STD_LOGIC_VECTOR (15 downto 0);
           y : in  STD_LOGIC_VECTOR (15 downto 0);
           z : out  STD_LOGIC_VECTOR (27 downto 0));
end divider;

architecture Behavioral of divider is

signal x_mantissa : STD_LOGIC_VECTOR (9 downto 0);
signal x_exponent : STD_LOGIC_VECTOR (4 downto 0);
signal x_sign : STD_LOGIC;
signal y_mantissa : STD_LOGIC_VECTOR (9 downto 0);
signal y_exponent : STD_LOGIC_VECTOR (4 downto 0);
signal y_sign : STD_LOGIC;
signal z_mantissa : STD_LOGIC_VECTOR (20 downto 0);
signal z_exponent : STD_LOGIC_VECTOR (5 downto 0);
signal z_sign : STD_LOGIC;
signal a : STD_LOGIC_VECTOR (22 downto 0);
signal temp_1 : STD_LOGIC_VECTOR (21 downto 0);
signal temp_2 : STD_LOGIC_VECTOR (21 downto 0);
signal temp_3 : STD_LOGIC_VECTOR (5 downto 0);

begin 
process(x,y)
variable x_mantissa : STD_LOGIC_VECTOR (9 downto 0);
variable x_exponent : STD_LOGIC_VECTOR (4 downto 0);
variable x_sign : STD_LOGIC;
variable y_mantissa : STD_LOGIC_VECTOR (9 downto 0);
variable y_exponent : STD_LOGIC_VECTOR (4 downto 0);
variable y_sign : STD_LOGIC;
variable z_mantissa : STD_LOGIC_VECTOR (20 downto 0);
variable z_exponent : STD_LOGIC_VECTOR (5 downto 0);
variable z_sign : STD_LOGIC;
variable a : STD_LOGIC_VECTOR (22 downto 0);
variable temp_1 : STD_LOGIC_VECTOR (21 downto 0);
variable temp_2 : STD_LOGIC_VECTOR (21 downto 0);
variable temp_3 : STD_LOGIC_VECTOR (5 downto 0);

begin
x_mantissa := x(9 downto 0);
x_exponent := x(14 downto 10);
x_sign := x(15);
y_mantissa := y(9 downto 0);
y_exponent := y(14 downto 10);
y_sign := y(15);
z_sign := x_sign xor y_sign;

if (y_exponent="11111") then 
 z_exponent := "000000";
 z_mantissa := (others=>'0');
elsif (y_exponent=0 or x_exponent=31) then 
 z_exponent := "111111";
 z_mantissa := (others=>'0');
else
 temp_3 := ('0' & x_exponent) - ('0' & y_exponent) + 31;
temp_1 := "01" & x_mantissa & "0000000000";
digit_loop: for i in 22 downto 0 loop
 temp_2 := temp_1 - ("01" & y_mantissa & "0000000000");
 if ( temp_2(21)='0' ) then 
    a(i):='1';
    temp_1 := temp_2;
 else
    a(i):='0';
end if;
temp_1 := temp_1(20 downto 0) & '0'; 
end loop digit_loop;

a := a + 1;
if (a(22)='1') then
 z_mantissa := a(21 downto 1);
else
 z_mantissa := a(20 downto 0);
 temp_3 := temp_3 - 1;
end if;


end if;
 z_exponent := temp_3(5 downto 0);
z(20 downto 0) <= z_mantissa;
z(26 downto 21) <= z_exponent;
z(27) <= z_sign;
end process;
end Behavioral;
