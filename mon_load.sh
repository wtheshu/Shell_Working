#!/bin/bash

rmail="theshu@qq.com"
L="5"
host=`hostname`

while :
do
	load=`uptime | awk '{print $10}' | cut -d'.' -f 1`
	if [ $load -gt $L ]
	then
		uptime | awk '{print $8,$9,$10,$11,$12}' > /tmp/mail.txt
		mail -s $host $rmail < /tmp/mail.txt
		rm -rf /tmp/mail.txt
		sleep 600
	fi
	sleep 3
done
