#!/bin/bash
# ulbricht@innoroute.de 2021
echo -e "\033[0;32m Thank's for running the install script."
#echo "The setup on top of an custom raspberry-image will be available soon."
#echo "Please download a full image from https://my.hidrive.com/share/3ugldbuowd for now"
echo "This script will install additional software and a custom kernel to your raspberryPI system."
echo "The script is tested on current RaspberryOS minimal image. Your root password might be requested."
echo -e "You run this script on own responsibility InnoRoute is not responsible for any dataloss.\033[0;30m"
read -p "Continue (y/n)?" CONT
if [ "$CONT" = "y" ]; then
  echo "ok, lets start...";
else
  echo "ok, good bye"
  exit 1
fi
echo -e "\033[0;32m install recomented packages\033[0m"
sudo apt update
sudo apt install -y $(cat packages/deb.txt)
chmod +x packages/other.sh
sudo packages/other.sh
echo -e "\033[0;32m installing InnoRoute scripts\033[0m"
sudo mkdir -p /usr/share/InnoRoute
sudo chown pi /usr/share/InnoRoute
cp -v -r scripts/* /usr/share/InnoRoute/
echo -e "\033[0;32m install custom kernel\033[0m"
tar xfv kernel/kernel.tar.gz
sudo cp -v -r output/boot/* /boot/
sudo cp -v -r output/ext4/lib/modules/* /lib/modules/
sudo depmod
echo -e "\033[0;32m enable modules\033[0m"
cat packages/modules.txt | sudo tee -a /etc/modules
echo -e "\033[0;32m modify config.txt\033[0m"
cat boot/config.txt | sudo tee -a /boot/config.txt
echo -e "\033[0;32m copy devicetree overlay\033[0m"
sudo cp boot/*.dtbo /boot/overlays/
