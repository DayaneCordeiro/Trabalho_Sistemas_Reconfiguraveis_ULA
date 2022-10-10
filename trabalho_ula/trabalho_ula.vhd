LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
----------------------------------------
ENTITY trabalho_ula IS
	PORT (
		input_a, input_b: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		operator: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		carry_in: IN STD_LOGIC
		
		result: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		carry_out: OUT STD_LOGIC
		zero_out: OUT STD_LOGIC
	);
END ENTITY;
----------------------------------------
ARCHITECTURE trabalho_ula OF alu IS

SIGNAL aux : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN
	WITH operator SELECT
		aux <= input_a AND input_b WHEN "000",
			input_a OR input_b WHEN "001",
			input_a XOR input_b WHEN "010",
			NOT input_a WHEN "011",
			input_a SLL WHEN "100",
			input_a SRL WHEN "101",
			input_a + input_b WHEN "110",
			input_a - input_b WHEN "111";
			
			result <= aux;
			zero_out <= '1' WHEN aux = "00000000" ELSE '0';
END trabalho_ula;