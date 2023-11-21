library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all; 

entity fsm_mode is

port (  reset, clk: in std_logic;
		operasi: in std_logic (1 down to 0);
		hasil_xor: in std_logic (1 down to 0)
		);

end fsm_mode;

architechture fsm_mode_arc of fsm_mode is

type states is (init, s0, s1, s2, s3, s4);
signal nstate, curstate: states;

begin
	process
	begin
		wait until (clk'event) and (clk = '1');
		if (reset = '1') then
		currentState <= init;
		else
		currentState <= nextState;
		end if;
	end process;

process (operasi, hasil_xor, reset)
begin
	case curstate is
		when s0 =>
		if operasi = "00" then
			if hasil_xor = ("00") then
				nstate <= s1; -- Adder
			else
				nstate <= s2; -- Subtractor
			end if;
		elsif operasi = "01" then
			if hasil_xor = ("00") then
				nstate <= s2; -- Subtractor
			else
				nstate <= s1; -- Adder
			end if;
		elsif operasi = "10" then
			nstate <= s3; -- Multiplication
		elsif operasi = "11" then
			nstate <= s4; -- Divider
		else
			next_state <= s0; -- Reset state
		end if;

	end case;
end process;
end fsm_mode_arc;
