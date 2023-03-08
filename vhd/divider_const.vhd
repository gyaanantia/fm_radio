library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--Additional standard or custom libraries go here

package divider_const is

  constant DIVIDEND_WIDTH : natural := 8;
  constant DIVISOR_WIDTH : natural := 4;
  --Other constants, types, subroutines, components go here
  function get_msb_pos ( vec: std_logic_vector) return integer;
  type state is (idle, init, b_eq_1, l00p, epilogue);

end package divider_const;

package body divider_const is
  --Subroutine declarations go here
  -- you will not have any need for it now, this package is only for defining -
  -- some useful constants
	-- function get_msb_pos (vec: std_logic_vector) return integer is begin
	-- 		for i in vec'LENGTH-1 downto 0 loop
	-- 			if (vec(i) = '1') then return i;
	-- 			end if;
	-- 		end loop;
	-- 		return 0;
	-- end get_msb_pos;

  function get_msb_pos (vec : std_logic_vector) return integer is
      variable lhs, rhs, msb : integer; 
  begin
      if (vec'LENGTH > 1) then

        lhs := to_integer(unsigned(vec(vec'LENGTH -1 downto (vec'LENGTH / 2))));
        rhs := to_integer(unsigned(vec((vec'LENGTH / 2) - 1 downto 0)));

        if (lhs > 0) then
          msb := get_msb_pos(std_logic_vector(to_unsigned(lhs, (vec'LENGTH / 2)))) + (vec'LENGTH / 2);
          return msb;
        elsif (rhs > 0) then
          msb := get_msb_pos(std_logic_vector(to_unsigned(rhs, (vec'LENGTH / 2))));
          return msb; 
        else
          return 0;
        end if;

      else
        if(unsigned(vec) = 1) then
          return 1;
        else
          return 0;
        end if;
      end if;

  end get_msb_pos;

end package body divider_const;