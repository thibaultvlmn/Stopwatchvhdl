-- Display module : converts in on 4 bits into a signal fo 7 segments display 
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity display is
	port(
		E : in std_logic_vector(3 downto 0);
		HEX : out std_logic_vector(6 downto 0)
		);
end display;

architecture arch of display is
signal H : std_logic_vector(6 downto 0);	-- temporary signal because segments are active at low level
begin
process(E)
	begin
		if(E = "0000") then
			H <= "0111111";
		elsif(E = "0001") then
			H <= "0000110";
		elsif(E = "0010") then
			H <= "1011011";
		elsif(E = "0011") then
			H <= "1001111";
		elsif(E = "0100") then
			H <= "1100110";
		elsif(E = "0101") then
			H <= "1101101";
		elsif(E = "0110") then
			H <= "1111101";
		elsif(E = "0111") then
			H <= "0000111";
		elsif(E = "1000") then
			H <= "1111111";
		elsif(E = "1001") then
			H <= "1101111";
		else
			H <= "1111001";
		end if;
end process;
HEX <= not H;	
end arch;