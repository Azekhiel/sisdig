library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--perlu bikin kode agar binary yg dibaca input tuh bisa dipisah
--16 bit pertama input1 (TRANSLATE)
--berapa bit buat +-*/ (TRANSLATE BIN DARI TERMINAL TO IN_SEL)
--last 16 bit input2 (TRANSLATE)
--extract input from rx
entity ascii_to_binary is
    port (
        clk : in std_logic;
        reset : in std_logic;
        rx : in std_logic;
        tx : buffer character
    );
end entity ascii_to_binary;

architecture RTL of ascii_to_binary is
    signal data : character;
    signal binary : unsigned(31 downto 0);
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                binary <= (others => '0');
            elsif rx = '1' then
                data <= tx;
                binary <= binary(23 downto 0) & to_unsigned(character'pos(data), 8);
            end if;
        end if;
    end process;
end architecture RTL;
