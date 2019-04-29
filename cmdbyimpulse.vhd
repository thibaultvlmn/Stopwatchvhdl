-- Uses the "limiter" on inputs of the buttons to limit to one clock cycle 
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity cmdbyimpulse is
	port(
		clk, pb1, pb2 : in std_logic;
		nclear, EN, nload : out std_logic
	);
end entity;

architecture a of cmdbyimpulse is
signal a,b : std_logic;
component cmd is
	port(
		clk_in, a,b : in std_logic;
		EN, nload, nclear : out std_logic
	);
end component;
component one_impulse is
	port(
		clk_in : in std_logic;
		E : in std_logic;
		S : out std_logic
	);
end component;
begin
U0 : cmd port map(clk, a, b, EN, nload, nclear);
U1 : one_impulse port map(clk, pb1, a);
U2 : one_impulse port map(clk, pb2, b);
end a;