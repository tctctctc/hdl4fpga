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
use hdl4fpga.profiles.all;

library unisim;
use unisim.vcomponents.all;

entity xc_sdrdqphy is
	generic (
		dqs_delay   : time := 0.2777778 ns; --0.5*(1000 ns /450.0)*(1.0/4.0);
		dqi_delay   : time := 0.2777778 ns; --0.5*(1000 ns /450.0)*(1.0/4.0);

		device      : fpga_devices;
		byte_size   : natural;
		data_gear   : natural;

		loopback    : boolean := false;
		bypass      : boolean := false;
		rd_fifo     : boolean := true;
		rd_align    : boolean := true;
		wr_register : boolean := false;
		wr_fifo     : boolean := true;

		taps        : natural);
	port (
		tp_sel      : in  std_logic_vector(2-1 downto 0) := "00";
		tp_delay    : out std_logic_vector(1 to 8);

		rst         : in  std_logic;
		rst_shift   : in  std_logic;
		iod_clk     : in  std_logic;
		clk         : in  std_logic := '-';
		clk_shift   : in  std_logic := '-';
		clkx2       : in  std_logic := '-';
		clkx2_shift : in  std_logic := '-';

		sys_wlreq   : in  std_logic := '-';
		sys_wlrdy   : out std_logic;

		sys_rlreq   : in  std_logic;
		sys_rlrdy   : buffer std_logic;
		read_rdy    : in  std_logic;
		read_req    : buffer std_logic;
		read_brst   : out std_logic;
		write_rdy   : in  std_logic;
		write_req   : buffer std_logic;
		sto_synced  : buffer std_logic;

		sys_dmt     : in  std_logic_vector(data_gear-1 downto 0) := (others => '-');
		sys_sti     : in  std_logic_vector(data_gear-1 downto 0) := (others => '-');
		sys_sto     : buffer std_logic_vector(data_gear-1 downto 0);
		sys_dmi     : in  std_logic_vector(data_gear-1 downto 0) := (others => '-');
		sys_dqi     : in  std_logic_vector(data_gear*byte_size-1 downto 0);
		sys_dqt     : in  std_logic_vector(data_gear-1 downto 0);
		sys_dqo     : out std_logic_vector(data_gear*byte_size-1 downto 0);
		sys_dqsi    : in  std_logic_vector(data_gear-1 downto 0);
		sys_dqso    : out std_logic_vector(data_gear-1 downto 0);
		sys_dqst    : in  std_logic_vector(data_gear-1 downto 0);
		sys_dqc     : buffer std_logic_vector(data_gear-1 downto 0);
		sys_dqv     : in  std_logic_vector(data_gear-1 downto 0) := (others => '0');

		sdram_dmi   : in  std_logic := '-';
		sdram_sti   : in  std_logic := '-';
		sdram_sto   : out std_logic;
		sdram_dmt   : out std_logic;
		sdram_dmo   : out std_logic;
		sdram_dqsi  : in  std_logic;
		sdram_dqi   : in  std_logic_vector(byte_size-1 downto 0);
		sdram_dqt   : out std_logic_vector(byte_size-1 downto 0);
		sdram_dqo   : out std_logic_vector(byte_size-1 downto 0);

		sdram_dqst  : out std_logic;
		sdram_dqso  : out std_logic);
end;

