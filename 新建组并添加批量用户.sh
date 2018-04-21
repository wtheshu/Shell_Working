#!/bin/bash
# 设计与i个shell程序，添加一个新组为class1。
# 然后添加30个用户到该新组内
# 用户名的形式为 stdxx，其中xx从01到30

groupadd class1

number=1
while [ $number -le 30 ]
do
	if [ $number -le 9 ]
	then
		USERNAME=stu0${number}
	else
		USERNAME=stu${number}
	fi

	useradd $USERNAME
	usermod -G class1 $USERNAME

	number=$[$number+1]
done
