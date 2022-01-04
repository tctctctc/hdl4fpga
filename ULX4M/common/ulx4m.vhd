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

library ecp5u;
use ecp5u.components.all;

entity ulx4m is
	generic (
		debug : boolean := false);
	port (
		clk_25mhz      : in    std_logic := 'Z';
		btn            : in  std_logic_vector(0 to 2-1) := (others => 'Z');
		led            : out std_logic_vector(4-1 downto 0);

		ftdi_rxd       : out   std_logic;
		ftdi_txd       : in    std_logic := 'Z';
		ftdi_nrts      : inout std_logic := 'Z';
		ftdi_ndtr      : inout std_logic := 'Z';
		ftdi_txden     : inout std_logic := 'Z';


		oled_clk       : out   std_logic;
		oled_mosi      : out   std_logic;
		oled_dc        : out   std_logic;
		oled_resn      : out   std_logic;
		oled_csn       : out   std_logic;

--		flash_csn      : out   std_logic;
--		flash_clk      : out   std_logic;
--		flash_mosi     : out   std_logic;
--		flash_miso     : in    std_logic;
--		flash_holdn    : out   std_logic;
--		flash_wpn      : out   std_logic;

		sd_clk         : in    std_logic := '-';
		sd_cmd         : out   std_logic; -- sd_cmd=MOSI (out)
		sd_d           : inout std_logic_vector(4-1 downto 0) := (others => 'U'); -- sd_d(0)=MISO (in), sd_d(3)=CSn (out)
		sd_wp          : in    std_logic := '-';
		sd_cdn         : in    std_logic := '-'; -- card detect not connected

		usb_fpga_dp    : inout std_logic := 'Z';
		usb_fpga_dn    : inout std_logic := 'Z';
		usb_fpga_bd_dp : inout std_logic := 'Z';
		usb_fpga_bd_dn : inout std_logic := 'Z';
		usb_fpga_pu_dp : inout std_logic := 'Z';
		usb_fpga_pu_dn : inout std_logic := 'Z';
		usb_fpga_otg_dp : inout std_logic := 'Z';
		usb_fpga_otg_dn : inout std_logic := 'Z';
		n_extrst       : inout std_logic := 'Z';

		sdram_clk      : inout std_logic;
		sdram_cke      : out   std_logic;
		sdram_csn      : out   std_logic;
		sdram_wen      : out   std_logic;
		sdram_rasn     : out   std_logic;
		sdram_casn     : out   std_logic;
		sdram_a        : out   std_logic_vector(13-1 downto 0);
		sdram_ba       : out   std_logic_vector(2-1 downto 0);
		sdram_dqm      : inout std_logic_vector(2-1 downto 0) := (others => 'Z');
		sdram_d        : inout std_logic_vector(16-1 downto 0) := (others => 'Z');

		gpdi_cec       : inout std_logic := 'Z';
--		gpdi_sda       : inout std_logic := 'Z';
--		gpdi_scl       : inout std_logic := 'Z';

		gpdi_dp        : out   std_logic_vector(8-1 downto 0);
		gpdi_dn        : out   std_logic_vector(8-1 downto 0);


		--gpdi_ethp      : out   std_logic;
		--gpdi_ethn      : out   std_logic;

		user_programn  : out   std_logic := '1'; -- '0' loads next bitstream from SPI FLASH (e.g. bootloader)
		shutdown       : out   std_logic := '0' -- '1' power off the board, 10uA sleep
	);
end;
