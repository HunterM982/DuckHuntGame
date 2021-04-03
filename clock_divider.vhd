library IEEE;
use IEEE.STD_LOGIC_1164.all;

ENTITY clock_divider IS
   GENERIC (n: INTEGER := 2*10**7);
   PORT(clk_in: IN STD_LOGIC;
	clk_out: OUT STD_LOGIC);
END;

ARCHITECTURE RTL OF clock_divider IS
   SIGNAL count: INTEGER range 0 to ((4*10**7)-1);
   SIGNAL internal: STD_LOGIC:='0';
BEGIN
   PROCESS (clk_in)
   BEGIN
	IF (clk_in'event AND clk_in = '1') THEN
	  count <= count + 1;
	  IF (count = n) THEN
	    internal <= not internal;
	    clk_out <= internal;
	    count <= 0;
	  END IF;
	END IF;
   END PROCESS;
END;