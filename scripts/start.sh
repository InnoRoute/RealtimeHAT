#!/bin/bash
source /usr/share/InnoRoute/hat_env.sh
source /usr/share/InnoRoute/rt_hat.conf



#sudo systemctl start AutoTSN
#sudo systemctl enable AutoTSN
sleep 3
sudo rmmod brcmfmac
sudo modprobe brcmfmac roamoff=1 feature_disable=0x82000 # fix wifi connection issue
MAC_addr=$(cat /sys/class/net/eth0/address)
MAC_RT0=$(awk 'BEGIN{FS=OFS=":";$0=ARGV[1];$NF=sprintf("%X",("0x"$NF)-1);print}' $MAC_addr)
MAC_RT2=$(awk 'BEGIN{FS=OFS=":";$0=ARGV[1];$NF=sprintf("%X",("0x"$NF)-1);print}' $MAC_RT0)
sudo ifconfig wlan0 mtu 1500
echo "loading userbitstream"
test -f /usr/share/InnoRoute/TSNA_bringup || /usr/share/InnoRoute/INR_write_bitstream /usr/share/InnoRoute/user_bitstream.bit 
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
    if [ $rthat_network_mode -eq 1 ] #bridge mode
    then
		  sudo brctl addbr br0
		  sudo brctl addif br0 RT0
		  sudo brctl addif br0 RT2
		  sudo ifconfig br0 up
		  sudo dhclient br0
    fi
    if [ $rthat_network_mode -eq 2 ]  #6tree mode
    then
			sudo ifconfig RT2 inet6 add ${rthat_sixtreeprefix}::2/64
			sudo ip -6 route del  ${rthat_sixtreeprefix}::/64 dev wg6t
			sudo /etc/init.d/radvd start
    fi
    sudo /usr/share/InnoRoute/INR2spi $C_ADDR_SPI_INT_STATUS 0x3ff
    sleep 1
		sudo /usr/share/InnoRoute/INR2spi $C_ADDR_SPI_INT_STATUS 0x3ff
		sudo service systemd-timesyncd stop 
		sudo systemctl start ptp4l
		sudo systemctl start phc2sys

    
    
    
    
    
else
    sudo rmmod INR_RTHAT
fi



