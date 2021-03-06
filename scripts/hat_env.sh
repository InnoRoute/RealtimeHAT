C_ADDR_SPI_BOARD_REV="0x0C0000"    	#  RO  Board ID pins (lower 3 bits), currently unused efuse_usr pins (upper bits)
C_ADDR_SPI_FPGA_TEMP="0x0C0100"    	#  RO  Sampled current temperature value (12 bits)
C_ADDR_SPI_FPGA_ID0="0x0C0200"    	#  RO  Unique ID, lower part, from DNA_PORT and EFUSE_USR (32 bits)
C_ADDR_SPI_FPGA_ID1="0x0C0300"    	#  RO  Unique ID, upper part, from DNA_PORT and EFUSE_USR (32 bits)
C_ADDR_SPI_BITGEN_TIME="0x0C0400"    	#  RO  Bitstream generation time. Not available in simulation (32 bits)
C_ADDR_SPI_FPGA_REV="0x0C0500"    	#  RO  FPGA revision numbers: Use Case, Address Map, Design ID (8+8+16=32bits)
C_ADDR_SPI_FEATURE_MAP="0x0C0600"    	#  RO  Contained basic features (32 bits)
C_ADDR_SPI_INT_PENDING="0x0C0800"    	#  RO  Masked Interrupts (32 bits: lower 10 bits used)
C_ADDR_SPI_INT_STATUS="0x0C0900"    	#  RW  Raw Interrupts (32 bits: lower 10 bits used)
C_ADDR_SPI_INT_SET_EN="0x0C0A00"    	#  RW  Enable Interrupts, Read returns current enable mask (32 bits)
C_ADDR_SPI_INT_CLR_EN="0x0C0B00"    	#  RW  Disable Interrupts, Read returns current enable mask (32 bits)
C_ADDR_SPI_FPGA_ALARM="0x0C0C00"    	#  RO  Latched/COR: Alarms from XADC (lower 6 bits)
C_ADDR_SPI_CONFIG_CHECK="0x0C0D00"    	#  RO  Latched/COR: Alarms from FRAME_ECCE2 primitive (lower 3 bits)
C_ADDR_SPI_LICENSE="0x0C0E00"    	#  RO  Licensed Features (lower 8 bits)
C_ADDR_SPI_ACCESS_ERROR="0x0C0F00"    	#  RO  Latched/COR: SPI/MMI access errors (lower 8 bits)
C_ADDR_SPI_FIFO_OVERFLOW="0x0C1000"    	#  RO  Latched/COR: FIFO overflows (32 bits)
C_ADDR_SPI_FIFO_UNDERRUN="0x0C1100"    	#  RO  Latched/COR: FIFO underrus (32 bits)
C_ADDR_SPI_EXT_INTERRUPT="0x0C1200"    	#  RO  Latched/COR: Hardware interrupts: PMIC, PHYs, LINKST (7 bits)
C_ADDR_SPI_EVENT="0x0C1300"    	#  RW  Latched/COR: Partial COR: WDT (24 bits, multiples of 64ns), Timer interrupt/PPS, Cycle Starts (total: 32 bits)
C_ADDR_SPI_MMI_INT_BITMAP="0x0C1400"    	#  RO  Latched/COR: Interrupts from MMI units
C_ADDR_SPI_BACKPRESSURE="0x0C1500"    	#  RO  Latched/COR: TXFs, TREADYs, TMFull (2 bits, one per edge)
C_ADDR_SPI_RESET="0x0C1600"    	#  RW: MMI + PHY Resets (active high)
C_ADDR_SPI_DRIVE_PPS="0x0C1700"    	#  RW: Drive PPS signal (instead of just sampling it)
C_ADDR_SPI_TEST_DRIVE="0x0C1800"    	#  WO (32 bits)
C_ADDR_SPI_TEST_VALUE="0x0C1900"    	#  WO (32 bits)
C_ADDR_SPI_TEST_INPUT="0x0C1A00"    	#  RO  gp_clklocking (3 bits), ... (32 bits)
C_ADDR_NET_TAP="0x4000"    	#  WO, lower 16 bits writeenable per port, lower part of the upper 16 bits as tap value
C_ADDR_NET_SPEED_DEBUG1="0x4004"    	#  RW: MAC Speed: 10/100/1000 Mbps, Values: 0=10M, 1=100M, 2=1G, 2 bits per port
C_ADDR_NET_SPEED_DEBUG2="0x4008"    	#  RW: MAC Speed: 10/100/1000 Mbps, Values: 0=10M, 1=100M, 2=1G, 2 bits per port
C_ADDR_NET_ENABLE="0x4010"    	#  RW: RX MAC Enable (by default disabled), one bit per port
C_ADDR_NET_SPEED="0x4014"    	#  RW: MAC Speed: 10/100/1000 Mbps, Values: 0=10M, 1=100M, 2=1G, 2 bits per port
C_ADDR_NET_DUPLEX="0x4018"    	#  RW: MAC Duplex: 0=Full Duplex, 1=Half Duplex, one bit per port @todo To be implemented
C_ADDR_NET_PAUSE="0x401C"    	#  RW: RX MAC PAUSE Enable, one bit per port
C_ADDR_NET_LINK="0x4020"    	#  WO: PHY signals link up
C_ADDR_NET_OWN_MAC_ADDR_L="0x4024"    	#  WO: lower 32Bit of our own MAC Address
C_ADDR_NET_OWN_MAC_ADDR_H="0x4028"    	#  WO: upper Bits of our own MAC Address
C_ADDR_NET_PORT_ISOLATION="0x402C"    	#  WO: MAC address per port instead of shared MAC address
C_ADDR_NET_6T_ADDR_L="0x4030"    	#  WO: lower 32Bit of 6T Addr
C_ADDR_NET_6T_ADDR_H="0x4034"    	#  WO: upper Bits of 6T Addr
C_ADDR_NET_6T_SRC_PTR="0x4038"    	#  WO: Index in 6T Addr
C_ADDR_NET_6T_DST_PTR="0x403C"    	#  WO: Index in 6T addr
C_ADDR_NET_TX_CONF_VLD="0x4040"    	#  RO: Currently active TX confirmation results  one bit per port
C_ADDR_NET_TX_CONF_L="0x4050"    	#  RO: Lower bound of the memorymapped TX confirmation result memory, consisting of one word Confirmation ID, followed by one word confirmation timestamp. Entry is cleared on reading the timestamp
C_ADDR_NET_TX_CONF_H="0x40CC"    	#  RO: Upper bound
C_ADDR_NET_TX_CONF_H="0x40CC"    	#  rtc_mmi
C_ADDR_RTC_BRIDGE_LOW="0x4000"    	#  RO: Lower 32 bits of current bridge clock value. Reading samples bridge and controlled clock
C_ADDR_RTC_BRIDGE_HIGH="0x4004"    	#  RO: Upper 32 bits of sampled bridge clock value
C_ADDR_RTC_CTRLD_LOW="0x4008"    	#  RO: Lower 32 bits of sampled controlled clock value
C_ADDR_RTC_CTRLD_HIGH="0x400C"    	#  RO: Upper 32 bits of sampled controlled clock value
C_ADDR_RTC_CTRLD_OFFSET_LOW="0x4010"    	#  WO: Lower 32 bits of controlled clock offset [ns]: at which offset should the clock have started at reset?
C_ADDR_RTC_CTRLD_OFFSET_HIGH="0x4014"    	#  WO: Upper 32 bits of controlled clock offset [ns]. Writing this activates the new lower and higher part
C_ADDR_RTC_CTRLD_RATE="0x4018"    	#  WO: Controlled clock rate (upper 8 bits are [ns], lower 24 bits are subns): how much to be added every 5 ns?
C_ADDR_RTC_INTERRUPT="0x401C"    	#  RO: Address for RTC interrupts, COR: at least one of the internal counters lapsed
C_ADDR_RTC_INTERRUPT_EN="0x4020"    	#  RW: Address for RTC interrupt mask
C_ADDR_RTC_CLKSEL="0x4024"    	#  WO: Clock selection for the TAS: 0=free running/bridge clock, 1=controlled clock
C_ADDR_RTC_SEC_START_L="0x4028"    	#  UNUSED
C_ADDR_RTC_SEC_START_H="0x402C"    	#  UNUSED
C_ADDR_RTC_SEC_START="0x402C"    	#  UNUSED
C_ADDR_RTC_SEC_START="0x402C"    	#  sample_event_mmi
C_ADDR_PPS_INTERRUPT="0x4000"    	#  RO: Address for PPS interrupt
C_ADDR_PPS_INTERRUPT_EN="0x4004"    	#  RW: Address for PPS interrupt mask
C_ADDR_PPS_CTRLD_LOW="0x4008"    	#  RO: Lower 32 bits of sampled controlled clock value
C_ADDR_PPS_CTRLD_HIGH="0x400C"    	#  RO: Upper 32 bits of sampled controlled clock value
C_ADDR_PPS_SAMPLE_VAL="0x4010"    	#  RO: Value of event input after the change
C_ADDR_HC_CNT_BAD_FRAMES="0x4000"    	#  RO, COR
C_ADDR_HC_INTERRUPT="0x4004"    	#  RO, COR
C_ADDR_HC_INTERRUPT_EN="0x4008"    	#  RW
C_ADDR_HC_DEFAULT_FLOWID="0x400C"    	#  WO @TODO No effect as long as flow_cache_lib.priority_encoder overrides this
C_ADDR_HC_DEFAULT_CUT_THROUGH="0x4010"    	#  WO
C_ADDR_HC_CNT_HT_DROP_FRAMES="0x4014"    	#  RO, COR
C_ADDR_HC_CNT_HT_DROP_FRAMES="0x4014"    	#  user_module_mmi
C_ADDR_USER_MOD_MMI_ID="0x4000"    	#  RO: Address for "unique" pattern
C_ADDR_USER_MOD_MMI_BEEP_EN="0x4004"    	#  WO: Address to enable beeping
C_ADDR_USER_MOD_MMI_DISPLAY_EN="0x4008"    	#  WO: Address to enable display dots
C_ADDR_USER_MOD_MMI_DISPLAY_EN="0x8908"    	#  WO: Action table  Has to be a multiple of 4, better a multiple of 0x100
C_ADDR_USER_MOD_MMI_DISPLAY_EN="0x8A08"    	#  WO: Action table  Has to be a multiple of 4, better a multiple of 0x100
C_ADDR_USER_MOD_MMI_DISPLAY_EN="0x9008"    	#  WO: EMH hash table
C_ADDR_USER_MOD_MMI_DISPLAY_EN="0xB008"    	#  WO: EMH rules table  Should be a multiple of 0x1000
C_ADDR_USER_MOD_MMI_DISPLAY_EN="0xC008"    	#  WO: EMH linear search  Has to be a multiple of 4, better a multiple of 0x100
C_ADDR_USER_MOD_MMI_DISPLAY_EN="0xC008"    	#  WO: General FlowCache configuration
C_ADDR_FLOW_CACHE_ENABLE="0xC000"    	#  WO: Enable or disable parts of the FlowCache
C_ADDR_FLOW_CACHE_HASH_ID="0xC004"    	#  RO: Identifier for the hashes used
C_ADDR_FLOW_CACHE_RULE_SET="0xC008"    	#  RW: Hardware Variable for Hashing
C_ADDR_FLOW_CACHE_PTP_QUEUE="0xC00C"    	#  WO: PTP Queue selection via MMI
C_ADDR_FLOW_CACHE_VLAN_INT_LOWER="0xC040"    	#  WO: Lower limit of internal VLANs > Port 0 (has to be a multiple of 0x40)
C_ADDR_FLOW_CACHE_VLAN_INT_UPPER="0xC07C"    	#  WO: Upper limit of internal VLANs > Port 15 (has to be a multiple of 0x40  4)
C_ADDR_FLOW_CACHE_VLAN_INT_UPPER="0xD07C"    	#  mmi_tm
C_ADDR_FLOW_CACHE_VLAN_INT_UPPER="0xD07C"    	#  mmi_tm
C_ADDR_TM_RESOURCE_LIMIT_LOWER="0xD00000"    	#  WO: Resource limit per flow in segment buffers (64 Bytes of frame data, without FCS)
C_ADDR_TM_RESOURCE_LIMIT_UPPER="0xD007FF"    	#  WO: Resource limit per flow in segment buffers (64 Bytes of frame data, without FCS)
C_ADDR_TM_DROP_CNT_LOWER="0xD00800"    	#  WO: TM Drop Counters  start
C_ADDR_TM_DROP_CNT_UPPER="0xD00FFF"    	#  WO: TM Drop Counters  end
C_ADDR_TM_QUEUE_THRES_FULL="0xD01000"    	#  RW: Queue thresholds @todo could be WO
C_ADDR_TM_RX_BUF_AVAIL="0xD01004"    	#  RO: Buffer available per RXDP/TXDP combination
C_ADDR_TM_PTR_CNT="0xD01008"    	#  RO: no. of pointers in use in the buffer.  UNUSED
C_ADDR_TM_EN_MAX_TRANSIT_DELAY="0xD0100C"    	#  WO: Enable/Disable Drop Jobs (1 second transit delay)
C_ADDR_TM_DBG="0xD01010"    	#  RO, COR: Debug signals from TM units
C_ADDR_TM_DBG="0xD21010"    	#  scheduler_tas
C_ADDR_TM_DBG="0xD21010"    	#  scheduler_tas
C_ADDR_C_BLOCK_SIZE_ADDR_TM_SCHED="0xD2800"    	#  The size of the TM_SCHED address space assigned as a block to each port @todo rename to C_SUB_ADDR_TM_SCHED_BLOCK_SIZE_ADDR  UNUSED
C_ADDR_TM_SCHED_TAS_CONFIG_REG_LOWER="0xD2400"    	#  see below
C_ADDR_TM_SCHED_PROC_QUEUE_PRIO_LOWER="0xD2500"    	# UNUSED
C_ADDR_TM_SCHED_PROC_QUEUE_PRIO_UPPER="0xD253C"    	# UNUSED
C_ADDR_TM_SCHED_PROC_QUEUE_PRIO_HIGH="0xD2540"    	# UNUSED   if '1' proc queues have higher priority than physical queues for this port
C_ADDR_TM_SCHED_TAS_CUR_TIME="0xD2544"    	#  readonly/debugonly: current time seen by the TAS, to be replaced by a clock (PTP or other)  UNUSED
C_ADDR_TM_SCHED_TAS_ADMIN_BASE_TIME="0xD2404"    	#  C_TSN_TIME_WIDTH
C_ADDR_TM_SCHED_TAS_ADMIN_CYCLE_TIME="0xD2408"    	#  C_TSN_TIME_WIDTH
C_ADDR_TM_SCHED_TAS_ADMIN_CYCLE_TIME_EXT="0xD240C"    	#  C_TSN_TIME_WIDTH
C_ADDR_TM_SCHED_TAS_ADMIN_GATE_STATES="0xD2438"    	#  8 bit default gate state
C_ADDR_TM_SCHED_TAS_ADMIN_GCL_LEN="0xD2400"    	#  7 bit reg
C_ADDR_TM_SCHED_TAS_CONFIG_CHANGE="0xD241C"    	#  one bit indicator, enable config change
C_ADDR_TM_SCHED_TAS_CONFIG_CHANGE_PENDING="0xD2420"    	#  RO: one bit indicator, pending config change
C_ADDR_TM_SCHED_TAS_CONFIG_CHANGE_TIME="0xD2410"    	#  C_TAS_TIME_WIDTH
C_ADDR_TM_SCHED_TAS_GATE_ENABLE="0xD2418"    	#  one bit indicator, enable/disable TAS for port
C_ADDR_TM_SCHED_TAS_OPER_BASE_TIME="0xD242C"    	#  C_TAS_TIME_WIDTH read only
C_ADDR_TM_SCHED_TAS_OPER_CYCLE_TIME="0xD2430"    	#  C_TAS_TIME_WIDTH read only
C_ADDR_TM_SCHED_TAS_OPER_CYCLE_TIME_EXT="0xD2434"    	#  C_TAS_TIME_WIDTH read only
C_ADDR_TM_SCHED_TAS_OPER_GATE_STATES="0xD243C"    	#  8 bit default gate state
C_ADDR_TM_SCHED_TAS_OPER_GCL_LEN="0xD2428"    	#  7 bit reg read only
C_ADDR_TM_SCHED_TAS_CYCLE_START_TIME="0xD2414"    	#  C_TAS_TIME_WIDTH
C_ADDR_TM_SCHED_TAS_CONFIG_CHANGE_ACK="0xD2424"    	#  read only ack
C_ADDR_SCHED_TAS_ADMIN_BASE_TIME="0xD2404"    	#  R/W     8.6.9.4.1  Software has to set a value at least AdminCycleTime in the future + ~1 ms and less than 2 seconds in the future
C_ADDR_SCHED_TAS_ADMIN_CYCLE_TIME="0xD2408"    	#  R/W     8.6.9.4.3  Software has to break down the rational number to a value in [ns]
C_ADDR_SCHED_TAS_ADMIN_CYCLE_TIME_EXTENSION="0xD240C"    	#  R/W     8.6.9.4.4  Software has to make sure that AdminCycleTime+AdminCycleTimeExtension never produces a _31_ bit integer overflow
C_ADDR_SCHED_TAS_ADMIN_GATE_STATES="0xD2438"    	#  R/W     8.6.9.4.5
C_ADDR_SCHED_TAS_ADMIN_CONTROL_LIST_LENGTH="0xD2400"    	#  R/W     8.6.9.4.6  only lower bits are considered by hardware  software has to make sure that no bigger number is configured
C_ADDR_SCHED_TAS_CONFIG_CHANGE="0xD241C"    	#  R/W     8.6.9.4.7
C_ADDR_SCHED_TAS_CONFIG_PENDING="0xD2420"    	#  RO      8.6.9.4.8
C_ADDR_SCHED_TAS_CONFIG_CHANGE_TIME="0xD2410"    	#  RO      8.6.9.4.9
C_ADDR_SCHED_TAS_CONFIG_CHANGE_ERROR="0xD2440"    	#  RO, COR Without number  Software has to aggregate to 64 bits
C_ADDR_SCHED_TAS_GATE_ENABLED="0xD2418"    	#  R/W     8.6.9.4.14
C_ADDR_SCHED_TAS_OPER_BASE_TIME="0xD242C"    	#  RO      8.6.9.4.18
C_ADDR_SCHED_TAS_OPER_CYCLE_TIME="0xD2430"    	#  RO      8.6.9.4.20  Software has to convert the [ns] value back to a rational number
C_ADDR_SCHED_TAS_OPER_CYCLE_TIME_EXTENSION="0xD2434"    	#  RO      8.6.9.4.21
C_ADDR_SCHED_TAS_OPER_GATE_STATES="0xD243C"    	#  RO      8.6.9.4.22
C_ADDR_SCHED_TAS_OPER_CONTROL_LIST_LENGTH="0xD2428"    	#  RO      8.6.9.4.23
C_ADDR_SCHED_TAS_GCL_MEM_GATES="0xD2000"    	#  R/W     8.6.9.4.2
C_ADDR_SCHED_TAS_GCL_MEM_TIMES="0xD2200"    	#  R/W     8.6.9.4.2  Software has to make sure that no TimeInverval is > 2 seconds (better < 1 second)
C_ADDR_TM_SCHED_TAS_TICK_GRANULARITY="0xD2444"    	#  TAS Tick Granularity
