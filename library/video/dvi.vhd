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

entity dvi_subpxl is
	port (
		clk   : in  std_logic;
		hsync : in  std_logic;
		vsync : in  std_logic;
		blank : in  std_logic;
		red   : in  std_logic_vector( 8-1 downto 0);
		green : in  std_logic_vector( 8-1 downto 0);
		blue  : in  std_logic_vector( 8-1 downto 0);
		chn0  : out std_logic_vector(10-1 downto 0);
		chn1  : out std_logic_vector(10-1 downto 0);
		chn2  : out std_logic_vector(10-1 downto 0));
end;

architecture def of dvi_subpxl is
	constant c00  : std_logic_vector := "1101010100";
	constant c01  : std_logic_vector := "0010101011";
	constant c10  : std_logic_vector := "0101010100";
	constant c11  : std_logic_vector := "1010101011";

	signal chnpxl : std_logic_vector(3*chn0'length-1 downto 0);
	signal chn0_c : std_logic_vector(chn0'range);
	signal c      : std_logic_vector(3*chn0'length-1 downto 0);
	signal pixel  : std_logic_vector(3*blue'length-1 downto 0);
begin
	pixel <= red & green & blue;
	with std_logic_vector'(vsync, hsync) select
	chn0_c <= 
		c00 when "00",
		c01 when "01",
		c10 when "10",
		c11 when others;
	c <= c00 & c00 & chn0_c;
	chn0to2_g : for i in 0 to 3-1 generate
		tmds_encoder_e : entity hdl4fpga.tmds_encoder1
		port map (
			clk     => clk,
			c       => c(c00'length*(i+1)-1 downto c00'length*i),
			de      => blank,
			data    => pixel(  blue'length*(i+1)-1 downto  blue'length*i),
			encoded => chnpxl(chn0'length*(i+1)-1 downto chn0'length*i));
	end generate;
	chn0 <= chnpxl(chn0'length*1-1 downto chn0'length*0);
	chn1 <= chnpxl(chn0'length*2-1 downto chn0'length*1);
	chn2 <= chnpxl(chn0'length*3-1 downto chn0'length*2);
end;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library hdl4fpga;

entity dvi is
	generic (
		ser_size     : natural := 10);
	port (
		clk   : in  std_logic;
		red   : in  std_logic_vector( 8-1 downto 0);
		green : in  std_logic_vector( 8-1 downto 0);
		blue  : in  std_logic_vector( 8-1 downto 0);
		hsync : in  std_logic;
		vsync : in  std_logic;
		blank : in  std_logic;
		chn0  : out std_logic_vector(ser_size-1 downto 0);
		chn1  : out std_logic_vector(ser_size-1 downto 0);
		chn2  : out std_logic_vector(ser_size-1 downto 0);
		chnc  : out std_logic_vector(ser_size-1 downto 0));
end;

architecture def of dvi is
	signal cpixel : std_logic_vector(4*10-1 downto 0);
	signal spixel : std_logic_vector(4*ser_size-1  downto 0);

	alias cred   is cpixel(2*10-1 downto 1*10);
	alias cgreen is cpixel(3*10-1 downto 2*10);
	alias cblue  is cpixel(1*10-1 downto 0*10);

	alias sred   is spixel(2*ser_size-1 downto 1*ser_size);
	alias sgreen is spixel(3*ser_size-1 downto 2*ser_size);
	alias sblue  is spixel(1*ser_size-1 downto 0*ser_size);
begin

	dvisubpxl_e : entity hdl4fpga.dvi_subpxl
	port map (
		clk   => clk,
		hsync => hsync,
		vsync => vsync,
		blank => blank,
		red   => red,
		green => green,
		blue  => blue,
		chn0  => cblue,
		chn1  => cgreen,
		chn2  => cred);

	serlzr_g : for i in 0 to 3-1 generate
		serlzr_e : entity hdl4fpga.serlzr
		port map (
			clk    => clk,
			frm    => '0',
			data_i => cpixel(10*(i+1) downto 10*i),
			data_o => spixel(ser_size*(i+1)  downto ser_size*i));
	end generate;

	chn0 <= sblue;
	chn1 <= sgreen;
	chn2 <= sred;

end;