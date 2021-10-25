#!/bin/bash

function oldOpenVPN() {
	if [[ -e /etc/openvpn/server.conf && $AUTO_INSTALL != "y" ]]; then
		./openvpn-install.sh
	else
		curl -O https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh
		chmod +x openvpn-install.sh
	fi
}
function pauseClient() {
	read -rp "Please type the clients name: " clientName
	echo "disable" > /etc/openvpn/ccd/$clientName

	echo "Client with name $clientName, is set to pause"
}

function resumeClient() {
	read -rp "Please type the clients name: " clientName
	rm /etc/openvpn/ccd/$clientName

	echo "Client with name $clientName, is resumed"
}

function addBunch() {
	read -rp "Please type the keys prefix: " prefix
	until [[ $num =~ ^[1-9] ]]
	do
		read -p "Number of clients to be added: " num
	done
	for i in $(seq 1 $num)
	do
		MENU_OPTION="1" CLIENT="${prefix}_${i}" PASS="1" ./openvpn-install.sh
	done

	echo "$num clients added to the Database!"
}

function moveOpen() {
	read -rp "Type username of the new server: " newName
	until [[ $varname1 =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; do
		read -p 'IPv4 of new server: ' varname1
	done
	scp -r /etc/openvpn $newName@$varname1:/etc/
}

function setFirewall() {
	iptables -P INPUT ACCEPT
	iptables -P FORWARD ACCEPT
	iptables -P OUTPUT ACCEPT
	iptables -F
	iptables -X

	iptables -A INPUT -i lo -j ACCEPT
	iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
	iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
	iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT

	iptables -A OUTPUT -d 27.34.176.0/24   -j REJECT
	iptables -A OUTPUT -d 27.34.185.1/32  -j REJECT
	iptables -A OUTPUT -d 27.34.185.2/31  -j REJECT
	iptables -A OUTPUT -d 27.34.185.4/30  -j REJECT
	iptables -A OUTPUT -d 27.34.185.32/27  -j REJECT
	iptables -A OUTPUT -d 27.34.185.8/29  -j REJECT
	iptables -A OUTPUT -d 27.34.185.16/28  -j REJECT
	iptables -A OUTPUT -d 27.34.185.64/26  -j REJECT
	iptables -A OUTPUT -d 27.34.185.128/32  -j REJECT
	iptables -A OUTPUT -d 57.88.240.0/20  -j REJECT
	iptables -A OUTPUT -d 57.90.150.0/23  -j REJECT
	iptables -A OUTPUT -d 77.70.142.224/28  -j REJECT
	iptables -A OUTPUT -d 91.202.232.0/22  -j REJECT
	iptables -A OUTPUT -d 93.171.174.0/24  -j REJECT
	iptables -A OUTPUT -d 95.85.96.0/19  -j REJECT
	iptables -A OUTPUT -d 178.171.66.0/23  -j REJECT
	iptables -A OUTPUT -d 185.69.184.0/22  -j REJECT
	iptables -A OUTPUT -d 185.246.72.0/22  -j REJECT
	iptables -A OUTPUT -d 195.191.230.0/23  -j REJECT
	iptables -A OUTPUT -d 217.174.224.0/20  -j REJECT
	iptables -A OUTPUT -d 46.4.97.67  -j REJECT
	iptables -A OUTPUT -d 104.236.76.78  -j REJECT
	iptables -A OUTPUT -d 74.208.121.58  -j REJECT
	iptables -A OUTPUT -d 108.160.145.136  -j REJECT
	# new
	iptables -A OUTPUT -d 23.36.234.26 -j REJECT
	iptables -A OUTPUT -d 104.111.250.85 -j REJECT
	iptables -A OUTPUT -d 213.189.196.123 -j REJECT
	iptables -A OUTPUT -d 104.22.71.144 -j REJECT
	iptables -A OUTPUT -d 104.22.70.144 -j REJECT
	iptables -A OUTPUT -d 172.67.26.128 -j REJECT
	iptables -A OUTPUT -d 172.67.222.63 -j REJECT
	iptables -A OUTPUT -d 104.21.46.15 -j REJECT
	iptables -A OUTPUT -d 185.152.212.143 -j REJECT
	iptables -A OUTPUT -d 194.55.30.46 -j REJECT
	iptables -A OUTPUT -d 194.55.26.46 -j REJECT
	iptables -A OUTPUT -d 185.178.208.4 -j REJECT
	iptables -A OUTPUT -d 172.67.26.188 -j REJECT
	iptables -A OUTPUT -d 104.22.15.248 -j REJECT
	iptables -A OUTPUT -d 104.22.14.248 -j REJECT
	iptables -A OUTPUT -d 178.210.86.126 -j REJECT
	iptables -A OUTPUT -d 185.22.184.252 -j REJECT
	iptables -A OUTPUT -d 185.87.196.144 -j REJECT
	iptables -A OUTPUT -d 216.158.237.154 -j REJECT
	iptables -A OUTPUT -d 66.23.202.226 -j REJECT
	iptables -A OUTPUT -d 51.77.52.241 -j REJECT
	iptables -A OUTPUT -d 95.217.91.92 -j REJECT
	iptables -A OUTPUT -d 95.141.32.28 -j REJECT
	iptables -A OUTPUT -d 95.217.118.44 -j REJECT
	iptables -A OUTPUT -d 74.63.237.158 -j REJECT
	iptables -A OUTPUT -d 45.88.198.232 -j REJECT


	iptables -A FORWARD -d 27.34.176.0/24 -j REJECT
	iptables -A FORWARD -d 27.34.185.1/32 -j REJECT
	iptables -A FORWARD -d 27.34.185.2/31 -j REJECT
	iptables -A FORWARD -d 27.34.185.4/30 -j REJECT
	iptables -A FORWARD -d 27.34.185.32/27 -j REJECT
	iptables -A FORWARD -d 27.34.185.8/29 -j REJECT
	iptables -A FORWARD -d 27.34.185.16/28 -j REJECT
	iptables -A FORWARD -d 27.34.185.64/26 -j REJECT
	iptables -A FORWARD -d 27.34.185.128/32 -j REJECT
	iptables -A FORWARD -d 57.88.240.0/20 -j REJECT
	iptables -A FORWARD -d 57.90.150.0/23 -j REJECT
	iptables -A FORWARD -d 77.70.142.224/28 -j REJECT
	iptables -A FORWARD -d 91.202.232.0/22 -j REJECT
	iptables -A FORWARD -d 93.171.174.0/24 -j REJECT
	iptables -A FORWARD -d 95.85.96.0/19  -j REJECT
	iptables -A FORWARD -d 178.171.66.0/23  -j REJECT
	iptables -A FORWARD -d 185.69.184.0/22  -j REJECT
	iptables -A FORWARD -d 185.246.72.0/22  -j REJECT
	iptables -A FORWARD -d 195.191.230.0/23  -j REJECT
	iptables -A FORWARD -d 217.174.224.0/20  -j REJECT
	iptables -A FORWARD -d 46.4.97.67  -j REJECT
	iptables -A FORWARD -d 104.236.76.78  -j REJECT
	iptables -A FORWARD -d 74.208.121.58  -j REJECT
	iptables -A FORWARD -d 108.160.145.136  -j REJECT
	iptables -A FORWARD -d 23.36.234.26 -j REJECT
	iptables -A FORWARD -d 104.111.250.85 -j REJECT
	iptables -A FORWARD -d 213.189.196.123 -j REJECT
	iptables -A FORWARD -d 104.22.71.144 -j REJECT
	iptables -A FORWARD -d 104.22.70.144 -j REJECT
	iptables -A FORWARD -d 172.67.26.128 -j REJECT
	iptables -A FORWARD -d 172.67.222.63 -j REJECT
	iptables -A FORWARD -d 104.21.46.15 -j REJECT
	iptables -A FORWARD -d 185.152.212.143 -j REJECT
	iptables -A FORWARD -d 194.55.30.46 -j REJECT
	iptables -A FORWARD -d 194.55.26.46 -j REJECT
	iptables -A FORWARD -d 185.178.208.4 -j REJECT
	iptables -A FORWARD -d 172.67.26.188 -j REJECT
	iptables -A FORWARD -d 104.22.15.248 -j REJECT
	iptables -A FORWARD -d 104.22.14.248 -j REJECT
	iptables -A FORWARD -d 178.210.86.126 -j REJECT
	iptables -A FORWARD -d 185.22.184.252 -j REJECT
	iptables -A FORWARD -d 185.87.196.144 -j REJECT
	iptables -A FORWARD -d 216.158.237.154 -j REJECT
	iptables -A FORWARD -d 66.23.202.226 -j REJECT
	iptables -A FORWARD -d 51.77.52.241 -j REJECT
	iptables -A FORWARD -d 95.217.91.92 -j REJECT
	iptables -A FORWARD -d 95.141.32.28 -j REJECT
	iptables -A FORWARD -d 95.217.118.44 -j REJECT
	iptables -A FORWARD -d 74.63.237.158 -j REJECT
	iptables -A FORWARD -d 45.88.198.232 -j REJECT
	
	if [ $(dpkg-query -W -f='${Status}' iptables-persistent 2>/dev/null | grep -c "ok installed") -eq 0 ];
	then
  		apt install -y iptables-persistent
		systemctl enable netfilter-persistent.service
	fi
}

function addExpire() {
	until [[ $CLIENT =~ ^[a-zA-Z0-9_-]+$ ]]; do
		read -rp "Client name: " -e CLIENT
	done
	
	until [[ $days =~ ^[1-9] ]]
	do
		read -p "Days after certificate expires: " days
	done

	export EASYRSA_CERT_EXPIRE=$days
	export MENU_OPTION="1"
	export CLIENT="$CLIENT"
	export PASS="1"
	./openvpn-install.sh
	export EASYRSA_CERT_EXPIRE=3650
}

function showExpireDates() {
	cd /etc/openvpn/easy-rsa/pki/issued

	for cert in `ls *.crt`; do
		exp=`openssl x509 -noout -text -in $cert | grep "Not After" | cut -d: -f2-10`
		echo $cert expires $exp
	done
}


function manageMenu() {
	echo "Welcome to Ivar-install!"
	echo "This is not available anywhere so be careful"
	echo ""
	echo "What do you want to do?"
	echo "   1) Install, Add, Revoke Clients or Remove OpenVPN"
	echo "   2) Add user with expiration date"
	echo "   3) Pause client"
	echo "   4) Resume client"
	echo "   5) Add bunch of clients"
	echo "   6) Set Turkmenistan Firewall"
	echo "   7) Move OpenVPN to new server"
	echo "   8) Exit"
	until [[ $MENU_OPTION =~ ^[1-9]$ ]]; do
		read -rp "Select an option [1-9]: " MENU_OPTION
	done

	case $MENU_OPTION in
	1)
		oldOpenVPN
		;;
	2)
		addExpire
		;;
	3)
		pauseClient
		;;
	4)
		resumeClient
		;;
	5) 
		addBunch
		;;
	6) 
		setFirewall
		;;
	7)
		moveOpen
		;;
	8)
		exit 0
		;;
	esac
}


manageMenu
