library ieee;
use ieee.std_logic_1164.all;

ENTITY score_keeper IS

PORT ( dif: IN std_logic_vector(1 DOWNTO 0);
	death, vsync: IN std_logic;
	req_one,req_ten,score_one,score_ten: OUT INTEGER RANGE 0 TO 9);
END score_keeper;

ARCHITECTURE tracking OF score_keeper IS
SIGNAL req: INTEGER RANGE 0 TO 99;
SIGNAL score: INTEGER RANGE 0 TO 99;

BEGIN
-- Set score requirements for difficulty
WITH dif SELECT 
	req <= 10 WHEN "00",
		   20 WHEN "01",
		   30 WHEN OTHERS;
PROCESS(death)
	score <= score + 1;
		   
PROCESS(vsync)
	BEGIN	
		req_one <= req mod 10;
		req_ten <= req/10;
		score_one <= score mod 10;
		score_ten <= score/10;
END; 
