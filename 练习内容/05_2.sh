#!/bin/bash
file=$1 #<==定义一个变量以接收命令行传参，参数为日志文件类型。
#==实际工作中可以先使用netstat命令将网络状态生成临时文件，然后再传参给$1
if expr "$file" : ".*\.log" &> /dev/null    #<==expr的用法，判断扩展名是否以.log结尾
then
    :   #<==这个冒号表示什么都不做
else    
    echo $"usage:$0 xxx.log"    #<==对不符合扩展名类型的给出正确提示
    exit 1  #<==退出脚本
fi

while true
do
    grep "ESTABLISHED" $1 | awk -F "[ :]+" '{ ++S[$(NF-3)]}END {for(key in S) print S[key], key}' | sort -rn -k1 | head -5 > /tmp/tmp.log
    #<==分析传入的网络状态日志，获取到客户端IP列的信息，并去重排序
    while read line
    do
        ip=`echo $line | awk '{print $2}'
        count=`echo $line | awk '{print $1}'`
        if [ $count -gt 500 ] && [ `iptables -L -n | grep "$ip" | wc -l` -lt 1 ]
        then
            iptables -I INPUT -s $ip -j DROP
            echo "$line is dropped" >> /tmp/droplist_$(date +%F).log
        fi
    done</tmp/tmp.log
    sleep 180
done
