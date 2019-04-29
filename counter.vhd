-- counter  1000 : implements 3 counter s 10 with 2 comparEN to link them
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity counter is
	port(
		clk_in : in std_logic;	 -- 50 MHz ?
		nclear : in std_logic;	-- clear counter
		EN : in std_logic;	
		cpt : out std_logic_vector(11 downto 0)	-- Output of the counter on 12 bits, each digit coded on 4 bits
	);
end counter;

architecture arch of counter is
signal clock : std_logic; -- Output of clock divider
signal S : std_logic_vector(11 downto 0);	-- S signal use ton return the ouptu of counter10 going inside the comparEN modules
component counter10 is
	port(
		Q : out std_logic_vector(3 downto 0);
		nclear : in std_logic;
		EN : in std_logic;
		clk : in std_logic
		);
end component;

component div is
	port(
		clk_in : in std_logic;
		clk : out std_logic
	);
end component;

component comparEN is
	port(
		ENin : in std_logic;
		Q : in std_logic_vector(3 downto 0);
		ENout : out std_logic
	);
end component;

signal EN1, EN2 : std_logic;
begin
cpt <= S;
U0 : div port map(clk_in, clock);
U1 : counter10 port map(S(3 downto 0), nclear, EN, clock);
U2 : comparEN port map(EN, S(3 downto 0), EN1);
U3 : counter10 port map(S(7 downto 4), nclear, EN1, clock);
U4 : comparEN port map(EN1, S(7 downto 4), EN2);
U5 : counter10 port map(S(11 downto 8), nclear, EN2, clock);
end arch;