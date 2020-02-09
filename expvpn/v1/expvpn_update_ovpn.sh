#!/bin/sh
# title			:expvpn_update_ovpn.sh
# description	:Gather Express VPN ovpn files and set additional global ovpn parameters
# author		:David James
# date			:Feb 9 2020
# version		:1.0  
#==============================================================================

# Get Express VPN subscriber Activation Key and customise the download script
sed -i "s/url_key/`cat /etc/openvpn/activation.key`/g" /tmp/expvpn_download_ovpn.sh

# Then run the customised download script
sh /tmp/expvpn_download_ovpn.sh

# Copy ovpn files to separte paths for instance specific changes
mkdir -p /tmp/vpn1
cp -f /tmp/*.ovpn /tmp/vpn1
cp -f /tmp/expvpn_location_list.txt /tmp/vpn1/vpn1_location_list.txt
mkdir -p /tmp/vpn2
cp -f /tmp/*.ovpn /tmp/vpn2
cp -f /tmp/expvpn_location_list.txt /tmp/vpn2/vpn2_location_list.txt
mkdir -p /tmp/vpn3
cp -f /tmp/*.ovpn /tmp/vpn3
cp -f /tmp/expvpn_location_list.txt /tmp/vpn3/vpn3_location_list.txt

# adjust drop down menu files for each instance
sed -i 's#/path/#/etc/openvpn/vpn1/#' /tmp/vpn1/vpn1_location_list.txt
sed -i 's#/path/#/etc/openvpn/vpn2/#' /tmp/vpn2/vpn2_location_list.txt
sed -i 's#/path/#/etc/openvpn/vpn3/#' /tmp/vpn3/vpn3_location_list.txt

# adjust ovpn files for each instance via wildcard script
for file1 in /tmp/vpn1/*.ovpn; do
sed -i 's/dev tun/dev tun1/' "$file1" &&
sed -i 's#auth-user-pass#auth-user-pass /etc/openvpn/vpn.auth#' "$file1" &&
sed -i '2i log /tmp/log/vpn1.log' "$file1" &&
sed -i '3i route-nopull' "$file1" &&
sed -i '4i route-metric 21' "$file1" &&
sed -i '5i route 0.0.0.0 0.0.0.0 vpn_gateway 21' "$file1"
done

for file2 in /tmp/vpn2/*.ovpn; do
sed -i 's/dev tun/dev tun2/' "$file2" &&
sed -i 's#auth-user-pass#auth-user-pass /etc/openvpn/vpn.auth#' "$file2" &&
sed -i '2i log /tmp/log/vpn2.log' "$file2" &&
sed -i '3i route-nopull' "$file2" &&
sed -i '4i route-metric 22' "$file2" &&
sed -i '5i route 0.0.0.0 0.0.0.0 vpn_gateway 22' "$file2"
done

for file3 in /tmp/vpn3/*.ovpn; do
sed -i 's/dev tun/dev tun3/' "$file3" &&
sed -i 's#auth-user-pass#auth-user-pass /etc/openvpn/vpn.auth#' "$file3" &&
sed -i '2i log /tmp/log/vpn3.log' "$file3" &&
sed -i '3i route-nopull' "$file3" &&
sed -i '4i route-metric 23' "$file3" &&
sed -i '5i route 0.0.0.0 0.0.0.0 vpn_gateway 23' "$file3"
done

# Refresh and move finished files to nvram
rm -f -r /etc/openvpn/vpn1/*.*
rm -f -r /etc/openvpn/vpn2/*.*
rm -f -r /etc/openvpn/vpn3/*.*
mkdir -p /etc/openvpn/vpn1
cp -f /tmp/vpn1/*.* /etc/openvpn/vpn1
mkdir -p /etc/openvpn/vpn2
cp -f /tmp/vpn2/*.* /etc/openvpn/vpn2
mkdir -p /etc/openvpn/vpn3
cp -f /tmp/vpn3/*.* /etc/openvpn/vpn3

# remove uneeded downloaded files
rm /tmp/*.ovpn
rm /tmp/*.sh
rm /tmp/*.setup
rm /tmp/expvpn_location_list.txt
rm -r /tmp/vpn*
