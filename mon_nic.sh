#!/bin/bash

rmail="theshu@qq.com"
N="2000000"
host="hostname"

while :
do
	sar -n DEV 1 5 | grep eth0 | tail -n1 > /tmp/sar.txt
	n=`awk '{print $5}' /tmp/sar.txt | cut -d. -f1`
	if [ $n -gt $N ]
	then
		mail -s $host $rmail < /tmp/sar.txt
		sleep 600
	fi
	sleep 3
done
