#!/bin/bash
if [ -e /run/sshwarn ] ; then
	whiptail --title "Password error" --msgbox "It is neccesrarry that your ssh-password was changed before running this script. The default passord is a high security risk. Change your password now!" 8 78
	passwd
	while [ $? -ne 0 ]; do
		passwd
	done
fi
key_id=$(whiptail --inputbox "please enter your key-ID" 8 39 '' --title "6tree configuration" 3>&1 1>&2 2>&3)
echo "$key_id"
key_pwd=$(whiptail --inputbox "please enter your key password" 8 39 '' --title "6tree configuration" 3>&1 1>&2 2>&3)
echo "$key_pwd"
wget https://user:${key_pwd}@6tree.innoroute.eu/keys/${key_id}/wg0.conf -O wg_tmp.conf
if [ $? = 0 ]; then
    sudo systemctl stop wg-quick@wg6t
    sudo mv wg_tmp.conf /etc/wireguard/wg6t.conf
    sudo systemctl start wg-quick@wg6t
    sudo systemctl enable wg-quick@wg6t    
else
  whiptail --title "6tree configuration" --msgbox "Downloading the configuration failed, please check your inputs" 8 78 
  exit 1
fi
echo "check if german-6tree root server is reachable..."
ping6 AF49::1 -c3 
if [ $? = 0 ]; then
	sixtreeprefix=$(sudo cat /etc/wireguard/wg6t.conf | grep "Address" | cut -d '=' -f2 | sed 's/::/-/g' | cut -d '-' -f1)
	echo "update settings with personal prefix: $sixtreeprefix"
#	echo "rthat_sixtreeprefix='$sixtreeprefix'" | sudo tee -a /usr/share/InnoRoute/rt_hat.conf
	sudo sed -i "/rthat_sixtreeprefix/crthat_sixtreeprefix='$sixtreeprefix'" /usr/share/InnoRoute/rt_hat.conf
	echo "interface RT2
{
        AdvSendAdvert on;
        prefix $sixtreeprefix::1/64
        {
                AdvOnLink on;
                AdvAutonomous on;
        };
};
" | sudo tee  /etc/radvd.conf
	sudo ifconfig RT2 inet6 add ${sixtreeprefix}::2/64
	sudo ip -6 route del  ${sixtreeprefix}::/64 dev wg6t
	sudo /etc/init.d/radvd start
fi