architecture xilinx of xc_sdrdqphy is

	signal adjdqs_req   : std_logic;
	signal adjdqs_rdy   : std_logic;
	signal adjdqi_req   : std_logic_vector(sdram_dqi'range);
	signal adjdqi_rdy   : std_logic_vector(sdram_dqi'range);
	signal adjsto_req   : std_logic;
	signal adjsto_rdy   : std_logic;

	signal dqspau_req   : std_logic;
	signal dqspau_rdy   : std_logic;
	signal dqs180       : std_logic;
	signal dqspre       : std_logic;
	signal dqssto       : std_logic;

	signal dq           : std_logic_vector(sys_dqo'range);
	signal dqi          : std_logic_vector(sdram_dqi'range);

	signal dqipause_req : std_logic;
	signal dqipause_rdy : std_logic;
	signal dqipau_req   : std_logic_vector(sdram_dqi'range);
	signal dqipau_rdy   : std_logic_vector(sdram_dqi'range);

	signal pause_req    : std_logic;
	signal pause_rdy    : std_logic;

	signal dqsi_delay   : std_logic_vector(0 to setif(device=xc7a,5,6)-1);
	signal tp_dqsdly    : std_logic_vector(6-1 downto 0) := (others => '0');
	signal tp_dqidly    : std_logic_vector(6-1 downto 0);
	signal tp_dqssel    : std_logic_vector(3-1 downto 0);

	signal step_req     : std_logic;
	signal step_rdy     : std_logic;

	signal data_align   : std_logic_vector(sys_sti'range);
	signal half_align   : std_logic;

	signal sdqe         : std_logic_vector(sys_dqv'range);
	signal ssti         : std_logic_vector(sys_sti'range);
	signal ten          : std_logic_vector(sys_dqv'range);
	signal rdv          : std_logic_vector(sys_sto'range);
	signal sdqt         : std_logic_vector(sys_sti'range);
	signal sdqsi        : std_logic_vector(sys_dqsi'range);
	signal sdqso        : std_logic_vector(sys_dqso'range);

begin

	with tp_sel select
	tp_delay <= 
		tp_dqssel(1-1 downto 0) & dqspre & tp_dqsdly(6-1 downto 0)       when "00",
		tp_dqssel(1-1 downto 0) & dqspre & tp_dqidly(6-1 downto 0)       when "01",
		'0'                     & dqspre & '0' & half_align & data_align when others;

	sys_wlrdy <= to_stdulogic(to_bit(sys_wlreq));
	rl_b : block
	begin

		process (pause_rdy, pause_req, iod_clk)
			type states is (s_init, s_write, s_dqs, s_w4dqi, s_dqi4rdy, s_sto);
			variable state : states;
			variable sy_write_rdy : std_logic;
			variable sy_read_rdy  : std_logic;
		begin
			if rising_edge(iod_clk) then
				if rst='1' then
					sys_rlrdy <= to_stdulogic(to_bit(sys_rlreq));
					adjdqs_req <= to_stdulogic(to_bit(adjdqs_rdy));
					adjdqi_req <= to_stdlogicvector(to_bitvector(adjdqi_rdy));
					adjsto_req <= to_stdulogic(to_bit(adjsto_rdy));
					state      := s_init;
				elsif (sys_rlrdy xor to_stdulogic(to_bit(sys_rlreq)))='0' then
					adjdqs_req <= to_stdulogic(to_bit(adjdqs_rdy));
					adjdqi_req <= to_stdlogicvector(to_bitvector(adjdqi_rdy));
					adjsto_req <= to_stdulogic(to_bit(adjsto_rdy));
					state      := s_init;
				else
					case state is
					when s_init =>
						write_req <= not to_stdulogic(to_bit(sy_write_rdy));
						read_brst <= '0';
						state     := s_write;
					when s_write =>
						if (sy_write_rdy xor to_stdulogic(to_bit(write_req)))='0' then
							read_req <= not to_stdulogic(to_bit(sy_read_rdy));
							read_brst <= '1';
							if sys_sti(0)='1' then
								adjdqs_req <= not to_stdulogic(to_bit(adjdqs_rdy));
								state      := s_dqs;
							end if;
						end if;
					when s_dqs =>
						if (adjdqs_rdy xor to_stdulogic(to_bit(adjdqs_req)))='0' then
							adjdqi_req <= not adjdqi_rdy;
							state      := s_w4dqi;
						end if;
					when s_w4dqi =>
						state := s_dqi4rdy;
						for i in adjdqi_rdy'range loop
							if (adjdqi_rdy(i) xor adjdqi_req(i))='1' then
								state := s_w4dqi;
							end if;
						end loop;
					when s_dqi4rdy =>
						read_brst <= '0';
						if (sy_read_rdy xor to_stdulogic(to_bit(read_req)))='0' then
							read_req   <= not sy_read_rdy;
							adjsto_req <= not adjsto_rdy;
							state      := s_sto;
						end if;
					when s_sto =>
						if (sy_read_rdy xor to_stdulogic(to_bit(read_req)))='0' then
							if (adjsto_rdy xor to_stdulogic(to_bit(adjsto_req)))='0' then
								sys_rlrdy <= to_stdulogic(to_bit(sys_rlreq));
							else
								read_req <= not sy_read_rdy;
							end if;
						end if;
						read_brst <= '0';
					end case;
				end if;
				sy_write_rdy := write_rdy;
				sy_read_rdy  := read_rdy;
			end if;
		end process;

		dqipause_p : process (iod_clk)
			type states is (s_init, s_wait, s_idle);
			variable state : states;
			variable sy_dqipau_req : std_logic_vector(dqipau_req'range);
		begin
			if rising_edge(iod_clk) then
				if rst='1' then
					dqipau_rdy <= to_stdlogicvector(to_bitvector(dqipau_req));
					state := s_idle;
				else
					case state is
					when s_init =>
						dqipause_req <= not dqipause_rdy;
						state := s_wait;
					when s_wait =>
						if (dqipause_rdy xor to_stdulogic(to_bit(dqipause_req)))='0' then
							dqipau_rdy <= to_stdlogicvector(to_bitvector(sy_dqipau_req));
							state := s_idle;
						end if;
					when s_idle =>
						state := s_init;
						for i in dqipau_req'range loop
							if (dqipau_rdy(i) xor to_stdulogic(to_bit(sy_dqipau_req(i))))='0' then
								state := s_idle;
							end if;
						end loop;
					end case;
				end if;
				sy_dqipau_req := dqipau_req;
			end if;
		end process;

	end block;

	process (iod_clk, pause_rdy)
		type states is (s_init, s_wait, s_idle);
		variable state : states;
		variable cntr  : unsigned(0 to unsigned_num_bits(63));
		variable sy_dqspau_req : std_logic;
	begin
		if rising_edge(iod_clk) then
			if rst='1' then
				dqipause_rdy <= to_stdulogic(to_bit(dqipause_req));
				dqspau_rdy   <= to_stdulogic(to_bit(dqspau_req));
				state := s_idle;
			else
				case state is
				when s_init =>
					if (pause_rdy xor to_stdulogic(to_bit(pause_req)))='0' then
						pause_req <= not pause_rdy;
						state := s_wait;
					end if;
				when s_wait =>
					if (pause_rdy xor to_stdulogic(to_bit(pause_req)))='0' then
						dqipause_rdy <= to_stdulogic(to_bit(dqipause_req));
						dqspau_rdy   <= to_stdulogic(to_bit(sy_dqspau_req));
						state        := s_idle;
					end if;
				when s_idle =>
					if (dqipause_rdy xor to_stdulogic(to_bit(dqipause_req)))='1' then
						state := s_init;
					elsif (dqspau_rdy xor to_stdulogic(to_bit(sy_dqspau_req)))='1' then
						state := s_init;
					end if;
				end case;
			end if;
			sy_dqspau_req := dqspau_req;
		end if;
	end process;

	process (iod_clk, pause_req)
		variable cntr : unsigned(0 to unsigned_num_bits(64-1));
	begin
		if rising_edge(iod_clk) then
			if rst='1' then
				pause_rdy <= to_stdulogic(to_bit(pause_req));
				cntr := (others => '0');
			elsif (pause_rdy xor to_stdulogic(to_bit(pause_req)))='1' then
				if cntr(0)='0' then
					cntr := cntr + 1;
				else
					pause_rdy <= to_stdulogic(to_bit(pause_req));
					cntr := (others => '0');
				end if;
			else
				cntr := (others => '0');
			end if;
		end if;
	end process;

	dqsi_b : block
		signal dqsi       : std_logic;
		signal dqsi_buf   : std_logic;
		signal dqs_smp    : std_logic_vector(0 to data_gear-1);
	begin

		adjdqs_e : entity hdl4fpga.adjpha
		generic map (
			taps     => taps)
		port map (
			rst      => rst,
			edge     => std_logic'('1'),
			clk      => clk,
			req      => adjdqs_req,
			rdy      => adjdqs_rdy,
			step_req => dqspau_req,
			step_rdy => dqspau_rdy,
			smp      => dqs_smp,
			ph180    => dqs180,
			delay    => dqsi_delay);

		dqsi <= transport sdram_dqsi after dqs_delay;
		dqsidelay_i : entity hdl4fpga.xc_dqsdelay 
		generic map (
			device => device,
			data_gear => data_gear)
		port map (
			rst    => rst,
			clk    => clk,
			delay  => dqsi_delay,
			dqsi   => dqsi,
			dqso   => sdqso);
		dqsi_buf <= sdqso(0);

		igbx_i : entity hdl4fpga.igbx
		generic map (
			device => device,
			size   => 1,
			gear   => data_gear)
		port map (
			rst   => rst,
			sclk  => clkx2,
			clkx2 => clkx2,
			clk   => clk,  
			d(0)  => dqsi_buf,
			q     => dqs_smp);

		tp_dqsdly <= std_logic_vector(resize(unsigned(dqsi_delay), tp_dqsdly'length));

		adjsto_e : entity hdl4fpga.adjsto
		generic map (
			gear      => data_gear)
		port map (
			tp        => tp_dqssel,
			rst       => rst,
			sdram_clk => clk,
			edge      => std_logic'('0'),
			sdram_sti => sys_sti(0),
			sdram_sto => dqssto,
			dqs_smp   => dqs_smp,
			dqs_pre   => dqspre,
			step_req  => step_req,
			step_rdy  => step_rdy,
			sys_req   => adjsto_req,
			sys_rdy   => adjsto_rdy,
			synced    => sto_synced);

	end block;

	datai_b : block
		signal sdqo : std_logic_vector(sys_dqo'range);
	begin

		i_igbx : for i in sdram_dqi'range generate
		begin
			adjdqi_b : block
				signal delay  : std_logic_vector(0 to setif(device=xc7a,5,6)-1);
				signal dq_smp : std_logic_vector(data_gear-1 downto 0);
				signal ddqi   : std_logic;
			begin
	
				dqismp_p : process (dq, clk_shift)
					variable q : std_logic_vector(dq_smp'range);
				begin
					if rising_edge(clk_shift) then
						for j in dq_smp'range loop
							q(j) := dq(j*byte_size+i);
						end loop;
					dq_smp <= q;
					end if;
				end process;
	
				adjdqi_e : entity hdl4fpga.adjpha
				generic map (
					taps     => taps)
				port map (
					rst      => rst_shift,
					edge     => std_logic'('1'),
					clk      => clk_shift,
					req      => adjdqi_req(i),
					rdy      => adjdqi_rdy(i),
					step_req => dqipau_req(i),
					step_rdy => dqipau_rdy(i),
					smp      => dq_smp,
					delay    => delay);
	
				tp_g : if i=0 generate
					tp_dqidly <= std_logic_vector(resize(unsigned(delay), tp_dqidly'length));
				end generate;
	
				ddqi <= transport sdram_dqi(i) after dqi_delay;
				dqi_i : entity hdl4fpga.xc_idelay
				generic map (
					device => device,
					signal_pattern => "DATA")
				port map(
					rst     => rst_shift,
					clk     => clk_shift,
					delay   => delay,
					idatain => ddqi,
					dataout => dqi(i));
			end block;
	
			bypass_g : if bypass generate
				phases_g : for j in 0 to data_gear-1 generate
					sdqo(j*byte_size+i) <= sdram_dqi(i);
				end generate;
			end generate;
	
			igbx_g : if not bypass generate
				gbx2_g : if data_gear=2 generate
					igbx_i : entity hdl4fpga.igbx
					generic map (
						device => device,
						size   => 1,
						gear   => data_gear)
					port map (
						rst    => rst,
						clk    => clk,
						d(0)   => dqi(i),
						q(0)   => dq(0*byte_size+i),
						q(1)   => dq(1*byte_size+i));

					shuffle_g : for j in data_gear-1 downto 0 generate
						sdqo(j*byte_size+i) <= dq(j*byte_size+i);
					end generate;
				end generate;
	
				gbx4_g : if data_gear=4 generate
					signal q1 : std_logic_vector(data_gear-1 downto 0);
					signal q2 : std_logic_vector(data_gear-1 downto 0);
				begin

					igbx_i : entity hdl4fpga.igbx
					generic map (
						device => device,
						size => 1,
						gear => data_gear)
					port map (
						rst   => rst_shift,
						sclk  => clkx2,
						clkx2 => clkx2_shift,
						clk   => clk_shift,
						d(0)  => dqi(i),
						q     => q1);
			
					process (q1, data_align)
						variable data : unsigned(q1'range);
					begin
						data := unsigned(q1);
						for j in data_align'range loop
							if data_align(j)='0' then
								data := data rol 1;
							else
								exit;
							end if;
						end loop;
						q2 <= std_logic_vector(data);
					end process;

					shuffle_g : for j in 0 to data_gear-1 generate
						dq(j*byte_size+i)   <= q1(j);
						sdqo(j*byte_size+i) <= q2(j);
					end generate;

				end generate;
			end generate;
		end generate;
	
		rd_fifo_g : if rd_fifo generate
			gear_g : for i in data_gear-1 downto 0 generate
				signal out_frm : std_logic;
			begin
				out_frm <= sys_sto(sys_sto'right) when rd_align else sys_sto(i);
				fifo_i : entity hdl4fpga.iofifo
				port map (
					in_clk   => sdqso(i),
					in_frm   => rdv(i),
					in_data  => sdqo(byte_size*(i+1)-1 downto byte_size*i),
					out_clk  => clk,
					out_frm  => out_frm,
					out_data => sys_dqo(byte_size*(i+1)-1 downto byte_size*i));
				sys_dqso <= (others => clk);
			end generate;
		end generate;
		
		no_rdfifo_g : if not rd_fifo generate
			sys_dqo  <= sdqo;
			sys_dqso <= sdqso;
		end generate;

		sto_b : block
		begin
			igbx_g : if not bypass generate

				gbx2_g : if data_gear=2 generate
					lat_e : entity hdl4fpga.latency
					generic map (
						n => data_gear,
						d => (0 to data_gear-1 => 4))
					port map (
						clk => clk,
						di  => sys_sti,
						do  => sys_sto);

					rdv <= sys_sti;

				end generate;

				gbx4_g : if data_gear=4 generate
					igbx_i : entity hdl4fpga.igbx
					generic map (
						device => device,
						size => 1,
						gear => data_gear)
					port map (
						rst   => rst_shift,
						sclk  => clkx2,
						clkx2 => clkx2_shift,
						clk   => clk_shift,
						d(0)  => sdram_dmi);
			
					lat_e : entity hdl4fpga.latency
					generic map (
						n => data_gear,
						d => (0 to data_gear-1 => 1))
					port map (
						clk => clk_shift,
						di  => sys_sti,
						do  => rdv);

					process(rdv, clk_shift)
						variable lat : unsigned(0 to 2*rdv'length-1);
					begin
						if rising_edge(clk_shift) then
							lat := lat srl rdv'length;
							lat(0 to rdv'length-1) := unsigned(rdv);
							sys_sto <= multiplex(multiplex(std_logic_vector(lat & shift_left(lat, 2)), half_align), "0", 4);
						end if;
					end process;

					process (clk_shift)
						variable ena : std_logic;
					begin
						if rising_edge(clk_shift) then
							if sto_synced='0' then
								if sys_sti=(sys_sti'range => '0') then
									ena := '1';
								elsif ena='1' then
									ena:= '0';
									if sys_sti="1110" then
										half_align <= dqspre;
										data_align <= reverse(sys_sti) xor ('0', dqspre, dqspre, '0');
									elsif sys_sti="1000" then
										half_align <= not dqspre;
										data_align <= reverse(sys_sti) xor ('0', not dqspre, not dqspre, '0');
									else
										half_align <= '-';
										data_align <= (others => '-');
									end if;
								end if;
							end if;
						end if;
					end process;
				end generate;
			end generate;

			bypass_g : if bypass generate
				signal sto : std_logic_vector(sys_sto'range);
			begin

				lat_e : entity hdl4fpga.latency
				generic map (
					n => data_gear,
					d => (0 to data_gear-1 => 3))
				port map (
					clk => clk,
					di  => sys_sti,
					do  => sto);
				sys_sto <= (others => sto(sto'right)) when rd_fifo and rd_align else sto;
				
				phases_g : for i in data_gear-1 downto 0 generate
					rdv(i) <= sdram_sti when loopback else sdram_dmi;
				end generate;

			end generate;
		end block;
	
	end block;

	datao_b : block

		signal sdqi : std_logic_vector(sys_dqi'range);
		signal sdmi : std_logic_vector(sys_dmi'range);

	begin

		wrfifo_g : if wr_fifo generate
			gear_g : for i in data_gear-1 downto 0 generate
				signal in_data  : std_logic_vector(sys_dqi'length/data_gear downto 0);
				signal out_data : std_logic_vector(sys_dqi'length/data_gear downto 0);
			begin
				in_data <= sys_dmi(i) & sys_dqi(byte_size*(i+1)-1 downto byte_size*i);
				fifo_i : entity hdl4fpga.iofifo
				port map (
					in_clk   => clk,
					in_frm   => ten(i),
					in_data  => in_data,
					out_clk  => sys_dqc(i),
					out_frm  => sdqe(i),
					out_data => out_data);
				sdmi(i) <= out_data(out_data'left);
				sdqi(byte_size*(i+1)-1 downto byte_size*i) <= out_data(out_data'left-1 downto 0);
			end generate;
		end generate;
		
		no_wrfifo_g : if not wr_fifo generate
			sdqi <= sys_dqi;
			sdmi <= sys_dmi;
		end generate;

		oddr_g : for i in sdram_dqo'range generate

			signal dqo : std_logic_vector(data_gear-1 downto 0);
			signal dqt : std_logic_vector(sys_dqt'range);
			signal sw  : std_logic;
		begin

			process (iod_clk)
			begin
				if rising_edge(iod_clk) then
					sw <= sys_rlrdy xor to_stdulogic(to_bit(sys_rlreq));
				end if;
			end process;

			process (sw, sdqi, clk_shift)
			begin
				for j in dqo'range loop
					if sw='1' then
						if j mod 2=0 then
							dqo(j) <= '1';
						else
							dqo(j) <= '0';
						end if;
					elsif not wr_register then
						dqo(j) <= sdqi(byte_size*j+i);
					elsif rising_edge(clk_shift) then
						dqo(j) <= sdqi(byte_size*j+i);
					end if;
				end loop;
			end process;

			process (sdqt, clk_shift)
			begin
				if not wr_register then
					dqt <= sdqt;
				elsif rising_edge(clk_shift) then
					dqt <= sdqt;
				end if;
			end process;
	
			ogbx_i : entity hdl4fpga.ogbx
			generic map (
				device => device,
				size => 1,
				gear => data_gear)
			port map (
				rst   => rst_shift,
				clk   => clk_shift,
				clkx2 => clkx2_shift,
				t     => dqt,
				tq(0) => sdram_dqt(i),
				d     => dqo,
				q(0)  => sdram_dqo(i));
	
		end generate;
	
		dmo_g : block
			signal dmt : std_logic_vector(sys_dmt'range);
			signal dmd : std_logic_vector(sys_dmi'range);
			signal dmi : std_logic_vector(dmd'range);
		begin
	
			process (sys_sti, sys_dmt, sys_dmi)
			begin
				for i in dmi'range loop
					if not loopback then
						dmd(i) <= sys_sti(i);
					elsif sys_dmt(i)='1' then
						dmd(i) <= sdmi(i);
					else
						dmd(i) <= sdmi(i);
					end if;
				end loop;
			end process;

			process (dmd, clk_shift)
			begin
				if not wr_register then
					dmi <= dmd;
				elsif rising_edge(clk_shift) then
					dmi <= dmd;
				end if;
			end process;

			process (sys_dmt, clk_shift)
			begin
				if not wr_register then
					if loopback then
						dmt <= (others => '0');
					else
						dmt <= sys_dmt;
					end if;
				elsif rising_edge(clk_shift) then
					if loopback then
						dmt <= (others => '0');
					else
						dmt <= sys_dmt;
					end if;
				end if;
			end process;
	
			ogbx_i : entity hdl4fpga.ogbx
			generic map (
				device => device,
				size => 1,
				gear => data_gear)
			port map (
				rst   => rst_shift,
				clk   => clk_shift,
				clkx2 => clkx2_shift,
				t     => dmt,
				tq(0) => sdram_dmt,
				d     => dmi,
				q(0)  => sdram_dmo);
	
		end block;

		sto_g : block
			signal d : std_logic_vector(0 to data_gear-1);
		begin
	
   			d <= reverse(ssti) when data_gear=2 else reverse(sys_sti);

   			ogbx_i : entity hdl4fpga.ogbx
   			generic map (
   				device => device,
   				size => 1,
   				gear => data_gear)
   			port map (
   				rst   => rst_shift,
   				clk   => clk_shift,
				clkx2 => clkx2_shift,
   				d     => d,
   				q(0)  => sdram_sto);
	
		end block;

	end block;

	dqso_b : block
		signal dqsi : std_logic_vector(sys_dqsi'range);
		signal dqst : std_logic_vector(sys_dqst'range);
	begin

		process (sdqsi)
		begin
			dqsi <= sdqsi;
			for i in dqsi'range loop
				if i mod 2 = 1 then
					dqsi(i) <= '0';
				end if;
			end loop;
		end process;

		ogbx_i : entity hdl4fpga.ogbx
		generic map (
			device => device,
			size => 1,
			gear => data_gear)
		port map (
			rst   => rst,
			clk   => clk,
			clkx2 => clkx2,
			t     => sys_dqst,
			tq(0) => sdram_dqst,
			d     => dqsi,
			q(0)  => sdram_dqso);

	end block;

	gear2_g : if data_gear=2 generate
		signal clk270 : std_logic;
	begin
		
		sys_dqc(1) <= clk_shift;
		sys_dqc(0) <= not clk_shift;

		clk270 <= not clk_shift;
		phdata_e : entity hdl4fpga.phdata
		generic map (
			data_width0   => 1,
			data_width90  => 3,
			data_width180 => 1,
			data_width270 => 3)
		port map (
			clk0     => clk,
			clk270   => clk270,

			di0(0)   => sys_dqsi(1),

			di90(2)  => sys_dqt(1),
			di90(1)  => sys_sti(0),
			di90(0)  => sys_dqv(1),

			di180(0) => sys_dqsi(0),

			di270(2) => sys_dqt(0),
			di270(1) => sys_sti(1),
			di270(0) => sys_dqv(0),

			do0(0)   => sdqsi(1),

			do90(2)  => sdqt(1),
			do90(1)  => ssti(0),
			do90(0)  => sdqe(1),

			do180(0) => sdqsi(0),

			do270(2) => sdqt(0),
			do270(1) => ssti(1),
			do270(0) => sdqe(0));

			ten <= sys_dqv;
	end generate;

	gear4_g : if data_gear=4 generate
		sys_dqc <= (others => clk_shift);

		phdata_e : entity hdl4fpga.g4_phdata
		generic map (
			data_width270 => 12)
		port map (
			clk0     => clk,
			clk270   => clk_shift,

			di270(12-1 downto 8) => sys_dqt,
			di270( 8-1 downto 4) => sys_sti,
			di270( 4-1 downto 0) => sys_dqv,

			do270(12-1 downto 8) => sdqt,
			do270( 8-1 downto 4) => ssti,
			do270( 4-1 downto 0) => sdqe);

		ten <= (others => sys_dqv(sys_dqv'right));
		sdqsi <= sys_dqsi;
	end generate;
end;
