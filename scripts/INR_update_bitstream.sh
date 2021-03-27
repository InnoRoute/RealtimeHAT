#!/bin/bash
echo "loading selftest bitstream..."
sudo chmod -R a+wr /usr/share/InnoRoute
/usr/share/InnoRoute/INR_write_bitstream /usr/share/InnoRoute/selftest.bit
echo "get device ID..."
ID_0=$(sudo /usr/share/InnoRoute/INR2spi 0x3C0C0200|cut -d 'x' -f2)
ID_1=$(sudo /usr/share/InnoRoute/INR2spi 0x3C0C0300|cut -d 'x' -f2)
ID="$ID_1$ID_0"
echo "DEVICE_ID:$ID"
sudo wget https://raw.githubusercontent.com/InnoRoute/RT-HAT-FPGA/main/HAT/$ID.conf -O /usr/share/InnoRoute/bs_info_new.conf || exit 1
source /usr/share/InnoRoute/bs_info.conf
old_bs=$BS_repo_hash
source /usr/share/InnoRoute/bs_info_new.conf
echo "new bitstream hash:$BS_repo_hash"
if [ "$BS_repo_hash" = "$old_bs" ]; then
		sudo rm /usr/share/InnoRoute/bs_info_new.conf
    echo "the actual bitstream is already installed..."
    echo "loading old bitstream..."
		/usr/share/InnoRoute/INR_write_bitstream /usr/share/InnoRoute/user_bitstream.bit
    exit 0
fi
sudo mv /usr/share/InnoRoute/bs_info_new.conf /usr/share/InnoRoute/bs_info.conf
cat /usr/share/InnoRoute/bs_info.conf | grep "C_ADDR_" >/usr/share/InnoRoute/hat_env.sh
sudo wget $BS_file -O /usr/share/InnoRoute/user_bitstream.bit || exit 1
echo "loading new bitstream..."
/usr/share/InnoRoute/INR_write_bitstream /usr/share/InnoRoute/user_bitstream.bit
ID_0=$(sudo /usr/share/InnoRoute/INR2spi 0x3C0C0200)
ID_0=$(printf "%d\n" $ID_0)
if [ "$ID_0" -gt "0" ];then #if bitstream load successfully load driver for hat
    sudo modprobe INR_RTHAT
else
    sudo rmmod INR_RTHAT
fi

