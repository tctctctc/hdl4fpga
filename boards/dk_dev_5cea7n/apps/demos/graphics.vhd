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
use ieee.math_real.all;

library hdl4fpga;
use hdl4fpga.base.all;
use hdl4fpga.profiles.all;
use hdl4fpga.app_profiles.all;
use hdl4fpga.sdram_db.all;
use hdl4fpga.videopkg.all;
use hdl4fpga.ipoepkg.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

architecture graphics of dk_dev_5cea7n is

	type app_profiles is (
		sdr200MHz_600p,
		sdr225MHz_600p,
		sdr250MHz_600p,
		sdr275MHz_600p,
		sdr300MHz_600p,
		sdr333MHz_600p,
		sdr350MHz_600p,
		sdr375MHz_600p,
		sdr400MHz_600p);

	----------------------------------------------------------
	constant app_profile : app_profiles := sdr350Mhz_600p;  --
	----------------------------------------------------------

	type profileparam_vector is array (app_profiles) of profile_params;
	constant profile_tab : profileparam_vector := (
		sdr200MHz_600p => (io_ipoe, sdram200MHz, mode600p24bpp),
		sdr225MHz_600p => (io_ipoe, sdram225MHz, mode600p24bpp),
		sdr250MHz_600p => (io_ipoe, sdram250MHz, mode600p24bpp),
		sdr275MHz_600p => (io_ipoe, sdram275MHz, mode600p24bpp),
		sdr300MHz_600p => (io_ipoe, sdram300MHz, mode600p24bpp),
		sdr333MHz_600p => (io_ipoe, sdram333MHz, mode600p24bpp),
		sdr350MHz_600p => (io_ipoe, sdram350MHz, mode600p24bpp),
		sdr375MHz_600p => (io_ipoe, sdram375MHz, mode600p24bpp),
		sdr400MHz_600p => (io_ipoe, sdram400MHz, mode600p24bpp));

	signal sys_clk        : std_logic;

	signal video_clk      : std_logic;
	signal video_lckd     : std_logic;
	signal videoio_clk    : std_logic;
	signal video_lck      : std_logic;
	signal video_shf_clk  : std_logic;
	signal video_hzsync   : std_logic;
    signal video_vtsync   : std_logic;
    signal video_blank    : std_logic;
    signal video_vs       : std_logic;
	signal video_hs       : std_logic;
    signal video_bk       : std_logic;
    signal video_on       : std_logic;
    signal video_dot      : std_logic;
    signal video_pixel    : std_logic_vector(0 to 32-1);
    signal video_spixel   : std_logic_vector(0 to 3-1);
	signal dvid_crgb      : std_logic_vector(8-1 downto 0);

	-- constant sclk_phases  : natural := 1;
	-- constant sclk_edges   : natural := 1;
	-- constant data_edges   : natural := 1;
	-- constant cmmd_gear    : natural := 2;
	-- constant data_gear    : natural := 4;
	-- constant data_phases  : natural := data_gear;

	constant sclk_phases  : natural := 4;
	constant sclk_edges   : natural := 2;
	constant data_edges   : natural := 2;
	constant cmmd_gear    : natural := 1;
	constant data_gear    : natural := 2;
	constant data_phases  : natural := 2;

	constant coln_size    : natural := 10;
	constant bank_size    : natural := 2;
	constant addr_size    : natural := 13;
	-- constant bank_size    : natural := ddr3_ba'length;
	-- constant addr_size    : natural := ddr3_a'length;

	constant word_size    : natural := ddr3_dq'length;
	constant byte_size    : natural := ddr3_dq'length/ddr3_dqs_p'length;

	-- constant word_size    : natural := 8*2;
	-- constant byte_size    : natural := 8;

	signal si_frm         : std_logic;
	signal si_irdy        : std_logic;
	signal si_trdy        : std_logic;
	signal si_end         : std_logic;
	signal si_data        : std_logic_vector(0 to 8-1);

	signal so_frm         : std_logic;
	signal so_irdy        : std_logic;
	signal so_trdy        : std_logic;
	signal so_data        : std_logic_vector(0 to 8-1);


	signal ctlrphy_frm    : std_logic;
	signal ctlrphy_trdy   : std_logic;
	signal ctlr_inirdy    : std_logic;
	signal ctlrphy_synced : std_logic;
	signal ctlrphy_ini    : std_logic;
	signal ctlrphy_rw     : std_logic;
	signal ctlrphy_wlreq  : std_logic;
	signal ctlrphy_wlrdy  : std_logic;
	signal ctlrphy_rlreq  : std_logic;
	signal ctlrphy_rlrdy  : std_logic;
	signal ctlrphy_rlcal  : std_logic;
	signal ctlrphy_rlseq  : std_logic;

	signal ctlr_clks      : std_logic_vector(0 to 2-1);
	alias  ddr_clk0       : std_logic is ctlr_clks(0);
	alias  ddr_clk90      : std_logic is ctlr_clks(1);
	signal ddr_clk0x2     : std_logic;
	signal ddr_clk90x2    : std_logic;
	signal ddr_ba         : std_logic_vector(bank_size-1 downto 0);
	signal ddr_a          : std_logic_vector(addr_size-1 downto 0);
	signal ctlrphy_rst    : std_logic_vector(cmmd_gear-1 downto 0);
	signal ctlrphy_cke    : std_logic_vector(cmmd_gear-1 downto 0);
	signal ctlrphy_cs     : std_logic_vector(cmmd_gear-1 downto 0);
	signal ctlrphy_ras    : std_logic_vector(cmmd_gear-1 downto 0);
	signal ctlrphy_cas    : std_logic_vector(cmmd_gear-1 downto 0);
	signal ctlrphy_we     : std_logic_vector(cmmd_gear-1 downto 0);
	signal ctlrphy_odt    : std_logic_vector(cmmd_gear-1 downto 0);
	signal ctlrphy_cmd    : std_logic_vector(0 to 3-1);
	signal ctlrphy_ba     : std_logic_vector(cmmd_gear*ddr_ba'length-1 downto 0);
	signal ctlrphy_a      : std_logic_vector(cmmd_gear*ddr_a'length-1 downto 0);
	signal ctlrphy_dqsi   : std_logic_vector(data_gear*word_size/byte_size-1 downto 0);
	signal ctlrphy_dqst   : std_logic_vector(data_gear*word_size/byte_size-1 downto 0);
	signal ctlrphy_dqso   : std_logic_vector(data_gear*word_size/byte_size-1 downto 0);
	signal ctlrphy_dmi    : std_logic_vector(data_gear*word_size/byte_size-1 downto 0);
	signal ctlrphy_dmt    : std_logic_vector(data_gear*word_size/byte_size-1 downto 0);
	signal ctlrphy_dmo    : std_logic_vector(data_gear*word_size/byte_size-1 downto 0);
	signal ctlrphy_dqi    : std_logic_vector(data_gear*word_size-1 downto 0);
	signal ctlrphy_dqt    : std_logic_vector(data_gear*word_size/byte_size-1 downto 0);
	signal ctlrphy_dqo    : std_logic_vector(data_gear*word_size-1 downto 0);
	signal ctlrphy_sto    : std_logic_vector(data_gear*word_size/byte_size-1 downto 0);
	signal ctlrphy_sti    : std_logic_vector(data_gear*word_size/byte_size-1 downto 0);

	signal ddr3_clk       : std_logic_vector(0 to 0);
	signal ddr3_dqst      : std_logic_vector(word_size/byte_size-1 downto 0);
	signal ddr3_dqso      : std_logic_vector(word_size/byte_size-1 downto 0);
	signal ddr3_dqsi      : std_logic_vector(word_size/byte_size-1 downto 0);
	signal ddr3_dqo       : std_logic_vector(word_size-1 downto 0);
	signal ddr3_dqt       : std_logic_vector(word_size-1 downto 0);

	signal gtx_clk        : std_logic;
	signal gtx_rst        : std_logic;

	signal sys_rst        : std_logic;
	signal sys_clks       : std_logic_vector(0 to 5-1);
	signal phy_rsts       : std_logic_vector(0 to 3-1);
	signal sdrphy_rst     : std_logic;

	alias  mii_txc        : std_logic is gtx_clk;
	alias  sio_clk        : std_logic is gtx_clk;
	alias  dmacfg_clk     : std_logic is gtx_clk;

	signal tp_delay       : std_logic_vector(word_size/byte_size*6-1 downto 0);
	signal tp_bit         : std_logic_vector(word_size/byte_size*5-1 downto 0);
	signal tst            : std_logic;
	signal tp_sel         : std_logic_vector(0 to unsigned_num_bits(WORD_SIZE/BYTE_SIZE-1)-1);

	signal ddr_d          : std_logic_vector(word_size-1 downto 0);
	signal ddr_dqst       : std_logic_vector(word_size/byte_size-1 downto 0);
	signal ddr_dqso       : std_logic_vector(word_size/byte_size-1 downto 0);

	signal tp             : std_logic_vector(1 to 32);
	signal mii_tp         : std_logic_vector(1 to 32);
	signal ser_data       : std_logic_vector(0 to 8-1);
	constant sdram_tcp    : real := 1.0/300.0e6;
	constant videotiming_id    : videotiming_ids := pclk40_00m800x600at60;

begin

	sys_clk <= clkin_50_fpga_top;
	process (s8, sys_clk)
		variable tmr : unsigned(0 to 8-1) := (others => '0');
	begin
		if s8='1' then
			tmr := (others => '0');
		elsif rising_edge(sys_clk) then
			if tmr(0)='0' then
				tmr := tmr + 1;
			end if;
		end if;
		sys_rst <= not tmr(0);
	end process;
	
	ddr_b : block
		-- port (
			-- sys_rst     : in  std_logic;
			-- sys_clk     : in  std_logic;
			-- sdrphy_rst  : out std_logic;
			-- ddr_clk0x2  : out std_logic;
			-- ddr_clk90x2 : out std_logic;
			-- ddr_clk0    : out std_logic;
			-- ddr_clk90   : out std_logic)
		-- port map (
			-- sys_rst     => sys_rst,
			-- sys_clk     => sys_clk,
			-- sdrphy_rst  => sdrphy_rst,
			-- ddr_clk0x2  => ddr_clk0x2,
			-- ddr_clk90x2 => ddr_clk90x2,
			-- ddr_clk0    => ddr_clk0,
			-- ddr_clk90   => ddr_clk90);
	begin

		gbx4_g : if data_gear=4 generate 
			signal ddr_clkfb         : std_logic;
			signal ddr_clk0x2_mmce2  : std_logic;
			signal ddr_clk90x2_mmce2 : std_logic;
			signal ddr_clk0_mmce2    : std_logic;
			signal ddr_clk90_mmce2   : std_logic;

		begin

			ctlrphy_dqsi <= (others => ddr_clk90);

		end generate;

		gbx2_g : if  data_gear=2 generate 

		begin

			ddr_clk0 <= sys_clk;
			ddr_clk90 <= sys_clk;
			-- ctlrphy_dqsi <= (others => ddr_clk0); --IDDR
			-- ctlrphy_dqsi <= (others => ddr_clk90);
		end generate;

	end block;

	videodcm_b : block
		-- port (
			-- sys_rst         : in  std_logic;
			-- sys_clk         : in  std_logic;
			-- video_clk       : out std_logic;
			-- video_shift_clk : out std_logic)
		-- port map (
			-- sys_rst         => sys_rst,
			-- sys_clk         => sys_clk,
			-- video_clk       => video_clk,
			-- video_shift_clk => video_shift_clk);
	begin
	end block;
	
	gtx_b : block
		-- port (
			-- sys_rst : in  std_logic;
			-- sys_clk : in  std_logic;
			-- gtx_clk : out std_logic;
			-- gtx_rst : out std_logic)
		-- port map (
			-- sys_rst  => sys_rst,
			-- sys_clk  => sys_clk,
			-- gtx_clk  => gtx_clk,
			-- gtx_rst  => video_shift_clk);
	begin
	end block;

	ipoe_b : block

		signal mii_rxc    : std_logic;
		signal mii_rxdv   : std_logic;
		signal mii_rxd    : std_logic_vector(0 to 2*eneta_rx_data'length-1);

		signal dhcpcd_req : std_logic := '0';
		signal dhcpcd_rdy : std_logic := '0';

		signal mii_txen   : std_logic;
		signal mii_txd    : std_logic_vector(mii_rxd'range);
		signal miirx_frm  : std_logic;
		signal miirx_irdy : std_logic;
		signal miirx_data : std_logic_vector(mii_rxd'range);

		signal miitx_frm  : std_logic;
		signal miitx_irdy : std_logic;
		signal miitx_trdy : std_logic;
		signal miitx_end  : std_logic;
		signal miitx_data : std_logic_vector(si_data'range);

		signal mii_txcrxd : std_logic_vector(mii_rxd'range);

	begin

		mii_rxc  <= gtx_clk;
        rxd_i : altddio_in
		generic map (
			width	=> eneta_rx_data'length)
		port map (
            inclock   => eneta_rx_clk,
            datain	  => eneta_rx_data,
            dataout_h => mii_rxd(0 to eneta_rx_data'length-1),
            dataout_l => mii_rxd(eneta_rx_data'length to 2*eneta_rx_data'length-1));

		rxdv_i : altddio_in
		generic map (
			width	=> 1)
		port map (
			inclock      => eneta_rx_clk,
			datain(0)    => eneta_rx_dv,
			dataout_h(0) => mii_rxdv);

		sync_b : block

			signal rxc_rxbus : std_logic_vector(0 to mii_txcrxd'length);
			signal txc_rxbus : std_logic_vector(0 to mii_txcrxd'length);
			signal dst_irdy  : std_logic;
			signal dst_trdy  : std_logic;

		begin

			process (mii_rxc)
				variable q : std_logic_vector(rxc_rxbus'range);
			begin
				if rising_edge(mii_rxc) then
					q := mii_rxdv & mii_rxd;
					rxc_rxbus <= q;
				end if;
			end process;

			-- rxc2txc_e : entity hdl4fpga.fifo
			-- generic map (
				-- max_depth  => 4,
				-- latency    => 0,
				-- dst_offset => 0,
				-- src_offset => 2,
				-- check_sov  => false,
				-- check_dov  => true,
				-- gray_code  => false)
			-- port map (
				-- src_clk  => mii_rxc,
				-- src_data => rxc_rxbus,
				-- dst_clk  => mii_txc,
				-- dst_irdy => dst_irdy,
				-- dst_trdy => dst_trdy,
				-- dst_data => txc_rxbus);
-- 
			-- process (mii_txc)
			-- begin
				-- if rising_edge(mii_txc) then
					-- dst_trdy   <= to_stdulogic(to_bit(dst_irdy));
					-- miirx_frm  <= txc_rxbus(0);
					-- miirx_data <= txc_rxbus(1 to mii_txcrxd'length);
				-- end if;
			-- end process;
		end block;
-- 
		-- dhcp_p : process(mii_txc)
			-- type states is (north, south);
			-- variable state : states;
		-- begin
			-- if rising_edge(mii_txc) then
				-- if to_bit(dhcpcd_req xor dhcpcd_rdy)='0' then
					-- case state is
					-- when north =>
						-- if s5='1' then 
							-- dhcpcd_req <= not dhcpcd_rdy;
							-- state := south;
						-- end if;
					-- when south =>
						-- if s6='1' then 
							-- dhcpcd_req <= not dhcpcd_rdy;
							-- state := north;
						-- end if;
					-- end case;
				-- end if;
			-- end if;
		-- end process;
-- 
		-- udpdaisy_e : entity hdl4fpga.sio_dayudp
		-- generic map (
			-- debug         => false,
			-- my_mac        => x"00_40_00_01_02_03",
			-- default_ipv4a => aton("192.168.0.14"))
		-- port map (
			-- tp         => mii_tp,
-- 
			-- sio_clk    => sio_clk,
			-- dhcpcd_req => dhcpcd_req,
			-- dhcpcd_rdy => dhcpcd_rdy,
			-- miirx_frm  => miirx_frm,
			-- miirx_irdy => '1', --miirx_irdy,
			-- miirx_trdy => open,
			-- miirx_data => miirx_data,
-- 
			-- miitx_frm  => miitx_frm,
			-- miitx_irdy => miitx_irdy,
			-- miitx_trdy => miitx_trdy,
			-- miitx_end  => miitx_end,
			-- miitx_data => miitx_data,
-- 
			-- si_frm     => si_frm,
			-- si_irdy    => si_irdy,
			-- si_trdy    => si_trdy,
			-- si_end     => si_end,
			-- si_data    => si_data,
-- 
			-- so_frm     => so_frm,
			-- so_irdy    => so_irdy,
			-- so_trdy    => so_trdy,
			-- so_data    => so_data);
-- 
		-- desser_e: entity hdl4fpga.desser
		-- port map (
			-- desser_clk => mii_txc,
-- 
			-- des_frm    => miitx_frm,
			-- des_irdy   => miitx_irdy,
			-- des_trdy   => miitx_trdy,
			-- des_data   => miitx_data,
-- 
			-- ser_irdy   => open,
			-- ser_data   => mii_txd);
-- 
		-- mii_txen <= miitx_frm and not miitx_end;
		-- process (mii_txc)
		-- begin
			-- if rising_edge(mii_txc) then
				-- eneta_tx_en <= mii_txen;
				-- eneta_tx_data(mii_rxd'range) <= mii_txd;
			-- end if;
		-- end process;
-- 
	end block;

	graphics_e : entity hdl4fpga.demo_graphics
	generic map (
		debug => debug,
		profile      => 1,
		sdram_tcp    => 2.0*sdram_tcp,
		-- sdram_tcp    => sdram_tcp,
		fpga         => xc5v,
		mark         => MT47H512M3,
		sclk_phases  => sclk_phases,
		sclk_edges   => sclk_edges,
		cmmd_gear    => cmmd_gear,
		data_phases  => data_phases,
		data_edges   => data_edges,
		data_gear    => data_gear,
		bank_size    => bank_size,
		addr_size    => addr_size,
		coln_size    => coln_size,
		word_size    => word_size,
		byte_size    => byte_size,
		-- burst_length => 4,
		burst_length => 8,

		timing_id    => videotiming_id,
		red_length   => 8,
		green_length => 8,
		blue_length  => 8,

		fifo_size    => 8*2048)

	port map (
		sio_clk       => sio_clk,
		sin_frm       => so_frm,
		sin_irdy      => so_irdy,
		sin_trdy      => so_trdy,
		sin_data      => so_data,
		sout_frm      => si_frm,
		sout_irdy     => si_irdy,
		sout_trdy     => si_trdy,
		sout_end      => si_end,
		sout_data     => si_data,

		video_clk     => '0', --video_clk,
		video_shift_clk => '0', --video_shf_clk,
		video_hzsync  => video_hzsync,
		video_vtsync  => video_vtsync,
		video_blank   => video_blank,
		video_pixel   => video_pixel,
		dvid_crgb     => dvid_crgb,

		ctlr_clks     => ctlr_clks(0 to sclk_phases/sclk_edges-1),
		ctlr_rst      => sdrphy_rst, --ddrsys_rst,
		ctlr_cwl      => b"0_11",
		ctlr_rtt      => b"11",
		ctlr_al       => "001",
		-- ctlr_wrl      : in  std_logic_vector(0 to 3-1) := "101";
		-- ctlr_bl       => "010", -- Busrt length 4
		ctlr_bl       => "011", -- Busrt length 8
		ctlr_cl       => "011",
		ctlr_cmd      => ctlrphy_cmd,
		ctlr_inirdy   => ctlr_inirdy,
		ctlrphy_ini   => ctlrphy_ini,
		ctlrphy_rlreq => ctlrphy_rlreq,
		ctlrphy_rlrdy => ctlrphy_rlrdy,
		ctlrphy_irdy  => ctlrphy_frm,
		ctlrphy_rw    => ctlrphy_rw,
		ctlrphy_trdy  => ctlrphy_trdy,
		ctlrphy_rst   => ctlrphy_rst(0),
		ctlrphy_cke   => ctlrphy_cke(0),
		ctlrphy_cs    => ctlrphy_cs(0),
		ctlrphy_ras   => ctlrphy_ras(0),
		ctlrphy_cas   => ctlrphy_cas(0),
		ctlrphy_we    => ctlrphy_we(0),
		ctlrphy_odt   => ctlrphy_odt(0),
		ctlrphy_b     => ddr_ba,
		ctlrphy_a     => ddr_a,
		ctlrphy_dsi   => ctlrphy_dqsi,
		ctlrphy_dst   => ctlrphy_dqst,
		ctlrphy_dso   => ctlrphy_dqso,
		ctlrphy_dmi   => ctlrphy_dmi,
		ctlrphy_dmt   => ctlrphy_dmt,
		ctlrphy_dmo   => ctlrphy_dmo,
		ctlrphy_dqi   => ctlrphy_dqi,
		ctlrphy_dqt   => ctlrphy_dqt,
		ctlrphy_dqo   => ctlrphy_dqo,
		ctlrphy_sto   => ctlrphy_sto,
		ctlrphy_sti   => ctlrphy_sti,
		tp => open);

	videoio_b : block
		signal xclk : std_logic;
	begin
		-- process (video_clk)
		-- begin
			-- if rising_edge(video_clk) then
				-- dvi_de <= not video_blank;
				-- dvi_h  <= video_hzsync;
				-- dvi_v  <= video_vtsync;
			-- end if;
		-- end process;

		-- xclkp_i : oddr
		-- port map (
			-- c => video_clk,
			-- ce => '1',
			-- s  => '0',
			-- r  => '0',
			-- d1 => '1',
			-- d2 => '0',
			-- q  => xclk);
	-- 
		-- diff_i: obufds
		-- generic map (
			-- iostandard => "LVDS_25")
		-- port map (
			-- i  => xclk,
			-- o  => dvi_xclk_p,
			-- ob => dvi_xclk_n);
	-- 
	-- 
		-- d_g : for i in dvi_d'range generate
		-- begin
			-- oddr_i : oddr
			-- port map (
				-- c => video_clk,
				-- ce => '1',
				-- s  => '0',
				-- r  => '0',
				-- d1 => '1', --video_pixel(i),
				-- d2 => '1', --video_pixel(i+dvi_d'length),
				-- q  => dvi_d(i));
	-- 
		-- end generate;

	end block;

	gear_g : for i in 1 to CMMD_GEAR-1 generate
		ctlrphy_cke(i) <= ctlrphy_cke(0);
		ctlrphy_cs(i)  <= ctlrphy_cs(0);
		ctlrphy_ras(i) <= '1';
		ctlrphy_cas(i) <= '1';
		ctlrphy_we(i)  <= '1';
		ctlrphy_odt(i) <= ctlrphy_odt(0);
	end generate;

	process (ddr_ba)
	begin
		for i in ddr_ba'range loop
			for j in 0 to CMMD_GEAR-1 loop
				ctlrphy_ba(i*CMMD_GEAR+j) <= ddr_ba(i);
			end loop;
		end loop;
	end process;

	process (ddr_a)
	begin
		for i in ddr_a'range loop
			for j in 0 to CMMD_GEAR-1 loop
				ctlrphy_a(i*CMMD_GEAR+j) <= ddr_a(i);
			end loop;
		end loop;
	end process;

	-- ctlrphy_rst(1) <= ctlrphy_rst(0);
	-- ctlrphy_cke(1) <= ctlrphy_cke(0);
	-- ctlrphy_cs(1)  <= ctlrphy_cs(0);
	-- ctlrphy_ras(1) <= '1';
	-- ctlrphy_cas(1) <= '1';
	-- ctlrphy_we(1)  <= '1';
	-- ctlrphy_odt(1) <= ctlrphy_odt(0);

	ctlrphy_wlreq <= to_stdulogic(to_bit(ctlrphy_wlrdy));
	
	-- sdrphy_e : entity hdl4fpga.xc_sdrphy
	-- generic map (
		-- dqs_delay   => (0 => 0.954 ns, 1 => 6.954 ns),
		-- dqi_delay   => (0 => 0.937 ns, 1 => 6.937 ns),
		-- device      => xc5v,
		-- bufio       => false,
		-- bypass      => false,
		-- taps        => natural(floor(sdram_tcp*(64.0*200.0e6)))-1,
		-- bank_size   => bank_size,
		-- addr_size   => addr_size,
		-- cmmd_gear   => cmmd_gear,
		-- data_gear   => data_gear,
		-- word_size   => word_size,
		-- byte_size   => byte_size)
	-- port map (
		-- rst        => sdrphy_rst,
		-- iod_clk    => sys_clk,
		-- clk0       => ddr_clk0,
		-- clk90      => ddr_clk90,
		-- clk0x2     => ddr_clk0x2,
		-- clk90x2    => ddr_clk90x2,
		-- phy_frm    => ctlrphy_frm,
		-- phy_trdy   => ctlrphy_trdy,
		-- phy_rw     => ctlrphy_rw,
		-- phy_ini    => ctlrphy_ini,
		-- phy_synced => ctlrphy_synced,
-- 
		-- phy_cmd    => ctlrphy_cmd,
		-- phy_wlreq  => ctlrphy_wlreq,
		-- phy_wlrdy  => ctlrphy_wlrdy,
		-- phy_rlreq  => ctlrphy_rlreq,
		-- phy_rlrdy  => ctlrphy_rlrdy,
-- 
		-- sys_cke    => ctlrphy_cke,
		-- sys_cs     => ctlrphy_cs,
		-- sys_ras    => ctlrphy_ras,
		-- sys_cas    => ctlrphy_cas,
		-- sys_we     => ctlrphy_we,
		-- sys_b      => ctlrphy_ba,
		-- sys_a      => ctlrphy_a,
-- 
		-- sys_dqst   => ctlrphy_dqst,
		-- sys_dqsi   => ctlrphy_dqso,
		-- sys_dmi    => ctlrphy_dmo,
		-- sys_dmt    => ctlrphy_dmt,
		-- sys_dmo    => ctlrphy_dmi,
		-- sys_dqi    => ctlrphy_dqo,
		-- sys_dqt    => ctlrphy_dqt,
		-- sys_dqo    => ctlrphy_dqi,
		-- sys_odt    => ctlrphy_odt,
		-- sys_sti    => ctlrphy_sto,
		-- sys_sto    => ctlrphy_sti,
		-- sdram_clk  => ddr3_clk,
		-- sdram_cke  => ddr3_cke,
		-- sdram_cs   => ddr3_cs,
		-- sdram_ras  => ddr3_ras,
		-- sdram_cas  => ddr3_cas,
		-- sdram_we   => ddr3_we,
		-- sdram_b    => ddr3_ba(bank_size-1 downto 0),
		-- sdram_a    => ddr3_a(addr_size-1 downto 0),
		-- sdram_odt  => ddr3_odt,
-- 
		-- sdram_dm   => ddr3_dm(word_size/byte_size-1 downto 0),
		-- sdram_dqo  => ddr3_dqo,
		-- sdram_dqi  => ddr3_dq(word_size-1 downto 0),
		-- sdram_dqt  => ddr3_dqt,
		-- sdram_dqst => ddr3_dqst,
		-- sdram_dqsi => ddr3_dqsi,
		-- sdram_dqso => ddr3_dqso);

	ddr3_ba(ddr3_ba'left downto bank_size) <= (others => '0');
	ddr3_a(ddr3_a'left downto addr_size)   <= (others => '0');

	d28 <= ctlr_inirdy;

	-- eneta_gtxclk_i : oddr
	-- port map (
		-- c  => gtx_clk,
		-- ce => '1',
		-- s  => '0',
		-- r  => '0',
		-- d1 => '1',
		-- d2 => '0',
		-- q  => eneta_gtx_clk);
	
	-- ddrio_b : block
	-- begin
-- 
		-- ddr_clks_g : for i in ddr3_clk'range generate
			-- ddr_ck_obufds : obufds
			-- generic map (
				-- iostandard => "DIFF_SSTL18_II")
			-- port map (
				-- i  => ddr3_clk(i),
				-- o  => ddr3_clk_p(i),
				-- ob => ddr3_clk_n(i));
		-- end generate;
-- 
		-- ddr_dqs_g : for i in ddr3_dqs_p'range generate
		-- begin
-- 
			-- true_g : if i < word_size/byte_size generate
				-- dqsiobuf_i : iobufds
				-- generic map (
					-- iostandard => "DIFF_SSTL18_II_DCI")
				-- port map (
					-- t   => ddr3_dqst(i),
					-- i   => ddr3_dqso(i),
					-- o   => ddr3_dqsi(i),
					-- io  => ddr3_dqs_p(i),
					-- iob => ddr3_dqs_n(i));
			-- end generate;
-- 
			-- false_g : if not (i < word_size/byte_size) generate
				-- dqsiobuf_i : iobufds
				-- generic map (
					-- iostandard => "DIFF_SSTL18_II_DCI")
				-- port map (
					-- t   => '1',
					-- i   => '-',
					-- o   => open,
					-- io  => ddr3_dqs_p(i),
					-- iob => ddr3_dqs_n(i));
			-- end generate;
-- 
		-- end generate;
-- 
		-- ddr_d_g : for i in ddr3_dq'range generate
			-- process (ddr3_dqo, ddr3_dqt)
			-- begin
				-- if i < word_size then
					-- if ddr3_dqt(i)='0' then
						-- ddr3_dq(i) <= ddr3_dqo(i);
					-- else
						-- ddr3_dq(i) <= 'Z';
					-- end if;
				-- else
					-- ddr3_dq(i) <= 'Z';
				-- end if;
			-- end process;
-- 
		-- end generate;
-- 
	-- end block;
	eneta_resetn  <= not gtx_rst;

end;
