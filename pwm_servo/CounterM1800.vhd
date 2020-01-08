Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

Entity CounterM1800 is
	port(
	RST : in std_logic;
	CLK : in std_logic;
	INC : in std_logic;
	CNT : out std_logic_vector(10 downto 0)
	);
end CounterM1800;

Architecture Behavioral of CounterM1800 is
signal Qp, Qn : std_logic_vector(10 downto 0);
begin
	Combinational : process(Qp, INC)
	begin
		if INC = '1' then
			if Qp = "11100000111" then
				Qn <= (others => '0');
			else
				Qn <= Qp + 1;
			end if;
		else
			Qn <= Qp;
		end if;
		CNT <= Qp;
	end process Combinational;
	Sequential : process(RST, CLK)
	begin
		if RST = '0' then
			Qp <= (others => '0');
		elsif CLK'event and CLK = '1' then
			Qp <= Qn;
		end if;
	end process Sequential;
end Behavioral;