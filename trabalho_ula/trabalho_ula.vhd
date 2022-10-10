LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
----------------------------------------
ENTITY trabalho_ula IS
	PORT (
		a, b: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		op: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		r: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		z: OUT STD_LOGIC
	);
END ENTITY;
----------------------------------------
ARCHITECTURE trabalho_ula OF alu IS

SIGNAL aux : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN
	WITH op SELECT
		aux <= a AND b WHEN "000",
			a OR b WHEN "001",
			a XOR b WHEN "010",
			NOT a WHEN "011",
			a SLL WHEN "100",
			a SRL WHEN "101",
			a + b WHEN "110",
			a - b WHEN "111";
			r <= aux;
			z <= '1' WHEN aux = "00000000" ELSE '0';
END trabalho_ula;