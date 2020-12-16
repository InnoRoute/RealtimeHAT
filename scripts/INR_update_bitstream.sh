#!/bin/bash
echo "loading selftest bitstream..."
/usr/share/InnoRoute/INR_write_bitstream /usr/share/InnoRoute/selftest.bit
echo "get device ID..."
ID_0=$(sudo /usr/share/InnoRoute/INR2spi 0x3C0C0200|cut -d 'x' -f2)
ID_1=$(sudo /usr/share/InnoRoute/INR2spi 0x3C0C0300|cut -d 'x' -f2)
ID="$ID_0$ID_1"
echo "DEVICE_ID:$ID"
sudo wget https://raw.githubusercontent.com/InnoRoute/RT-HAT-FPGA/main/HAT/$ID.conf -O /usr/share/InnoRoute/bs_info_new.conf || exit 1
source /usr/share/InnoRoute/bs_info.conf
old_bs=$BS_repo_hash
source /usr/share/InnoRoute/bs_info_new.conf
echo "new bitstream hash:$BS_repo_hash"
if [ "$BS_repo_hash" = "$old_bs" ]; then
    echo "the actual bitstream is already installed... exiting"
    exit 0
fi
sudo mv /usr/share/InnoRoute/bs_info_new.conf /usr/share/InnoRoute/bs_info.conf
sudo wget $BS_file -O /usr/share/InnoRoute/user_bitstream.bit || exit 1
echo "loading new bitstream..."
/usr/share/InnoRoute/INR_write_bitstream /usr/share/InnoRoute/user_bitstream.bit

