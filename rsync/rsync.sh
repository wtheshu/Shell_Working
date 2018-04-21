#!/bin/bash

num1=0
num2=0
num3=0

[ -f rsync.expect -a -x rsync.expect ] && num1=1 || {echo "rsync.expect error"; exit 1}
[ -f ip.list -a -r ip.list ] && num2=1 || {echo "ip.list error"; exit 1}
[ -f file.list -a -r file.txt ] && num3=1 || {echo "file.list error"; exit 1}

[ num1 -eq "1" -a num2 -eq "1" -a num3 -eq "1" ] && {
	for ip in `cat ip.list`
	do
		echo $ip
		./rsync.expect $ip file.list
	done
}

