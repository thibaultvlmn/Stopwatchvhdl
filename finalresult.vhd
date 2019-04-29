-- Global function of the stopwatch
-- the entries are the buttons pb1 and pb2 are sent in the impulsion "filters"
-- the output of the stopwatch is transmitted to the 7 segments 
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity final_result is
	port(
		clk_in, pb1, pb2 : in std_logic;
		HEX0, HEX1, HEX2 : out std_logic_vector(6 downto 0)
	);
end entity;

architecture a of final_result is
component cmdbyimpulse is
	port(
		clk, pb1, pb2 : in std_logic;
		nclear, EN, nload : out std_logic
	);
end component;
component stopwatch is
	port(
		clk_in : in std_logic;
		nclear : in std_logic;
		nload : in std_logic;
		EN : in std_logic;
		HEX0, HEX1, HEX2 : out std_logic_vector(6 downto 0)
		);
end component;
component div is
	port(
		clk_in : in std_logic;
		clk : out std_logic
	);
end component;
signal EN, nclear, nload, clkDiv : std_logic;
begin
U0 : stopwatch port map(clk_in, nclear, nload, EN, HEX0, HEX1, HEX2);
U1 : cmdbyimpulse port map(clkDiv, pb1, pb2, nclear, EN, nload);
U3 : div port map(clk_in, clkDiv);
end a;