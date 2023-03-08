library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use WORK.divider_const.all;

--Additional standard or custom libraries go here

entity divider is
    port(
		--Inputs
		clk : in std_logic;
		--COMMENT OUT clk signal for Part A.
		start : in std_logic;
		reset : in std_logic;
		dividend : in std_logic_vector (DIVIDEND_WIDTH - 1 downto 0);
		divisor : in std_logic_vector (DIVISOR_WIDTH - 1 downto 0);
		--Outputs
		quotient : out std_logic_vector (DIVIDEND_WIDTH - 1 downto 0);
		remainder : out std_logic_vector (DIVISOR_WIDTH - 1 downto 0);
		overflow : out std_logic
		-- for debugging
		-- a_out : out std_logic_vector(DIVIDEND_WIDTH - 1 downto 0);
		-- b_out : out std_logic_vector(DIVISOR_WIDTH - 1 downto 0);
		-- q_out : out std_logic_vector(DIVIDEND_WIDTH - 1 downto 0);
		-- state_out : out state
    );
end entity divider;

architecture fsm_behavior of divider is

	-- type state is (idle, init, b_eq_1, l00p, epilogue);
	signal next_state, curr_state : state;
	signal a, a_next, q, q_next : std_logic_vector (DIVIDEND_WIDTH - 1 downto 0);
	signal b, b_next : std_logic_vector (DIVISOR_WIDTH - 1 downto 0);

begin
	-- debugging
	-- a_out <= a;
	-- b_out <= b;
	-- q_out <= q;
	-- state_out <= curr_state;
	--
	StateRegisters : process (clk, reset) is
	begin
		if (reset = '1') then
			curr_state <= idle;
			a <= std_logic_vector(abs(signed(dividend)));
			b <= std_logic_vector(abs(signed(divisor)));
			q <= std_logic_vector(to_unsigned(0, DIVIDEND_WIDTH));
		elsif (rising_edge(clk)) then
			curr_state <= next_state;
			a <= a_next;
			b <= b_next;
			q <= q_next;
		end if;
	end process StateRegisters;

	DivMagoo : process (a, b, q, start, curr_state) is
		variable p : integer;			
		variable internal_sign : std_logic;
		variable one : std_logic_vector(DIVIDEND_WIDTH-1 downto 0) := (0 => '1', others => '0');
		variable q_plus_one, a_minus_b : integer;
		variable minus_q, remainder_condition : integer;
	begin
		next_state <= curr_state;
		a_next <= a;
		b_next <= b;
		q_next <= q;
		case (curr_state) is

			when idle =>

				if (start = '1') then
					next_state <= init;
				else
					next_state <= idle;
				end if;
				
			when init => 

				overflow <= '0';
				a_next <= std_logic_vector(abs(signed(dividend)));
				b_next <= std_logic_vector(abs(signed(divisor)));
				q_next <= std_logic_vector(to_unsigned(0, DIVIDEND_WIDTH));	
				p := 0;
				-- next_state <= b_eq_1 when (to_integer(signed(b)) = 1) else l00p;
				if (to_integer(signed(divisor)) = 1) then
					next_state <= b_eq_1;
				elsif (to_integer(signed(divisor)) = 0) then
					overflow <= '1';
					next_state <= b_eq_1;
				else
					next_state <= l00p;
				end if;

			when b_eq_1 =>

				q_next <= dividend;
				a_next <= std_logic_vector(to_signed(0, DIVIDEND_WIDTH));
				next_state <= epilogue;

			when l00p =>

				p := get_msb_pos(a) - get_msb_pos(b);
				if ((shift_left(resize(signed(b), DIVIDEND_WIDTH), p)) > signed(a)) then
					p := p - 1;
				end if;
				-- update q_next
				q_plus_one := to_integer(signed(q)) + to_integer(shift_left(signed(one), p));
				q_next <= std_logic_vector(to_signed(q_plus_one, DIVIDEND_WIDTH));

				if ((signed(b) /= 0) and (signed(b) <= signed(a))) then
					-- want to come back and check the if statement again
					-- update a_next
					a_minus_b := to_integer(signed(a)) - to_integer(shift_left(resize(signed(b), DIVIDEND_WIDTH), p));
					a_next <= std_logic_vector(to_signed(a_minus_b, DIVIDEND_WIDTH));
					next_state <= l00p;
				else
					next_state <= epilogue;
				end	if;

				
			when epilogue =>

				internal_sign := std_logic(dividend(DIVIDEND_WIDTH - 1) xor divisor(DIVISOR_WIDTH - 1));
				minus_q := to_integer(-signed(q));
				if (internal_sign /= '1') then
					quotient <= q;
				else
					quotient <= std_logic_vector(to_signed(minus_q, DIVIDEND_WIDTH));
				end if;

				remainder_condition := to_integer(shift_right(signed(dividend), DIVIDEND_WIDTH - 1));
				if (remainder_condition /= 1) then
					remainder <= std_logic_vector(to_signed((to_integer(signed(a(DIVISOR_WIDTH - 1 downto 0)))), DIVISOR_WIDTH));
				else
					remainder <= std_logic_vector(to_signed((to_integer(-signed(a(DIVISOR_WIDTH - 1 downto 0)))), DIVISOR_WIDTH));
				end if;

				next_state <= idle;
			
			when others =>
				next_state <= idle;
				a_next <= a;
				b_next <= b;
				q_next <= q;

		end case;
	end process DivMagoo;

end architecture fsm_behavior;