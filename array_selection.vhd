LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY array_selection IS
PORT ( req_one,req_ten,score_one,score_ten: IN INTEGER RANGE 0 TO 9;
		arr_req_one,arr_req_ten,arr_score_one,arr_score_ten: OUT num_array);
END array_selection;

ARCHITECTURE number_arrays OF array_selection IS
TYPE num_array is array(0 to 6) of std_logic_vector(4 DOWNTO 0);
CONSTANT zero: num_array:= (
"01110",
"10001",
"10011",
"10101",
"11001",
"10001",
"01110");
CONSTANT one: num_array:= (
"00100",
"01100",
"00100",
"00100",
"00100",
"00100",
"01110");
CONSTANT two: num_array:= (
"01110",
"10001",
"00001",
"00010",
"00100",
"01000",
"11111");
CONSTANT three: num_array:= (
"11111",
"00010",
"00100",
"00010",
"00001",
"10001",
"01110");
CONSTANT four: num_array:= (
"00010",
"00110",
"01010",
"10010",
"11111",
"00010",
"00010");
CONSTANT five: num_array:= (
"11111",
"10000",
"11110",
"00001",
"00001",
"10001",
"01110");
CONSTANT six: num_array:= (
"00110",
"01000",
"10000",
"11110",
"10001",
"10001",
"01110");
CONSTANT seven: num_array:= (
"11111",
"00001",
"00010",
"00100",
"01000",
"01000",
"01000");
CONSTANT eight: num_array:= (
"01110",
"10001",
"10001",
"01110",
"10001",
"10001",
"01110");
CONSTANT nine: num_array:= (
"01110",
"10001",
"10001",
"01111",
"00001",
"00010",
"01100");

BEGIN

WITH req_one SELECT
arr_req_one <= one WHEN 1,two WHEN 2,three WHEN 3,four WHEN 4,five WHEN 5,six WHEN 6,seven WHEN 7,eight WHEN 8,nine WHEN 9,zero WHEN OTHERS;

WITH req_ten SELECT
arr_req_ten <= one WHEN 1,two WHEN 2,three WHEN 3,four WHEN 4,five WHEN 5,six WHEN 6,seven WHEN 7,eight WHEN 8,nine WHEN 9,zero WHEN OTHERS;

WITH score_one SELECT
arr_score_one <= one WHEN 1,two WHEN 2,three WHEN 3,four WHEN 4,five WHEN 5,six WHEN 6,seven WHEN 7,eight WHEN 8,nine WHEN 9,zero WHEN OTHERS;

WITH score_ten SELECT
arr_score_ten <= one WHEN 1,two WHEN 2,three WHEN 3,four WHEN 4,five WHEN 5,six WHEN 6,seven WHEN 7,eight WHEN 8,nine WHEN 9,zero WHEN OTHERS;

END;
