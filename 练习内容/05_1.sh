#!/bin/bash
file=$1 #<==定义一个变量接收命令行传参，参数为日志文件类型
while true
do
    awk '{print $1}' $1 | grep -v "^$" | sort | uniq -c > /tmp/tmp.log
    #<==分析传入的日志文件，并在排序去重后追加到一个临时文件里
    exec < /tmp/tmp.log #<==读取上述临时文件
    while read line
    do
        ip=`echo $line | awk '{print $2}'`  #<==获取文件中的每一行的第二列
        count=`echo $line | awk '{print $1}'`   #<==获取文件中的每一行的第一列
        if [ $count -gt 500 ] && [ `iptables -L -n | grep "$ip" | wc -l` -lt 1 ]
        #<==如果PV数大于500，并且防火墙里没有封过此IP
        then
            iptables -I INPUT -s $ip -j DROP    #<==则封掉PV数大于500的IP
            echo "$line is dropped" >> /tmp/droplist_$(date +%F).log
                                                #<==记录处理日志
        fi
    done
    sleep 3600 #<==还可以按分钟进行分析，不过日hi的分割或过滤也得按分钟才行。
done

