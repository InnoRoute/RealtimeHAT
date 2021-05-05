#!/bin/bash -e
pip3 install pyrpio==0.0.5
pip3 install wiringpi
pip3 install goto-statement
pip3 install rt-hat-inr
git clone https://github.com/openil/linuxptp.git
cd linuxptp/
git checkout OpenIL-v1.8.1-202009 
sed -i "/\/usr\/local/cprefix	= \/usr" makefile
sed -i "/if (setsockopt(fd, SOL_SOCKET, SO_BINDTODEVICE, name, strlen(name))) {/cint socket_priority=1;setsockopt(fd, SOL_SOCKET, SO_PRIORITY, &socket_priority,sizeof(socket_priority));if (setsockopt(fd, SOL_SOCKET, SO_BINDTODEVICE, name, strlen(name))) {" raw.c
make -j4
sudo make install
cd ..
sudo rm -r linuxptp
sudo update-ca-certificates
sudo c_rehash

