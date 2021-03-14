#!/bin/bash
## Enable driver
echo 1 | sudo tee /proc/InnoRoute/RT_enable

## Load bitstream:
echo "flashing FPGA via SPI..."
/usr/share/InnoRoute/INR_write_bitstream  /usr/share/InnoRoute/selftest.bit || exit 1
echo "FPGA successfully programmed"


## Read all SPI registers:
/usr/share/InnoRoute/INR_fpga_status.sh
## network testing
echo "testing network..."
echo "For the network test, you will need two (short) ethernet cables."
echo "Connect Port#0 and Port#2 of your Realtime-HAT."
echo "Connect Port#1 of your Realtime-HAT to the RaspberryPI."
read -p "Continue (y/n)?" CONT
if [ "$CONT" = "y" ]; then
  echo "ok, lets start...";
else
  echo "ok, good bye"
  exit 0
fi

echo "generating traffic..."
sudo timeout 60 tcpdump -c100 -i eth0 ether proto 0x0666 | grep "ethertype" > dump.txt&
sleep 10
sudo mz eth0 -c110  -d 100m -A rand  -a rand -b rand  -p 100 "06:66"
wait
echo "searching for transmission errors"
pkgcount=$(cat dump.txt | cut -d ' ' -f2,6 | sort | uniq -c | sed  -e 's/[ \t]*//' | cut -d ' ' -f1 | grep 2 | wc -l  )
rm dump.txt
if [ $pkgcount -eq 50 ]
    then
        echo "Network test successfull :)"
        
    else
        echo "Network test  not successfull :("
        exit 1
fi
exit 0
