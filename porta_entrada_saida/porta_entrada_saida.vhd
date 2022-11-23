
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY porta_entrada_saida IS
	GENERIC (
		base_addr : STD_LOGIC_VECTOR (8 DOWNTO 0) := "000000001" );
	PORT(
		nrst, clk_in, wr_en, rd_en: IN STD_LOGIC;
		abus: IN STD_LOGIC_VECTOR(8 DOWNTO 0);
		dbus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		port_io: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		
	);
END ENTITY;

ARCHITECTURE arch OF porta_entrada_saida IS
	SIGNAL port_reg : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL dir_reg : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL latch : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL i : INTEGER;
BEGIN
PROCESS(nrst, clk_in, abus, dbus, wr_en, rd_en, latch,dir_reg, port_reg)
	BEGIN
		
		IF nrst = '0' THEN 
			port_reg <= (OTHERS => '0');
			dir_reg <= (OTHERS => '0');
			IF rd_en = '1' AND abus = base_addr THEN
					dbus <= latch; 
				ELSIF rd_en = '1' AND abus = base_addr THEN
					dbus <= dir_reg; 
				ELSE
					dbus <= "ZZZZZZZZ";
				END IF;
		ELSIF RISING_EDGE(clk_in) THEN
				IF wr_en = '1' AND abus  = base_addr  THEN 
					port_reg <= dbus; 
				ELSIF wr_en = '1' AND abus = base_addr  THEN
					dir_reg <= dbus;
				END IF;
		END IF;	
		FOR i IN 0 TO 7 LOOP
			IF dir_reg(i) = '0' THEN
				port_io(i) <= port_reg(i);
			ELSE
				port_io(i) <= 'Z';
			END IF;
		END LOOP;
		
	END PROCESS;
END arch;
