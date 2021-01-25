#!/bin/bash
## Enable driver
echo 1 | sudo tee /proc/InnoRoute/RT_enable

## Load bitstream:
echo "flashing FPGA via SPI..."
/usr/share/InnoRoute/INR_write_bitstream  /usr/share/InnoRoute/selftest.bit || exit 1
echo "FPGA successfully programmed"
## Running adapted MDIO script, with pins (4, 17)
echo "configuring PHYs via MDIO..."
sudo /usr/share/InnoRoute/INR2spi 0x0f0C1700 0x3 #C_SUB_ADDR_SPI_RESET=3
sleep 2
sudo python3 /usr/share/InnoRoute/phy_mdio.py >/dev/null

## Read all SPI registers:
echo "read FPGA status via SPI..."
for i in `seq 0 26`; do
  case "$i" in
    0 ) printf "BOARD_REV/EFUSE";;
    1 ) printf "FPGA_TEMP      ";;
    2 ) printf "FPGA_ID0       ";;
    3 ) printf "FPGA_ID1       ";;
    4 ) printf "BITGEN_TIME    ";;
    5 ) printf "FPGA_REV+AM+UC ";;
    6 ) printf "FEATURE_MAP    ";;
    8 ) printf "INT_PENDING    ";;
    9 ) printf "INT_STATUS     ";;
    10) printf "INT_SET_EN     ";;
    11) printf "INT_CLR_EN     ";;
    12) printf "FPGA_ALARM     ";;
    13) printf "CONFIG_CHECK   ";;
    14) printf "LICENSE        ";;
    15) printf "ACCESS_ERROR   ";;
    16) printf "FIFO_OVERFLOW  ";;
    17) printf "FIFO_UNDERRUN  ";;
    18) printf "EXT_INTERRUPT  ";;
    19) printf "EVENT          ";;
    20) printf "MMI_INT_BITMAP ";;
    21) printf "BACKPRESSURE   ";;
    23) printf "RESET          ";;
    24) printf "TEST_DRIVE (WO)";;
    25) printf "TEST_VALUE (WO)";;
    26) printf "TEST_INPUT     ";;
    *)  printf "# Undefined #  ";;
  esac;
  # All local reads -> CMD=0x3C, BASE=0x0C0000
  printf "0x3C0C%02x00: " $i;
  sudo /usr/share/InnoRoute/INR2spi `printf "0x3C0C%02x00" $i`;
done;
