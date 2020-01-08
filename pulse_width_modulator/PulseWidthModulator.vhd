Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity PulseWidthModulator is
	generic(res : integer := 8; freq : integer := 1000);
	port(
	RST : in std_logic;
	CLK : in std_logic;
	DUT : in std_logic_vector(res - 1 downto 0);
	PWM : out std_logic
	);
end PulseWidthModulator;

Architecture Structural of PulseWidthModulator is
Component Timer is generic(Ticks : integer := 10);
	port(
	RST : in std_logic;
	CLK : in std_logic;
	EOT : out std_logic);
end Component;
Component Counter is generic(busWidth : integer := 8);
	port(
	RST : in std_logic;
	CLK : in std_logic;
	INC : in std_logic;
	CNT : out std_logic_vector(busWidth - 1 downto 0));
end Component;
signal SYN : std_logic;
signal CNT : std_logic_vector(res - 1 downto 0);
begin
	PWM <= '1' when DUT > CNT else '0';
	U01 : Timer generic map(1e8/(freq * 2**res)) port map(RST, CLK, SYN);
	U02 : Counter generic map(res) port map(RST, CLK, SYN, CNT);
end Structural;