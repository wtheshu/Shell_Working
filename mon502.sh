#!/bin/bash

logfile="/var/log/yp1/access.log"

while :
do
	n=`tail -n 500 $logfile | grep -c ' 502' `
	if [ $n -gt 100 ]
	then
		echo "ypl-502" | mail -s ypl.com-502 theshu@qq.com
	fi
	sleep 60
done
