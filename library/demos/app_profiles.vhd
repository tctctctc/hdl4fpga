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

package app_profiles is

	type video_modes is (
		modedebug,
		mode480p16bpp,
		mode480p24bpp,
		mode600p16bpp,
		mode600p24bpp,
		mode720p16bpp,
		mode720p24bpp,
		mode768p24bpp,
		mode900p24bpp,
		mode1080r24bpp,
		mode1080i16bpp,
		mode1080i24bpp,
		mode1080p24bpp);

	type pixel_types is (
		rgb565,
		rgb888);

	type sdram_speeds is (
		sdram133MHz,
		sdram145MHz,
		sdram150MHz,
		sdram166MHz,
		sdram200MHz,
		sdram225MHz,
		sdram233MHz,
		sdram250MHz,
		sdram262MHz,
		sdram275MHz,
		sdram300MHz,
		sdram333MHz,
		sdram350MHz,
		sdram375MHz,
		sdram400MHz,
		sdram425MHz,
		sdram450MHz,
		sdram475MHz,
		sdram500MHz,
		sdram525MHz,
		sdram550MHz,
		sdram575MHz,
		sdram600MHz);

	type io_comms is (
		io_hdlc,
		io_ipoe);

end package;

package body app_profiles is

end package body;