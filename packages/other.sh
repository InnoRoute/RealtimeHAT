#!/bin/bash -e
pip3 install pyrpio==0.0.5 --break-system-packages
pip3 install --upgrade wiringpi --break-system-packages
pip3 install --upgrade goto-statement --break-system-packages
pip3 install --upgrade rt-hat-inr --break-system-packages
pip3 install --upgrade flask --break-system-packages
#pip3 install sysrepo
#linuxptp
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
#wget https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/snapshot/iproute2-5.13.0.tar.gz
#tar xf iproute2-5.13.0.tar.gz
#cd iproute2-5.13.0
#./configure
#make -j4
#sudo make install

