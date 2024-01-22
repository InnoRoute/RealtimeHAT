#!/bin/bash
if [[ $EUID -ne 0 ]]; then
    echo "$0 is not running as root. Try using sudo."
    exit 2
fi
test -f /home/pi/autoupdate.zip || echo "No update file available, provide /home/pi/autoupdate.zip"
test -f /home/pi/autoupdate.zip || exit 1
echo "timer" > /sys/class/leds/led0/trigger 
echo "200" > /sys/class/leds/led0/delay_on 
echo "200" > /sys/class/leds/led0/delay_off 
echo "timer" > /sys/class/leds/master/trigger 
echo "200" > /sys/class/leds/master/delay_on 
echo "200" > /sys/class/leds/master/delay_off 
cp /usr/share/InnoRoute/selfupdate_file /etc/initramfs-tools/hooks/selfupdate_file
chmod +x /etc/initramfs-tools/hooks/selfupdate_file
cp /usr/share/InnoRoute/selfupdate_run  /etc/initramfs-tools/scripts/local-premount/selfupdate_run
chmod +x /etc/initramfs-tools/scripts/local-premount/selfupdate_run
sudo rm -f /boot/initrd.img-$(uname -r)
sudo update-initramfs -c -k $(uname -r)
echo "initramfs initrd.img-$(uname -r)">>/boot/config.txt
reboot

