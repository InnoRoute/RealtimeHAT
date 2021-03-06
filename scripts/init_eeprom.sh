#!/bin/bash
echo "flashing the eeprom two times, please answer with 'yes'"
sleep 1
sudo /usr/share/InnoRoute/eepflash.sh -w -f=/usr/share/InnoRoute/blank.eep  -t=24c32 -a=50
sudo /usr/share/InnoRoute/eepflash.sh -w -f=/usr/share/InnoRoute/RTH_eeprom.eep  -t=24c32 -a=50
sudo /usr/share/InnoRoute/eepflash.sh -r -f=eeprom_dump.eep  -t=24c32 -a=50
hexdump -C eeprom_dump.eep
sudo rm eeprom_dump.eep

