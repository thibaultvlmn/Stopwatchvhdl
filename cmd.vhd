library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity cmd is
	port(
		clk_in, a,b : in std_logic; -- Horloge et boutons d'entrée du chronomètre
		EN, nload, nclear : out std_logic	-- Signaux utilisable directement sur le chronomètre
	);
end entity;

architecture a of cmd is
type state is (clear, stop1, run1, run2, stop2);
signal current : state := clear;
signal nexti: state ;
begin
-- Définition de l'état nexti en fonction de l'état actuel et des variables d'entrées
process(current, a, b)
begin
	case current is
		when clear => nexti <= stop1;
		when stop1 => if a = '1' then
								nexti <= run1;
							elsif b = '1' then
								nexti <= clear;
							else	
								nexti <= stop1;
							end if;
		when run1 => if a = '1' then
								nexti <= stop1;
							elsif b = '1' then
								nexti <= run2;
							else
								nexti <= run1;
							end if;
		when run2 => if a = '1' then
								nexti <= stop2;
							elsif b = '1' then
								nexti <= run1;
							else
								nexti <= run2;
							end if;
		when stop2 => if a = '1' then	
								nexti <= run2;
							elsif b = '1' then
								nexti <= stop1;
							else
								nexti <= stop2;
							end if;
	end case;
end process;
-- Passage à l'état nexti à chaque coup d'horloge
process(clk_in)
begin
	if clk_in'event and clk_in = '1' then
		current <= nexti;
	end if;
end process;
-- Pour chaque état correspond des états pour les sorties
process(current)
begin
	case current is
		when clear => EN <= '0';
							nload <= '0';
							nclear <= '0';
		when stop1 => EN <= '0';
							nload <= '0';
							nclear <= '1';
		when run1 => EN <= '1';
							nload <= '0';
							nclear <= '1';
		when run2 => EN <= '1';
							nload <= '1';
							nclear <= '1';	
		when stop2 => EN <= '0';
							nload <= '1';
							nclear <= '1';	
	end case;
end process;
end a;