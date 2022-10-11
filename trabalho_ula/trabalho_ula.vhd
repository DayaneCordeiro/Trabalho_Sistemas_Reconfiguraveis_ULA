LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
----------------------------------------
ENTITY trabalho_ula IS
	PORT (
		input_a, input_b: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		operator: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		carry_in: IN STD_LOGIC;
		
		result: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		carry_out: OUT STD_LOGIC;
		zero_out: OUT STD_LOGIC
	);
END ENTITY;
----------------------------------------
ARCHITECTURE ula OF trabalho_ula IS

SIGNAL aux : STD_LOGIC_VECTOR(8 DOWNTO 0);

BEGIN
	WITH operator SELECT
		aux <=  '0' & (input_a AND input_b) WHEN "0000",					-- AND
				'0' & (input_a OR input_b) WHEN "0001",						-- OR
				'0' & (input_a XOR input_b) WHEN "0010",					-- XOR
				'0' & (NOT input_a) WHEN "0011",							-- COM
				(('0' & input_a) + ('0' & input_b)) WHEN "0100",			-- ADD
				(('0' & input_a) + ('0' & input_b) + carry_in) WHEN "0101",	-- ADDC
				(('0' & input_a) - ('0' & input_b)) WHEN "0110",			-- SUB
				((input_a) - (input_b) - carry_in) WHEN "0111",				-- SUBC
				(input_a(7) & input_a(6 DOWNTO 0) & carry_in) WHEN "1000",	-- RL
				(input_a(0) & carry_in & input_a(7 DOWNTO 1)) WHEN "1001",	-- RR
				(input_a(0) & carry_in & input_a(7 DOWNTO 1)) WHEN "1010",	-- RLC
				(input_a(0) & carry_in & input_a(7 DOWNTO 1)) WHEN "1011",	-- RRC
				('0' & input_a(6 DOWNTO 0) & '0') WHEN "1100",				-- SLL
				("00" & input_a(7 DOWNTO 1)) WHEN "1101",					-- SRL
				("01" & input_a(7 DOWNTO 1)) WHEN "1110",					-- SRA
				'0' & input_b WHEN "1111";									-- PASS_B
			
		result <= aux(7 DOWNTO 0);
		
	WITH operator SELECT
		carry_out <= aux(8) WHEN "0101",
					 aux(8) WHEN "0111",
					 input_a(7) WHEN "1100",
					 input_a(0) WHEN "1101",
					 '0' WHEN OTHERS;
	
	zero_out <= '1' WHEN aux = "00000000" ELSE '0';
END ula;