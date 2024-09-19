#!/bin/bash
# ulbricht@innoroute.de 2021
echo -e "\033[0;32mThank's for running the install script."
#echo "The setup on top of an custom raspberry-image will be available soon."
#echo "Please download a full image from https://my.hidrive.com/share/3ugldbuowd for now"
echo "This script will install additional software and a custom kernel to your raspberryPI system."
echo "The script is tested on current RaspberryOS minimal image. Your root password might be requested."
echo -e "You run this script on own responsibility InnoRoute is not responsible for any dataloss.\033[0m"
read -p "Continue (y/n)?" CONT
if [ "$CONT" = "y" ]; then
  echo "ok, lets start...";
else
  echo "ok, good bye"
  exit 1
fi
echo -e "\033[0;32minstall recomented packages\033[0m"
sudo apt update
sudo apt install -y $(cat packages/deb.txt)

#wiringpi
wget https://github.com/WiringPi/WiringPi/releases/download/3.10/wiringpi_3.10_armhf.deb
sudo apt install ./wiringpi_3.10_armhf.deb
sudo apt install ./wiringpi_3.10_armhf.deb


chmod +x packages/other.sh
sudo packages/other.sh
echo -e "\033[0;32minstalling InnoRoute scripts\033[0m"
sudo mkdir -p /usr/share/InnoRoute
sudo chown pi /usr/share/InnoRoute
cp -v -r scripts/* /usr/share/InnoRoute/
sudo ln -s /usr/share/InnoRoute/check_bitstream.sh /etc/profile.d/check_bitstream.sh
sudo cp -v -r init.d/* /etc/init.d/
sudo chmod +x /etc/init.d/INR*
echo -e "\033[0;32mconfigure wlan route metric\033[0m"
echo -e "interface wlan0\nmetric 2"| sudo tee -a /etc/dhcpcd.conf
echo -e "\033[0;32menable autostart scripts\033[0m"
sudo update-rc.d INR_FPGA_load defaults
echo -e "\033[0;32minstall custom kernel\033[0m"
tar xfv kernel/kernel.tar.gz
sudo cp -v -r output/boot/* /boot/firmware/
sudo cp -v -r output/ext4/lib/modules/* /lib/modules/
sudo depmod
echo -e "\033[0;32menable modules\033[0m"
cat packages/modules.txt | sudo tee -a /etc/modules
echo -e "\033[0;32mmodify config.txt\033[0m"
cat boot/config.txt | sudo tee -a /boot/firmware/config.txt
echo -e "\033[0;32mcopy devicetree overlay\033[0m"
sudo cp boot/*.dtbo /boot/firmware/overlays/
echo -e "\033[0;32mcleanup\033[0m"
sudo rm -r output
echo -e "\033[0;32mrebooting...\033[0m"
sudo reboot
