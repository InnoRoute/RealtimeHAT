#!/bin/bash
# ulbricht@innoroute.de 2021
echo -e "\033[0;32mThis script will update your current RealTime-Hat environment."
echo "The script is tested on current RaspberryOS minimal image. Your root password might be requested."
echo -e "You run this script on own responsibility InnoRoute is not responsible for any dataloss.\033[0m"
read -p "Continue (y/n)?" CONT
if [ "$CONT" = "y" ]; then
  echo "ok, lets start...";
else
  echo "ok, good bye"
  exit 1
fi
git pull
sudo rm -r /usr/share/InnoRoute
sudo rm -r /lib/modules/5.4.44-v7l+ 
chmod +x install.sh
yes|./install.sh

