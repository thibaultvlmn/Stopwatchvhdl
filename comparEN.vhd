-- Compare : allows to activate another counter  once the first counter  reaches 9 
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity comparEN is 
	port(
		ENin : in std_logic;	-- EN général du counter par 1000
		Q : in std_logic_vector(3 downto 0);	-- Sortie du counter précédant
		ENout : out std_logic	-- EN du counter next
		);
end comparEN;

architecture arch of comparEN is
begin
	process(ENin, Q)
	begin
		if(ENin = '1' and conv_integer(Q) = 9) then
			ENout <= '1';
		else
			ENOut <= '0';
		end if;
	end process;
end arch;