#!/bin/bash
## Enable driver
echo 1 | sudo tee /proc/InnoRoute/RT_enable

## Load bitstream:
#sudo i2cset -y 1 0x43 0x11 0xff # Disable all interrupts
sudo i2cset -y 1 0x43 0x0B 0x00 # No Pulls
sudo i2cset -y 1 0x43 0x07 0xFB # All High-Z, except for PROGRAM_B
sudo i2cset -y 1 0x43 0x03 0x04 # Only PROGRAM_B is Output
sudo i2cset -y 1 0x43 0x05 0x04 # Output 1 on PROGRAM_B
sleep 0.01
sudo i2cset -y 1 0x43 0x05 0x00 # Output 0 on PROGRAM_B
sleep 0.01
sudo i2cset -y 1 0x43 0x05 0x04 # Output 1 on PROGRAM_B
sudo i2cget -y 1 0x43 15
# Continue only, if 0x08
sudo dd if=/usr/share/InnoRoute/selftest.bit of=/proc/InnoRoute/SPI_file bs=128 status=progress # Multiples of 32 bits
sudo i2cget -y 1 0x43 15
# Completed, if 0x18
# Debugging: 0x00 -> INIT_B=Low: Error
# Debugging: 0x08 -> INIT_B=HIGH: Programming did not complete -> Timeout?

## Reset sequence for PHYs
sudo /usr/share/InnoRoute/INR2spi 0x0F0C1800 0
sudo /usr/share/InnoRoute/INR2spi 0x0F0C1900 0
sudo /usr/share/InnoRoute/INR2spi 0x0F0C1900 2048
sleep 2

## Running adapted MDIO script, with pins (4, 17)
echo "testing MDIO..."
sudo python3 /usr/share/InnoRoute/mdio_test.py

## Read all SPI registers:
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
