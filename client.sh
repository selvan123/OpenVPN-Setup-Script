#!/bin/bash
#This script is univeral for any flavor of Linux.

echo -n "Enter a name for your client: "
read CLIENT

if [[ -z "$CLIENT" ]] ; then
  echo "You must specify a client name to continue"
  exit 1
fi

curl ipv4.icanhazip.com
echo -n "Enter the address specified above or if using a local server type the LAN address: "
read IP

cd /etc/openvpn/easy-rsa/
source ./vars
./build-key $CLIENT
cd keys
wget http://pastebin.com/raw.php?i=kxxvGtVH
mv raw.php?i=kxxvGtVH "$CLIENT".ovpn
echo "" >> "$CLIENT".ovpn
echo "remote $IP 1194" >> "$CLIENT".ovpn
echo "<ca>" >> "$CLIENT".ovpn
cat ca.crt >> "$CLIENT".ovpn
echo "</ca>" >> "$CLIENT".ovpn
echo "<cert>" >> "$CLIENT".ovpn
cat "$CLIENT".crt >> "$CLIENT".ovpn
echo "</cert>" >> "$CLIENT".ovpn
echo "<key>" >> "$CLIENT".ovpn
cat "$CLIENT".key >> "$CLIENT".ovpn
echo "</key>" >> "$CLIENT".ovpn
mv "$CLIENT".ovpn /root/"$CLIENT".ovpn
echo "Client setup is complete, you can find your key at /root/"$CLIENT".ovpn"
