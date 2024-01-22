#!/bin/bash
source /usr/share/InnoRoute/hat_env.sh
source /usr/share/InnoRoute/rt_hat.conf
echo " _____            _ _   _                  _____  _____ _____   "
echo " |  __ \          | | | (_)                |  __ \|  __ \_   _|"
echo " | |__) |___  __ _| | |_ _ _ __ ___   ___  | |__) | |__) || |  "
echo " |  _  // _ \/ _° | | __| | |_ ° _ \ / _ \ |  _  /|  ___/ | |  "
echo " | | \ \  __/ (_| | | |_| | | | | | |  __/ | | \ \| |    _| |_ "
echo " |_|  \_\___|\__,_|_|\__|_|_| |_| |_|\___| |_|  \_\_|   |_____|"
ID_0=$(sudo /usr/share/InnoRoute/INR2spi 0x3C0C0200)
ID_0=$(printf "%d\n" $ID_0)
if [ "$ID_0" -gt "0" ];then #if bitstream load successfully load driver for hat
    ref=$(sudo /usr/share/InnoRoute/INR2spi $C_ADDR_SPI_FPGA_REV )
    if (( (ref & 0x8000) == 0x8000 ))
                then
                        echo "The FPGA was loaded with an test-bitstream. Expect everything, but no support ;)"
                fi    
else
    echo "FPGA bitstream not loaded"
fi
echo "rthat network mode=$rthat_network_mode"
echo "6tree prefix=$rthat_sixtreeprefix"
grep -q -F "127.0.0.1  $(cat /etc/hostname)" /etc/hosts
if [ $? -ne 0 ]; then
  echo "127.0.0.1  $(cat /etc/hostname)" | sudo tee -a /etc/hosts
fi
test -f /usr/share/InnoRoute/TSNA_bringup && sudo /usr/share/InnoRoute/TSNA_bringup

                                                               
                                                               


