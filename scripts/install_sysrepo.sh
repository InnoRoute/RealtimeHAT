#libyang
cd /home/pi/
sudo apt -y install libpcre3-dev libssh-dev libpcre2-dbg libpcre2-dev cmake 
sudo ldconfig
git clone https://github.com/CESNET/libyang.git
cd libyang
mkdir build
cd build
cmake ..
make -j4
sudo make install
cd ../..
rm -rf libyang
sudo ldconfig
#sysrepo
git clone https://github.com/sysrepo/sysrepo.git
cd sysrepo
mkdir build
cd build
cmake ..
make -j4
sudo make install
cd ../..
rm -rf sysrepo
sudo ldconfig
#linbetconf2
git clone  https://github.com/CESNET/libnetconf2.git
cd libnetconf2
mkdir build
cd build
cmake ..
make -j4
sudo make install
cd ../..
rm -rf libnetconf2
sudo ldconfig
#netopeer2
git clone  https://github.com/CESNET/netopeer2.git
cd netopeer2
mkdir build
cd build
cmake ..
make -j4
sed -i '/SYSREPOCTL=`su -c/c\SYSREPOCTL=`which sysrepoctl`' ../scripts/setup.sh
sed -i '/SYSREPOCFG=`su -c/c\SYSREPOCFG=`which sysrepocfg`' ../scripts/merge_hostkey.sh
sed -i '/OPENSSL=`su -c /c\OPENSSL=`which openssl`' ../scripts/merge_hostkey.sh
sed -i '/SYSREPOCFG=`su -c /c\SYSREPOCFG=`which sysrepocfg`' ../scripts/merge_config.sh
sudo make install
cd ../..
rm -rf netopeer2
sudo ldconfig
echo "[Unit]

Description=A NETCONF server on top of sysrepo

After=syslog.target network.target

 

[Service]

Type=simple

Restart=always

ExecStart=/usr/local/bin/netopeer2-server -d -v 2

PIDFile=/var/run/netopeer2-server.pid

 

[Install]

WantedBy=multi-user.target" |sudo tee -a /etc/systemd/system/netopeer2-server.service
sudo systemctl daemon-reload
sudo systemctl enable netopeer2-server.service

