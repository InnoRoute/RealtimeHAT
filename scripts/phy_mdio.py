#!/usr/bin/python3.7

import pyrpio
from pyrpio import i2c, mdio

# Configure options
options = pyrpio.RPIOConfigs(
	gpiomem=True
)
# Must be called prior to using any interface
pyrpio.configure(options)

phy_regs = [{"name": "MII_CONTROL",				"reg_addr": 0x0000,	"dev_addr": 0x00,	"default": 0x1040,	"target": 0x1140,	"access": "R/W",	"comment": "Leaving initial software power-down. Selecting Full-Duplex operation. Restart Auto-Neg."}, # 1340
			#{"name": "MII_STATUS",				"reg_addr": 0x0001,	"dev_addr": 0x00,	"default": 0x7949,	"target": 0x7949,	"access": "R",	"comment": ""},
			#{"name": "PHY_ID_1",				"reg_addr": 0x0002,	"dev_addr": 0x00,	"default": 0x0283,	"target": 0x0283,	"access": "R",	"comment": ""},
			#{"name": "PHY_ID_2",				"reg_addr": 0x0003,	"dev_addr": 0x00,	"default": 0xBC30,	"target": 0xBC30,	"access": "R",	"comment": ""},
			{"name": "AUTONEG_ADV",				"reg_addr": 0x0004,	"dev_addr": 0x00,	"default": 0x01E1,	"target": 0x01E1,	"access": "R/W",	"comment": "Disable Half-Duplex operation."},
			#{"name": "LP_ABILITY",				"reg_addr": 0x0005,	"dev_addr": 0x00,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			#{"name": "AUTONEG_EXP",				"reg_addr": 0x0006,	"dev_addr": 0x00,	"default": 0x0064,	"target": 0x0064,	"access": "R",	"comment": ""},
			{"name": "TX_NEXT_PAGE",			"reg_addr": 0x0007,	"dev_addr": 0x00,	"default": 0x2001,	"target": 0x2001,	"access": "R/W",	"comment": ""},
			#{"name": "LP_RX_NEXT_PAGE",			"reg_addr": 0x0008,	"dev_addr": 0x00,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			{"name": "MSTR_SLV_CONTROL",		"reg_addr": 0x0009,	"dev_addr": 0x00,	"default": 0x0200,	"target": 0x0200,	"access": "R/W",	"comment": "Prefer Master - not forcing to be Master."},
			#{"name": "MSTR_SLV_STATUS",			"reg_addr": 0x000A,	"dev_addr": 0x00,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			#{"name": "EXT_STATUS",				"reg_addr": 0x000F,	"dev_addr": 0x00,	"default": 0x3000,	"target": 0x3000,	"access": "R",	"comment": ""},
			{"name": "EXT_REG_PTR",			"reg_addr": 0x0010,	"dev_addr": 0x00,	"default": 0x0000,	"target": 0xBA1B,	"access": "R/W",	"comment": ""},
			{"name": "EXT_REGD_ATA",			"reg_addr": 0x0011,	"dev_addr": 0x00,	"default": 0x0000,	"target": 0x0000,	"access": "R/W",	"comment": ""},
			{"name": "PHY_CTRL_1",				"reg_addr": 0x0012,	"dev_addr": 0x00,	"default": 0x0002,	"target": 0x0602,	"access": "R/W",	"comment": "Enable Manual+Auto-MDIX, enable diagnistics clock."},
			{"name": "PHY_CTRL_STATUS_1",		"reg_addr": 0x0013,	"dev_addr": 0x00,	"default": 0x1041,	"target": 0x0041,	"access": "R/W",	"comment": ""},
			#{"name": "RX_ER_RCNT",				"reg_addr": 0x0014,	"dev_addr": 0x00,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			{"name": "PHY_CTRL_STATUS_2",		"reg_addr": 0x0015,	"dev_addr": 0x00,	"default": 0x0000,	"target": 0x0000,	"access": "R/W",	"comment": ""},
			{"name": "PHY_CTRL_2",				"reg_addr": 0x0016,	"dev_addr": 0x00,	"default": 0x0308,	"target": 0x0308,	"access": "R/W",	"comment": ""},
			{"name": "PHY_CTRL_3",				"reg_addr": 0x0017,	"dev_addr": 0x00,	"default": 0x3048,	"target": 0x3048,	"access": "R/W",	"comment": ""},
			{"name": "IRQ_MASK",				"reg_addr": 0x0018,	"dev_addr": 0x00,	"default": 0x0000,	"target": 0x0000,	"access": "R/W",	"comment": "Enable all interrupts."},
			#{"name": "IRQ_STATUS",				"reg_addr": 0x0019,	"dev_addr": 0x00,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			#{"name": "PHY_STATUS_1",			"reg_addr": 0x001A,	"dev_addr": 0x00,	"default": 0x0300,	"target": 0x0300,	"access": "R",	"comment": ""},
			{"name": "LED_CTRL_1",				"reg_addr": 0x001B,	"dev_addr": 0x00,	"default": 0x0001,	"target": 0x0001,	"access": "R/W",	"comment": ""},
			{"name": "LED_CTRL_2",				"reg_addr": 0x001C,	"dev_addr": 0x00,	"default": 0x210A,	"target": 0x210A,	"access": "R/W",	"comment": ""},
			{"name": "LED_CTRL_3",				"reg_addr": 0x001D,	"dev_addr": 0x00,	"default": 0x1855,	"target": 0x1855,	"access": "R/W",	"comment": ""},
			#{"name": "PHY_STATUS_2",			"reg_addr": 0x001F,	"dev_addr": 0x00,	"default": 0x03FC,	"target": 0x03FC,	"access": "R",	"comment": ""},
			#{"name": "EEE_CAPABILITY",			"reg_addr": 0x8000,	"dev_addr": 0x1E,	"default": 0x0006,	"target": 0x0006,	"access": "R",	"comment": ""},
			{"name": "EEE_ADV",					"reg_addr": 0x8001,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R/W",	"comment": ""},
			#{"name": "EEE_LP_ABILITY",			"reg_addr": 0x8002,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			#{"name": "EEE_RSLVD",				"reg_addr": 0x8008,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			#{"name": "MSE_A",					"reg_addr": 0x8402,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			#{"name": "MSE_B",					"reg_addr": 0x8403,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			#{"name": "MSE_C",					"reg_addr": 0x8404,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			#{"name": "MSE_D",					"reg_addr": 0x8405,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			{"name": "FLD_EN",					"reg_addr": 0x8E27,	"dev_addr": 0x1E,	"default": 0x003D,	"target": 0x0400,	"access": "R/W",	"comment": ""},
			#{"name": "FLD_STAT_LAT",			"reg_addr": 0x8E38,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			{"name": "RX_MII_CLK_STOP_EN",		"reg_addr": 0x9400,	"dev_addr": 0x1E,	"default": 0x0400,	"target": 0x0400,	"access": "R/W",	"comment": ""},
			#{"name": "PCS_STATUS_1",			"reg_addr": 0x9401,	"dev_addr": 0x1E,	"default": 0x0040,	"target": 0x0040,	"access": "R",	"comment": ""},
			{"name": "FC_EN",					"reg_addr": 0x9403,	"dev_addr": 0x1E,	"default": 0x0001,	"target": 0x0001,	"access": "R/W",	"comment": ""},
			{"name": "FC_IRQ_EN",				"reg_addr": 0x9406,	"dev_addr": 0x1E,	"default": 0x0001,	"target": 0x0001,	"access": "R/W",	"comment": ""},
			{"name": "FC_TX_SEL",				"reg_addr": 0x9407,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0001,	"access": "R/W",	"comment": ""},
			{"name": "FC_MAX_FRM_SIZE",			"reg_addr": 0x9408,	"dev_addr": 0x1E,	"default": 0x05F2,	"target": 0x05F2,	"access": "R/W",	"comment": ""},
			#{"name": "FC_FRM_CNT_H",			"reg_addr": 0x940A,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			#{"name": "FC_FRM_CNT_L",			"reg_addr": 0x940B,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			#{"name": "FC_LEN_ERR_CNT",			"reg_addr": 0x940C,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			#{"name": "FC_ALGN_ERR_CNT",			"reg_addr": 0x940D,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			#{"name": "FC_SYMB_ERR_CNT",			"reg_addr": 0x940E,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			#{"name": "FC_OSZ_CNT",				"reg_addr": 0x940F,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			#{"name": "FC_USZ_CNT",				"reg_addr": 0x9410,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			#{"name": "FC_ODD_CNT",				"reg_addr": 0x9411,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			#{"name": "FC_ODD_PRE_CNT",			"reg_addr": 0x9412,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			#{"name": "FC_DRIBBLE_BITS_CNT",		"reg_addr": 0x9413,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			#{"name": "FC_FALSE_CARRIER_CNT",	"reg_addr": 0x9414,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			{"name": "FG_EN",					"reg_addr": 0x9415,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R/W",	"comment": ""},
			{"name": "FG_CNTRL_RSTRT",			"reg_addr": 0x9416,	"dev_addr": 0x1E,	"default": 0x0001,	"target": 0x0001,	"access": "R/W",	"comment": ""},
			{"name": "FG_CONT_MODE_EN",			"reg_addr": 0x9417,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R/W",	"comment": ""},
			{"name": "FG_IRQ_EN",				"reg_addr": 0x9418,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R/W",	"comment": ""},
			{"name": "FG_FRM_LEN",				"reg_addr": 0x941A,	"dev_addr": 0x1E,	"default": 0x006B,	"target": 0x006B,	"access": "R/W",	"comment": ""},
			{"name": "FG_NFRM_H",				"reg_addr": 0x941C,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R/W",	"comment": ""},
			{"name": "FG_NFRM_L",				"reg_addr": 0x941D,	"dev_addr": 0x1E,	"default": 0x0100,	"target": 0x0100,	"access": "R/W",	"comment": ""},
			#{"name": "FG_DONE",					"reg_addr": 0x941E,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			{"name": "FIFO_SYNC",				"reg_addr": 0x9427,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0001,	"access": "R/W",	"comment": "Enable synchronous operation (always except for 1000BASE-T slave mode)."},
			{"name": "SOP_CTRL",				"reg_addr": 0x9428,	"dev_addr": 0x1E,	"default": 0x0034,	"target": 0x0034,	"access": "R/W",	"comment": "SoP detection for TX frames."},
			{"name": "SOP_RX_DEL",				"reg_addr": 0x9429,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R/W",	"comment": ""},
			{"name": "SOP_TX_DEL",				"reg_addr": 0x942A,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R/W",	"comment": ""},
			{"name": "DPTH_MII_BYTE",			"reg_addr": 0x9602,	"dev_addr": 0x1E,	"default": 0x0001,	"target": 0x0000,	"access": "R/W",	"comment": ""},
			#{"name": "LPI_WAKE_ERR_CNT",		"reg_addr": 0xA000,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			{"name": "B_1000_RTRN_EN",			"reg_addr": 0xA001,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R/W",	"comment": ""},
			{"name": "B_10E_En",				"reg_addr": 0xB403,	"dev_addr": 0x1E,	"default": 0x0001,	"target": 0x0001,	"access": "R/W",	"comment": ""},
			{"name": "B_10_TX_TST_MODE",		"reg_addr": 0xB412,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R/W",	"comment": ""},
			{"name": "B_100_TX_TST_MODE",		"reg_addr": 0xB413,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R/W",	"comment": ""},
			{"name": "CDIAG_RUN",				"reg_addr": 0xBA1B,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R/W",	"comment": ""},
			{"name": "CDIAG_XPAIR_DIS",			"reg_addr": 0xBA1C,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R/W",	"comment": ""},
			#{"name": "CDIAG_DTLD_RSLTS_0",		"reg_addr": 0xBA1D,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			#{"name": "CDIAG_DTLD_RSLTS_1",		"reg_addr": 0xBA1E,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			#{"name": "CDIAG_DTLD_RSLTS_2",		"reg_addr": 0xBA1F,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			#{"name": "CDIAG_DTLD_RSLTS_3",		"reg_addr": 0xBA20,	"dev_addr": 0x1E,	"default": 0x0000,	"target": 0x0000,	"access": "R",	"comment": ""},
			#{"name": "CDIAG_FLT_DIST_0",		"reg_addr": 0xBA21,	"dev_addr": 0x1E,	"default": 0x00FF,	"target": 0x00FF,	"access": "R",	"comment": ""},
			#{"name": "CDIAG_FLT_DIST_1",		"reg_addr": 0xBA22,	"dev_addr": 0x1E,	"default": 0x00FF,	"target": 0x00FF,	"access": "R",	"comment": ""},
			#{"name": "CDIAG_FLT_DIST_2",		"reg_addr": 0xBA23,	"dev_addr": 0x1E,	"default": 0x00FF,	"target": 0x00FF,	"access": "R",	"comment": ""},
			#{"name": "CDIAG_FLT_DIST_3",		"reg_addr": 0xBA24,	"dev_addr": 0x1E,	"default": 0x00FF,	"target": 0x00FF,	"access": "R",	"comment": ""},
			#{"name": "CDIAG_CBL_LEN_EST",		"reg_addr": 0xBA25,	"dev_addr": 0x1E,	"default": 0x00FF,	"target": 0x00FF,	"access": "R",	"comment": ""},
			{"name": "LED_PUL_STR_DUR",			"reg_addr": 0xBC00,	"dev_addr": 0x1E,	"default": 0x0011,	"target": 0x0011,	"access": "R/W",	"comment": ""},
			{"name": "GE_SFT_RST",				"reg_addr": 0xFF0C,	"dev_addr": 0x1E,	"default": 0x0000, "target": 0x0000,	"access": "R/W",	"comment": ""},
			{"name": "GE_SFT_RST_CFG_EN",		"reg_addr": 0xFF0D,	"dev_addr": 0x1E,	"default": 0x0000, "target": 0x0001,	"access": "R/W",	"comment": ""},
			{"name": "GE_CLK_CFG",                "reg_addr": 0xFF1F,    "dev_addr": 0x1E,    "default": 0x0000, "target": 0x0020,    "access": "R/W",    "comment": "Drive recovered clock to GP_CLK pin. Output 25MHz at CLK25_REF."},
			{"name": "GE_RGMII_CFG",			"reg_addr": 0xFF23,	"dev_addr": 0x1E,	"default": 0x0E05, "target": 0x0E05,	"access": "R/W",	"comment": ""},
			{"name": "GE_RMII_CFG",				"reg_addr": 0xFF24,	"dev_addr": 0x1E,	"default": 0x0116, "target": 0x0116,	"access": "R/W",	"comment": ""},
			{"name": "GE_PHY_BASE_CFG",			"reg_addr": 0xFF26,	"dev_addr": 0x1E,	"default": 0x0C86, "target": 0x0F8E,	"access": "R/W",	"comment": ""},
			{"name": "GE_LNK_STAT_INV_EN",		"reg_addr": 0xFF3C,	"dev_addr": 0x1E,	"default": 0x0000, "target": 0x0000,	"access": "R/W",	"comment": ""},
			{"name": "GE_IO_GP_CLK_OR_CNTRL",	"reg_addr": 0xFF3D,	"dev_addr": 0x1E,	"default": 0x0000, "target": 0x0000,	"access": "R/W",	"comment": "Always selected clock to GP_CLK pin (should not make a difference)."},
			{"name": "GE_IO_GP_OUT_OR_CNTRL",	"reg_addr": 0xFF3E,	"dev_addr": 0x1E,	"default": 0x0000, "target": 0x0000,	"access": "R/W",	"comment": ""}, # Set to 0x0003 for RX_SOP on LINK_ST pin
			{"name": "GE_IO_INT_N_OR_CNTRL",	"reg_addr": 0xFF3F,	"dev_addr": 0x1E,	"default": 0x0000, "target": 0x0000,	"access": "R/W",	"comment": "Always interrupt to INT_N pin (should not make a difference)."},
			{"name": "GE_IO_LED_A_OR_CNTRL",	"reg_addr": 0xFF41,	"dev_addr": 0x1E,	"default": 0x0000, "target": 0x0000,	"access": "R/W",	"comment": ""}]

### MDIO Operations ###

# Create bus using GPIO 13 clk and 12 data (bit-bang)
# mdio_open(clk_pin, data_pin)
mdio_bus = mdio.MDIO(4,17)#(13, 12)
mdio_bus.open()

# Read register (CLAUSE-45)
# read_c22_register(pad, reg)
# pad (int): 5b physical address
# reg (int): 5b register address
# mdio_bus.read_c22_register( 0x00, 0x00, 0x10)


for phy in [0,1,2]:
	print(f'################################### Start of PHY#{phy} #######################################')
	for ii in reversed(phy_regs):  # Disable software power-down last!
		if ii["dev_addr"] == 0x00:
			read_val = mdio_bus.read_c22_register(phy, ii["reg_addr"])
		else:
			mdio_bus.write_c22_register(phy, 0x10, ii["reg_addr"])
			read_val = mdio_bus.read_c22_register(phy, 0x11)
		print('Name: {0}\tAddr: 0x{1:X}\tValue_hex: 0x{2:X}\t'.format(ii["name"], ii["reg_addr"], read_val))

		if ii["target"] != read_val:  # ii["default"]:
			if "W" in ii["access"]:
				print(f'Writing {hex(ii["target"])} to {ii["name"]} at {hex(ii["reg_addr"])}. {ii["comment"]}')
				if ii["dev_addr"] == 0x00:
					mdio_bus.write_c22_register(phy, ii["reg_addr"], ii["target"])
				else:
					mdio_bus.write_c22_register(phy, 0x10, ii["reg_addr"])
					mdio_bus.write_c22_register(phy, 0x11, ii["target"])
				if ii["dev_addr"] == 0x00:
					read_val = mdio_bus.read_c22_register(phy, ii["reg_addr"])
				else:
					mdio_bus.write_c22_register(phy, 0x10, ii["reg_addr"])
					read_val = mdio_bus.read_c22_register(phy, 0x11)
				print('Name: {0}\tAddr: 0x{1:X}\tValue_hex: 0x{2:X}\t'.format(ii["name"], ii["reg_addr"], read_val))
				if ii["target"] != read_val:
					print('#### WRITE UNSUCCESSFUL! ####')
		print('\n')
	print(f'#################################### End of PHY#{phy} ########################################')

# Close up shop
mdio_bus.close()
