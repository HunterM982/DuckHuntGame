-- This program generates the image of a square "ball" moving up and down in the center of the screen.
library IEEE;
use IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all; 

entity make_image1 is
	port(
		--vsync:  in std_logic;
		pixel_row:  in integer range 0 to 480; 
		pixel_column: in integer range 0 to 640;
		y_position: in integer range 0 to 480; 
		x_position: in integer range 0 to 640;
		red, green, blue: out std_logic_vector(7 downto 0));
end;
architecture image of make_image1 is
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
	SIGNAL frame_on:     STD_LOGIC;

	SIGNAL size : 			integer range 0 to 30;
	SIGNAL ball_on:    STD_LOGIC;
	CONSTANT bottom_of_screen: integer := 480;
	CONSTANT top_of_screen: integer := 1;
	CONSTANT right_of_screen: integer := 640;
	CONSTANT left_of_screen: integer := 1;
	CONSTANT frame: integer := 30;

	
BEGIN 
			
	size <= round_ball'length-1;  			-- size of the ball
	-- The x position of the square goes from (x_position) to (x_position + size).
	-- The y position of the square goes from (y_position) to (y_position + size).

------------------------------------
	-- checking if the pixel scanned is located within the square ball.
	check_pixel:  PROCESS (x_position, y_position, pixel_column, pixel_row, size)
   BEGIN
		IF(pixel_column <= (left_of_screen + frame)) OR (pixel_column >= (right_of_screen - frame)) OR
		(pixel_row <= (top_of_screen + frame)) OR (pixel_row >= (bottom_of_screen - frame))
		THEN
			frame_on <= '1';
		ELSE
			frame_on <= '0';
		END IF;
		
		IF(pixel_column <= (x_position + size)) AND (pixel_column >= (x_position)) AND
		(pixel_row <= (y_position + size)) AND (pixel_row >= (y_position))
		THEN
			ball_on <= round_ball(pixel_row - y_position)(pixel_column - x_position);
		ELSE
			ball_on <= '0';
		END IF;
		
	END PROCESS;
--------------------------------	
	setcolor:  PROCESS (ball_on)
	BEGIN
			CASE ball_on IS
				WHEN '1' =>
					red <=  (OTHERS => '0');  -- making the ball red
					green <= (OTHERS => '0'); -- turning off green when displaying the ball
					blue  <= (OTHERS => '1'); -- turning off blue when displaying the ball
				WHEN OTHERS =>
					CASE frame_on IS
						WHEN '1' =>
							red <=  (OTHERS => '0');  -- making the ball red
							green <= (OTHERS => '1'); -- turning off green when displaying the ball
							blue  <= (OTHERS => '0'); -- turning off blue when displaying the ball
						WHEN OTHERS =>
							red <=  (OTHERS => '1');  -- making the ball red
							green <= (OTHERS => '1'); -- turning off green when displaying the ball
							blue  <= (OTHERS => '1'); -- turning off blue when displaying the ball
						END CASE;
			END CASE;
	END PROCESS;
					
END;
