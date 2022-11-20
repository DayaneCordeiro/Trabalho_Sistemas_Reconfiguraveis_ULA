LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.numeric_std.all;
-------------------------------------------------------------------------------------------------
ENTITY contador_sincrono IS
	PORT ( 
		 --BANCO DE REGISTRADORES
		 --ENTRADAS
		 clk_in :IN STD_LOGIC; 								--CLOCK
		 nrst :IN STD_LOGIC; 								--CLEAR
		 load_ena: IN STD_LOGIC;							--HABILITAR CARREGAMENTO DO LOAD
		 cnt_ena: IN STD_LOGIC;     				 		--HABILITAR CONTAGEM
		 new_cnt_in: IN STD_LOGIC_VECTOR (10 DOWNTO 0);	    --ENTRADA DE DADOS
		 --SAIDAS
		 next_cnt_out: OUT STD_LOGIC_VECTOR(10 DOWNTO 0) ;  --SAIDA A DADOS REGISTRADORES (0 a 10)
		 cnt_out: OUT STD_LOGIC_VECTOR(10 DOWNTO 0)  	    --SAIDA B DADOS REGISTRADORES (0 a 10)
		 ) ;
	END contador_sincrono ;
----------------------------------------------------------------------------------------------------	
ARCHITECTURE Behavior OF contador_sincrono IS
		SIGNAL new_cnt_in_aux :STD_LOGIC_VECTOR(10 DOWNTO 0); 
		SIGNAL int_aux : INTEGER RANGE 0 TO 2047; 
	BEGIN	
		PROCESS(clk_in,nrst,cnt_ena,load_ena)
				VARIABLE cnt : INTEGER RANGE 0 to 2047;
			BEGIN
				IF nrst = '0' THEN
						cnt:=0;
						int_aux <=0;
						next_cnt_out <=(OTHERS=>'0');
					ELSIF RISING_EDGE(clk_in) THEN
					IF load_ena ='1' THEN
						next_cnt_out <= new_cnt_in;
					ELSIF cnt_ena ='1' THEN
						cnt := cnt+1;
						int_aux <= cnt;
						
					END IF;
				END IF;
		END PROCESS;
		cnt_out <= std_logic_vector(to_unsigned(int_aux, new_cnt_in'length));	
END Behavior ;
