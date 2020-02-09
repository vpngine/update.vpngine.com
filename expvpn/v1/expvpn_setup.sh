#!/bin/sh
# title        :expvpn_setup.sh
# description  :Begins Express VPN (triple VPN location & instance) on VPNgine router
# author       :David James
# date         :Feb 9 2020
# version      :1.0 
# ==============================================================================
# start setup with curl "https://update.vpngine.com/expvpn/v1/expvpn_setup.sh" -o /tmp/expvpn_setup.sh && sh /tmp/expvpn_setup.sh 
# Get the main setup file
curl  "https://update.vpngine.com/expvpn/v1/expvpn_update_ovpn.sh" -o /tmp/expvpn_update_ovpn.sh
curl  "https://update.vpngine.com/expvpn/v1/expvpn_download_ovpn.sh" -o /tmp/expvpn_download_ovpn.sh
curl  "https://update.vpngine.com/expvpn/v1/expvpn_location_list.txt" -o /tmp/expvpn_location_list.txt

# Make download scripts exectuable
chmod 744 /tmp/expvpn_update_ovpn.sh
chmod 744 /tmp/expvpn_download_ovpn.sh
sh /tmp/expvpn_update_ovpn.sh