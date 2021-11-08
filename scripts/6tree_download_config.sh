#!/bin/bash
sudo apt install wireguard wireguard-tools radvd
if [ -e /run/sshwarn ] ; then
	whiptail --title "Password error" --msgbox "It is neccesrarry that your ssh-password was changed before running this script. The default passord is a high security risk. Change your password now!" 8 78
	passwd
	while [ $? -ne 0 ]; do
		passwd
	done
fi
true
while [ $? -eq 0 ]; do
	mailaddress=$(whiptail --inputbox "Please enter your Email address" 8 39 '' --title "6tree configuration" 3>&1 1>&2 2>&3)
	password=$(whiptail --passwordbox "Please enter your password" 8 39 '' --title "6tree configuration" 3>&1 1>&2 2>&3)
	if [ -z "$mailaddress" ] 
		then
		break
		fi
		rm login.php
	wget --save-cookies cookies.txt --keep-session-cookies --post-data "mail=$mailaddress&password=$password"   https://vernetzung.innoroute.eu/login.php #--delete-after 
	cat login.php | grep  "Invalid mail or password." && whiptail --title "wrong password" --msgbox "Password or mail address wrong. Registration under https://vernetzung.innoroute.eu/register.php. Blank mail to exit." 8 78
done
wget --load-cookies cookies.txt  https://vernetzung.innoroute.eu/download_configfile.php -O wg_tmp.conf
rm cookies.txt
#wget https://user:${key_pwd}@6tree.innoroute.eu/keys/${key_id}/wg0.conf -O wg_tmp.conf

cat wg_tmp.conf | grep "Please fill in your credentials to login"


if [ $? -ne 0 ]; then
    sudo systemctl stop wg-quick@wg6t
    sudo sed '/^\[Peer\].*/i PostUp = /etc/wireguard/wg6t_up.sh &' wg_tmp.conf | sudo tee  /etc/wireguard/wg6t.conf
    sudo rm wg_tmp.conf
    sudo systemctl enable wg-quick@wg6t    
else
  whiptail --title "6tree configuration" --msgbox "Downloading the configuration failed, please check your inputs" 8 78 
  rm wg_tmp.conf
  exit 1
fi

	sixtreeprefix=$(sudo cat /etc/wireguard/wg6t.conf | grep "Address" | cut -d '=' -f2 | sed 's/::/-/g' | cut -d '-' -f1)
	echo "update settings with personal prefix: $sixtreeprefix"
##	echo "rthat_sixtreeprefix='$sixtreeprefix'" | sudo tee -a /usr/share/InnoRoute/rt_hat.conf
	sudo sed -i "/rthat_sixtreeprefix/crthat_sixtreeprefix='$sixtreeprefix'" /usr/share/InnoRoute/rt_hat.conf
	echo "interface RT2
{
        AdvSendAdvert on;
        AdvDefaultPreference low;
        prefix $sixtreeprefix::1/64
        {
                AdvOnLink on;
                AdvAutonomous on;
        };
        RDNSS AF49::1
        {
                 AdvRDNSSLifetime 3600;
        };
};
" | sudo tee  /etc/radvd.conf
	echo "#!/bin/bash" | sudo tee  /etc/wireguard/wg6t_up.sh
	echo "sleep 5" | sudo tee -a /etc/wireguard/wg6t_up.sh
	echo "sudo ifconfig RT2 inet6 add ${sixtreeprefix}::2/64" | sudo tee -a /etc/wireguard/wg6t_up.sh
	echo "sudo ip -6 route del  ${sixtreeprefix}::/64 dev wg6t " | sudo tee -a /etc/wireguard/wg6t_up.sh
	echo "sudo sysctl -w net.ipv6.conf.all.forwarding=1" | sudo tee -a /etc/wireguard/wg6t_up.sh
	sudo chmod +x /etc/wireguard/wg6t_up.sh
	sudo /etc/init.d/radvd start
	sudo systemctl enable  radvd
	sudo sysctl -w net.ipv6.conf.all.forwarding=1
	sudo systemctl start wg-quick@wg6t
echo "check if german-6tree root server is reachable..."
ping6 AF49::1 -c3 
echo "####"
echo "Gratulations, you are now part of the 6Tree network :)"
echo "All devices reachable via RT2 should have an Address offer also."
echo "The default configuration allows incomming traffic from everywhere. You should apply filters to control which packets should reach your subnetwork."
echo "Have a look at https://innoroute.com/save/#filter"
