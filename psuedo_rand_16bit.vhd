library ieee;
use ieee.std_logic_1164.all;

ENTITY psuedo_rand_16bit IS
	PORT( rand_x_pos: OUT INTEGER 0 TO 640);
END psuedo_rand_16bit;


ARCHITECTURE rand OF psuedo_rand_16bit IS

CONSTANT seed: std_logic_vector(15 DOWNTO 0) := "0110011000100110";
SIGNAL reg_shift: std_logic_vector(15 DOWNTO 0);
SIGNAL temp: std_logic;


BEGIN

	PROCESS
		BEGIN
			WAIT UNTIL (vsync'event AND vsync = '1');
				
				

