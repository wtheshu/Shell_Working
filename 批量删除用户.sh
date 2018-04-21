#!/bin/bash
# 实现自动删除30个账户的功能
# 账号名为stu01到stu50

number=1
while [ $number -le 30 ]
do
        if [ $number -le 9 ]
        then
                USERNAME=stu0$number
        else
                USERNAME=stu$number
        fi

        userdel -r $USERNAME

        number=$[$number+1]
done

