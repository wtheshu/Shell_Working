#!/bin/bash
# 在/userdata目录下建立50个目录，即user1～user50，并设置每个目录的权限。
# 其中其他用户的权限为：读；
# 文件所有者的权限为：读、写、执行；
# 文件所有者所在组的权限为：读、执行。

i=1
while [ $i -le 50 ]
do
	if [ -d /userdata ] ; then
		mkdir -p /userdata/user$i
		chmod 754 /userdata/user$i
		echo "user$i"
		let "i=$i+1"
	else
		mkdir /userdata
		mkdir -p /userdata/user$i
		chmod 754 /userdata/user$i
		echo "user$i"
		let "i=$i+1"
	fi
done
