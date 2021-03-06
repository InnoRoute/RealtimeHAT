#!/bin/bash
source /usr/share/InnoRoute/hat_env.sh


sleep 30
MAC_addr=$(cat /sys/class/net/eth0/address)
MAC_RT0=$(awk 'BEGIN{FS=OFS=":";$0=ARGV[1];$NF=sprintf("%X",("0x"$NF)-1);print}' $MAC_addr)
MAC_RT2=$(awk 'BEGIN{FS=OFS=":";$0=ARGV[1];$NF=sprintf("%X",("0x"$NF)-1);print}' $MAC_RT0)
sudo ifconfig wlan0 mtu 1500
echo "loading userbitstream"
/usr/share/InnoRoute/INR_write_bitstream /usr/share/InnoRoute/user_bitstream.bit 
ID_0=$(sudo /usr/share/InnoRoute/INR2spi 0x3C0C0200)
ID_0=$(printf "%d\n" $ID_0)
if [ "$ID_0" -gt "0" ];then #if bitstream load successfully load driver for hat
    sudo rmmod INR_RTHAT
    sleep 1
    sudo modprobe INR_RTHAT
    sleep 1
    sudo /usr/share/InnoRoute/INR2spi $C_ADDR_SPI_INT_STATUS 0x3ff
    sleep 1
    sudo ifconfig RT0 down
    sudo ifconfig RT2 down
    sudo ifconfig RT0 mtu 1400
    sudo ifconfig RT2 mtu 1400
    sudo ifconfig RT0 hw ether $MAC_RT0
		sudo ifconfig RT2 hw ether $MAC_RT2
		sudo chmod a+rw /proc/InnoRoute/SPI_read
		sudo chmod a+rw /proc/InnoRoute/SPI_write
		sudo chmod a+rw /proc/InnoRoute/SPI_data
    sudo ifconfig RT0 up
    sudo ifconfig RT2 up
    sudo /usr/share/InnoRoute/INR2spi $C_ADDR_SPI_INT_STATUS 0x3ff
    sleep 1
		sudo /usr/share/InnoRoute/INR2spi $C_ADDR_SPI_INT_STATUS 0x3ff
		sudo service systemd-timesyncd stop 
		sudo killall ptp4l
		sudo killall phc2sys
		sudo ptp4l -q  -i RT0 -f /usr/share/InnoRoute/ptp.conf &
		sudo phc2sys -a -r --transportSpecific 0x1 &
    
    
    
    
    
else
    sudo rmmod INR_RTHAT
fi



