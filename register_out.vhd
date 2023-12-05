ENTITY register_out IS
PORT (
  reg_in   : IN STD_LOGIC_VECTOR (7 DOWNTO 0); -- input.
  ld  : IN STD_LOGIC; -- load/enable.
  clr : IN STD_LOGIC; -- async. clear.
  clk : IN STD_LOGIC; -- clock.
  reg_out   : OUT STD_LOGIC_VECTOR (32 DOWNTO 0) -- output
);
END register_out;

ARCHITECTURE RTL OF register_out IS
BEGIN
  process (clk, clr, ld)
  begin
    if clr = '1' then
      reg_out <= x"00000000";
    elsif ld = '1' and rising_edge(clk) then
      reg_out <= reg_in;
    end if;
  end process;
END description;
