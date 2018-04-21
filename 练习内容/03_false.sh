#!/bin/bash
rm -f /tmp/user.log
for i in `seq -w 10`
do
    useradd theshu$i && \
    echo "echo $RANDOM | md5sum | cut -c 1-8" | passwd --stdin theshu$i
    echo -e "user:theshu$i \t pass:`echo $RANDOM | md5sum | cut -c 1-8`" >> /tmp/user.log
done
