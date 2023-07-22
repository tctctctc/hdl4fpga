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
use hdl4fpga.base.all;
use hdl4fpga.usbpkg.all;

entity usbdevflow is
	port (
		tp        : out std_logic_vector(1 to 32) := (others => '0');
		clk       : in  std_logic;
		cken      : in  std_logic;

		rx_req    : in  std_logic;
		rx_rdy    : buffer std_logic;
		rxpid     : in  std_logic_vector(4-1 downto 0);
		rxtoken   : in  std_logic_vector;
		rxrqst    : in  std_logic_vector;
		rxdv      : in  std_logic;
		rxbs      : in  std_logic;
		rxd       : in  std_logic;

		tx_req    : buffer std_logic;
		tx_rdy    : in  std_logic;
		txpid     : out std_logic_vector(4-1 downto 0);
		txen      : buffer std_logic;
		txbs      : in  std_logic;
		txd       : buffer std_logic;

		setup_req : buffer bit;
		setup_rdy : in  bit;
	    rqst_req  : in  bit;
	    rqst_rdy  : in  bit;
		rqst_rxdv : out  std_logic;
		rqst_rxbs : out std_logic;
		rqst_rxd  : out  std_logic;
		rqst_txen : in  std_logic;
		rqst_txbs : out std_logic;
		rqst_txd  : in  std_logic);
end;

architecture def of usbdevflow is

	signal addr    : std_logic_vector( 7-1 downto 0);
	signal endp    : std_logic_vector( 4-1 downto 0);
	signal requesttype : std_logic_vector( 8-1 downto 0);
	signal value   : std_logic_vector(16-1 downto 0);
	signal index   : std_logic_vector(16-1 downto 0);
	signal length  : std_logic_vector(16-1 downto 0);

	signal in_req  : bit;
	signal in_rdy  : bit;
	signal out_req : bit;
	signal out_rdy : bit;
	signal ack_rdy : bit;
	signal ack_req : bit;

	signal ddata   : std_logic_vector(data0'range);

begin

	hosttodev_p : process (cken, clk)
		constant tbit : std_logic_vector(data0'range) := b"1000";
		variable shr : unsigned(0 to rxrqst'length);
	begin
		if rising_edge(clk) then
			if cken='1' then
				if (to_bit(rx_rdy) xor to_bit(rx_req))='1' then
					case rxpid is
					when tk_setup =>
						if (setup_req xor setup_rdy)='0' then
							ddata  <= data0;
							setup_req <= not setup_rdy;
						end if;
					when tk_in =>
						if (out_req xor out_rdy)='0' then
							out_req <= not out_rdy;
						end if;
					when tk_out=>
						if (in_req xor in_rdy)='0' then
							in_req <= not in_rdy;
						end if;
					when data0|data1 =>
						ddata  <= ddata xor tbit;
						ack_req <= not ack_rdy; 
					when hs_ack =>
						ddata  <= ddata xor tbit;
					when others =>
					end case;
				end if;
				rx_rdy <= to_stdulogic(to_bit(rx_req));
			end if;
		end if;
	end process;

	devtohost_p : process (clk)
	begin
		if rising_edge(clk) then
			if cken='1' then
				if (to_bit(tx_rdy) xor to_bit(tx_req))='0' then
					if (out_rdy xor out_req)='1' then
						txpid   <= ddata;
						tx_req  <= not to_stdulogic(to_bit(tx_rdy));
						out_rdy <= out_req;
					end if;
					if (ack_rdy xor ack_req)='1' then
						txpid   <= hs_ack;
						txen    <= '0';
						tx_req  <= not to_stdulogic(to_bit(tx_rdy));
						ack_rdy <= ack_req;
					end if;
				end if;
			end if;
		end if;
	end process;

	(txen, rqst_txbs, txd) <=
		std_logic_vector'(rqst_txen, txbs, rqst_txd)  when (rqst_rdy xor rqst_req)='1' else
		std_logic_vector'('0', '-', '-');
	(rqst_rxdv, rqst_rxbs, rqst_rxd) <= std_logic_vector'(rxdv, rxbs, rxd);

	tp(1) <= to_stdulogic(in_req);
	tp(2) <= to_stdulogic(in_rdy);
	tp(3) <= to_stdulogic(out_req);
	tp(4) <= to_stdulogic(out_rdy);
	tp(5) <= txen or (rxdv and to_stdulogic(in_rdy xor in_req));
	tp(6) <= txbs when txen='1' else rxbs;
	tp(7) <= txd  when txen='1' else rxd;
end;