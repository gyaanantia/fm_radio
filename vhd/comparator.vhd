library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Additional standard or custom libraries go here
entity comparator is
	generic(
	DATA_WIDTH : natural := 16
	);
port(
	--Inputs
	DINL : in std_logic_vector (DATA_WIDTH downto 0);
	DINR : in std_logic_vector (DATA_WIDTH - 1 downto 0);
	--Outputs
	DOUT : out std_logic_vector (DATA_WIDTH - 1 downto 0);
	isGreaterEq : out std_logic
);
end entity comparator;
architecture behavioral of comparator is
	--Signals and components go here
	SIGNAL diff : std_logic_vector (DATA_WIDTH downto 0);
	begin
		--Behavioral design goes here
		diff <= std_logic_vector(signed(DINL) - signed('0' & DINR));
		DOUT <= std_logic_vector(resize(unsigned(diff), DATA_WIDTH)) when signed(diff) >= 0 else std_logic_vector(resize(unsigned(DINL), DATA_WIDTH));
		isGreaterEq <= '1' when signed(diff) >= 0 else '0';
end architecture behavioral;
