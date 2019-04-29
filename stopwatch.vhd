-- Stopwatch : implements the counter  by 1000, the 3 7 segments display and the memory
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity stopwatch is
	port(
		clk_in : in std_logic; -- clock
		nclear : in std_logic;	-- clear of the stopwatch
		nload : in std_logic;	-- allows at low level to record the memory the value of the counter 
		EN : in std_logic;	-- Activate/deactivate the counter 
		HEX0, HEX1, HEX2 : out std_logic_vector(6 downto 0)	-- 7 segments display
		);
end stopwatch;

architecture a of stopwatch is
signal S : std_logic_vector(11 downto 0);
signal mem : std_logic_vector(11 downto 0);
component counter is
	port(
		clk_in : in std_logic;
		nclear : in std_logic;
		EN : in std_logic;
		cpt : out std_logic_vector(11 downto 0)
	);
end component;
component display is
	port(
		E : in std_logic_vector(3 downto 0);
		HEX : out std_logic_vector(6 downto 0)
		);
end component;
component memory is 
	port(
		clk : in std_logic;
		nload : in std_logic;
		cpt : in std_logic_vector(11 downto 0);
		mem : out std_logic_vector(11 downto 0)
		);
end component;
begin
U0 : counter port map(clk_in, nclear, EN, S);
U1 : display port map(mem(3 downto 0), HEX0);		
U2 : display port map(mem(7 downto 4), HEX1);
U3 : display port map(mem(11 downto 8), HEX2);
U4 : memory port map(clk_in, nload, S, mem);
end a;