-- one_impulse : limits the button ton only one cycle
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity one_impulse is
	port(
		clk_in : in std_logic;
		E : in std_logic;	
		S : out std_logic	
	);
end entity;

architecture a of one_impulse is
type state is (X0,X1,X2);
signal current, nexti : state := X0;
begin
process(E, current)
begin
	-- combinatory system :we have to define the output every time
	case current is
		when X0 => if E = '0' then	
							S <= '1';
							nexti <= X1;
						else
							S <= '0';
							nexti <= X0;
						end if;
		when X1 =>  S <= '0';	--when we are at state x1, output is 0
						if E = '1' then
							nexti <= X0;
						else
							nexti <= X2;	--if input always active, output is state X2
						end if;
		when X2 => S <= '0';
						
						if E = '1' then
							nexti <= X0;
						else
							nexti <= X2;
						end if;
	end case;
	
end process;
process(clk_in)
begin
	
	if clk_in'event and clk_in = '1' then
		current <= nexti;
	end if;	
end process;

end a;