-- This program generates the image of a square "ball" moving up and down in the center of the screen.
library IEEE;
use IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all; 

entity user_input is
	port(
		vsync:  in std_logic;
		switch_in: in std_logic_vector(2 downto 0);
		ball_down, ball_up: in std_logic;
		ball_left, ball_right: in std_logic;
		
		y_position: out integer range 0 to 480; 
		x_position: out integer range 0 to 640;
		switch_out: out std_logic_vector(1 downto 0));
end;
architecture image of user_input is
TYPE my_ROM is array (0 to 20) of std_logic_vector (0 to 20);
	CONSTANT round_ball: my_ROM :=( 
	"000000000010000000000",
	"000000000010000000000",
	"000000000010000000000",								
	"000000000010000000000",								
	"000000000010000000000",
	"000000000010000000000",
	"000000000010000000000",
	"000000000010000000000",								
	"000000000010000000000",								
	"000000000010000000000",
	"111111111111111111111",
	"000000000010000000000",
	"000000000010000000000",	
	"000000000010000000000",	
	"000000000010000000000",
	"000000000010000000000",
	"000000000010000000000",
	"000000000010000000000",								
	"000000000010000000000",								
	"000000000010000000000",
	"000000000010000000000" );

	SIGNAL size : 			integer range 0 to 30;
	SIGNAL ball_on:    STD_LOGIC;
	SIGNAL ball_y_motion: integer range -10 to 10; 
	SIGNAL ball_x_motion: integer range -10 to 10;
	SIGNAL ball_y_pos: 	 integer range 0 to 480; 
	SIGNAL ball_x_pos:    integer range 0 to 640;
	SIGNAL speed: integer range 0 to 10;
	CONSTANT bottom_of_screen: integer := 480;
	CONSTANT top_of_screen: integer := 1;
	CONSTANT right_of_screen: integer := 640;
	CONSTANT left_of_screen: integer := 1;
	CONSTANT frame: integer := 30;

	
BEGIN 
			
	size <= round_ball'length-1;  			-- size of the ball
	
	setDifficulty: PROCESS(switch_in)
		BEGIN
			IF(switch_in(2)='1') THEN
				switch_out<="11";
				speed <= 10;
			ELSIF(switch_in(1)='1') THEN
				switch_out <= "10";
				speed <= 5;
			ELSE
				switch_out <= "01";
				speed <= 0;
			END IF;
		END PROCESS;
	
	ballmove: PROCESS
		BEGIN
		WAIT UNTIL (vsync'event AND vsync = '1');	
				IF ((ball_up = '1') AND (ball_down = '1')) THEN
					ball_y_motion <= 0;
				ELSIF(ball_down = '1') THEN
					ball_y_motion <= (0-speed);
				ELSIF( ball_up = '1') THEN
					ball_y_motion <= speed;
				ELSE
					ball_y_motion <= 0;
				END IF;
				
				IF ((ball_left = '1') AND (ball_right = '1')) THEN
					ball_x_motion <= 0;
				ELSIF(ball_left = '1') THEN
					ball_x_motion <= (0-speed);
				ELSIF( ball_right = '1') THEN
					ball_x_motion <= speed;
				ELSE
					ball_x_motion <= 0;
				END IF;
				ball_y_pos <= ball_y_pos + ball_y_motion;
				ball_x_pos <= ball_x_pos + ball_x_motion;
				
				IF(ball_x_pos < (left_of_screen+frame)) THEN
					ball_x_pos <= (left_of_screen+frame+1);
				ELSIF((ball_x_pos+size) > (right_of_screen-frame)) THEN
					ball_x_pos <= (right_of_screen-frame-size-1);
				END IF;
				IF(ball_y_pos < (top_of_screen+frame)) THEN
					ball_y_pos <= (top_of_screen+frame+1);
				ELSIF((ball_y_pos+size) > (bottom_of_screen-frame)) THEN
					ball_y_pos <= (bottom_of_screen-frame-size-1);
				END IF;			
				y_position <= ball_y_pos; 
				x_position <= ball_x_pos;
	END PROCESS;				
END;
