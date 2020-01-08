Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

Entity ServoPWM is
	port(
	RST : in std_logic;
	CLK : in std_logic;
	ANG : in std_logic_vector(7 downto 0);
	PWM : out std_logic
	);
end ServoPWM;

Architecture Structural of ServoPWM is
Component Timer is generic(Ticks : integer := 10);
	port(
	RST : in std_logic;
	CLK : in std_logic;
	EOT : out std_logic);
end Component;
Component CounterM1800 is port(
	RST : in std_logic;
	CLK : in std_logic;
	INC : in std_logic;
	CNT : out std_logic_vector(10 downto 0));
end Component;
signal SYN : std_logic;
signal CNT : std_logic_vector(10 downto 0);
signal DUT : std_logic_vector(10 downto 0);
begin
	DUT <= ("000" & ANG) + 45;
	PWM <= '1' when DUT > CNT else '0';
	U01 : Timer generic map(1111) port map(RST, CLK, SYN);
	U02 : CounterM1800 port map(RST, CLK, SYN, CNT);
end Structural;