-- Clock divider :converts the internal clock system into a clock of 1/10s period
-- However, i dont remember the values of the internal clock of the board so i selected 50Mhz for simulation
-- 50 MHz =>  0,02 µs period
-- output period of 0,1 s = 100 000 µs = 0,02 * 5 000 000
-- We divide 5 000 000 by 2, the first half is an output equal to 1 and the second half is 0 
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity div is
	port(
		clk_in : in std_logic;
		clk : out std_logic
	);
end div;

architecture arch of div is
signal compt : integer range 0 to 5000000 := 0;	-- counter of the number of clock cycle
begin
process(clk_in)
begin
	if(clk_in'event and clk_in = '1') then
		if (compt < 2500000) then 
			clk <= '0';
		else
			clk <= '1';
		end if;
		if(compt = 5000000) then --  0 when the counter reaches 5 000 000
			compt <= 0;
		else
			compt <= compt + 1;
		end if;
	end if;
end process;
end arch;
	