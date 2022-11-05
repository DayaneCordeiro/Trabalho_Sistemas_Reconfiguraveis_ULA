LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.numeric_std.all;

ENTITY banco_registradores_8_bits IS
	PORT ( 
		 --BANCO DE REGISTRADORES
		 --ENTRADAS
		 clk_in :IN STD_LOGIC; 							 --CLOCK
		 nrst :IN STD_LOGIC; 							 --CLEAR
		 regn_di :IN STD_LOGIC_VECTOR(7 DOWNTO 0) ;		 --INPUT DADOS
		 regn_wr_sel :IN STD_LOGIC_VECTOR(2 DOWNTO 0);	 --SELETOR DE OPERAÇAO
		 regn_wr_ena: IN STD_LOGIC;						 --SELETOR DE REGISTRADOR
		 regn_rd_sel_a: IN STD_LOGIC_VECTOR (2 DOWNTO 0);--SELETOR LEITURA SAIDA A
		 regn_rd_sel_b: IN STD_LOGIC_VECTOR (2 DOWNTO 0);--SELETOR LEITURA SAIDA B
		 regz_di: IN STD_LOGIC_VECTOR(7 DOWNTO 0) ;		 --INPUT DADOS REGISTRADOR Z
		 regz_wr_ena: IN STD_LOGIC;						 --HABILITAR ESCRITA P/REGISTRADOR Z
		 regc_di : IN STD_LOGIC_VECTOR(7 DOWNTO 0) ;     --INPUT DADOS REGISTRADOR C
		 regc_wr_ena: IN STD_LOGIC;						 --HABILITAR ESCRITA P/REGISTRADOR C		
		 --SAIDAS
		 regn_do_a: OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;		--SAIDA A DADOS REGISTRADORES (0 a 7)
		 regn_do_b: OUT STD_LOGIC_VECTOR(7 DOWNTO 0) ;  	--SAIDA B DADOS REGISTRADORES (0 a 7)
		 regz_do :OUT STD_LOGIC_VECTOR(7 DOWNTO 0);			--SAIDA DADOS REGISTRADOR Z									
		 regc_do: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)			--SAIDA DADOS REGISTRADOR C
		 ) ;
	END banco_registradores_8_bits ;
ARCHITECTURE Behavior OF banco_registradores_8_bits IS
		TYPE mem_type IS ARRAY(0 TO 7) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
		SIGNAL mem_reg : mem_type;
		SIGNAL regn_wr_sel_int : INTEGER RANGE  0 TO 7;
		SIGNAL regn_rd_sel_a_int: INTEGER RANGE 0 TO 2;
		SIGNAL regn_rd_sel_b_int: INTEGER RANGE 0 TO 2;
	BEGIN
		regn_wr_sel_int <= TO_INTEGER(UNSIGNED(regn_wr_sel));
		regn_rd_sel_a_int <= TO_INTEGER(UNSIGNED(regn_rd_sel_a));
		regn_rd_sel_b_int <= TO_INTEGER(UNSIGNED(regn_rd_sel_b));
		PROCESS ( nrst, clk_in )
			BEGIN
				IF nrst = '1' THEN
					mem_reg <= (OTHERS => (OTHERS => '0'));
					regc_do <= "00000000";
					regz_do <= "00000000";
				ELSIF RISING_EDGE(clk_in) THEN 
					IF(regn_wr_ena = '1') THEN
						mem_reg(regn_wr_sel_int) <= regn_di;
					END IF;	
					IF regz_wr_ena ='1' THEN
						regz_do <= regz_di;
					END IF;
					IF regc_wr_ena ='1' THEN
						regc_do <= regc_di;
					END IF;				
				END IF;		
	END PROCESS;
	regn_do_a <= mem_reg(regn_rd_sel_a_int);
	regn_do_b <= mem_reg(regn_rd_sel_b_int);
END Behavior ;