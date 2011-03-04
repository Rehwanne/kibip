#!/bin/bash
#Requires: curl

#{ip_addr4}: Contains your IPv4 address. 

if [ `which curl` = "" ] ; then
	log_error "ip: curl is not installed"
	replace content "{ip_addr4}" "curl is not installed"
	exit
fi
ip4=`curl http://checkip.dyndns.org/ 2> /dev/null | sed -e 's/.*Address:\s\(.*\)<\/body>.*/\1/g'`

replace content "{ip_addr4}" $ip4
