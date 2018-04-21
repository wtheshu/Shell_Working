#!/bin/bash
. /etc/init.d/functions
user="theshu"
passfile="/tmp/user.log"
for num in `seq -w 10`
do
    pass="`echo "test$RANDOM" | md5sum | cut -c3-11`"
    useradd $user${num} &> /dev/null &&\
        echo -e "$user${num}:$pass" >> $passfile
    if [ $? -eq 0  ]
    then
        action "$user${num} is ok" /bin/true
    else
        action "$user${num} is fail" /bin/false
    fi
done
echo ------------
chpasswd < $passfile
cat $passfile && > $passfile
