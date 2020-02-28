--                                                                            --
-- Author(s):                                                                 --
--   Miguel Angel Sagreras                                                    --
--                                                                            --
-- Copyright (C) 2015                                                         --
--    Miguel Angel Sagreras                                                   --
--                                                                            --
-- This source file may be used and distributed without restriction provided  --
-- that this copyright statement is not removed from the file and that any    --
-- derivative work contains  the original copyright notice and the associated --
-- disclaimer.                                                                --
--                                                                            --
-- This source file is free software; you can redistribute it and/or modify   --
-- it under the terms of the GNU General Public License as published by the   --
-- Free Software Foundation, either version 3 of the License, or (at your     --
-- option) any later version.                                                 --
--                                                                            --
-- This source is distributed in the hope that it will be useful, but WITHOUT --
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or      --
-- FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for   --
-- more details at http://www.gnu.org/licenses/.                              --
--                                                                            --

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library hdl4fpga;
use hdl4fpga.std.all;

entity dmacntr is
	generic (
		slices  : natural_vector);
	port (
		clk  : in  std_logic;
		load : in  std_logic := '0';
		ena  : in  std_logic := '1';
		updn : in  std_logic := '0';
		d    : in  std_logic_vector;
		q    : out std_logic_vector;
		eoc  : out std_logic_vector);
end;

architecture def of dmacntr is

begin

	cntr_p : process (clk)

		variable auxd  : unsigned(0 to d'length-1);
		variable auxq  : unsigned(0 to q'length-1);
		variable cntr  : unsigned(0 to q'length+slices'length-1);
		variable cntr1 : unsigned(0 to q'length+slices'length-1);
		variable cy    : std_logic;

	begin
		if rising_edge(clk) then
			for i in slices'range loop
				auxd  := auxd  ror (slices(i)+0);
				auxq  := auxq  ror (slices(i)+0);
				cntr  := cntr  ror (slices(i)+1);
				cntr1 := cntr1 ror (slices(i)+1);
				if load='1' then
					cntr(0 to slices(i)) := '0' & unsigned(auxd(0 to slices(i)-1));
					auxq(0 to slices(i)-1) := cntr(1 to slices(i));

					if updn='0' then
						cntr1(0 to slices(i)) := cntr(0 to slices(i)) + 1;
					else
						cntr1(0 to slices(i)) := cntr(0 to slices(i)) - 1;
					end if;
					eoc(i) <= '0';

				elsif ena='1' then
					if updn='0' then
						cntr1(0 to slices(i)) := cntr(0 to slices(i)) + 1;
					else
						cntr1(0 to slices(i)) := cntr(0 to slices(i)) - 1;
					end if;

					if cy='1' then
						cntr(0 to slices(i)) := '0' & cntr1(1 to slices(i));
						eoc(i) <= cntr1(0);
						cy     := cntr1(0);
					end if;
				end if;
			end loop;
			q <= std_logic_vector(auxq);
		end if;
	end process;

end;
