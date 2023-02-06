#!/bin/bash
# Dynamic hostname update client for Linux/BASH

updatepw="Paste update password here"
dynhostname="dyn-host-name"
dynfqdn="${dynhostname}.domain.com"
updurl="https://dyn.domain.com/cgi-bin/mynsupd.cgi"
ipaddr1=$(curl -s https://dyn.domain.com/checkip.php)
ipaddr2=$(dig +short ${dynfqdn} | head -n1)

if [[ $ipaddr1 != $ipaddr2 ]]; then
        poststring="updatepw=${updatepw}&dynhostname=${dynhostname}&hostip=${ipaddr1}"
        curl -X POST -d $poststring $updurl
fi
