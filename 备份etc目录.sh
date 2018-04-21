#!/bin/bash
# 在每月第一天备份并压缩/etc目录的所有内容，存放在/root/bak目录里.
# 文件名为如>下形式yymmdd_etc，yy为年，mm为月，dd为日
# Shell程序fileback存放在/usr/bin目录下。
#
# =================================================================
#
# echo “0 0 1 * * /bin/sh /usr/bin/fileback” >; /root/etcbakcron  
# crontab /root/etcbakcron  
# 或使用crontab -e 命令添加定时任务：  
# 0 1 * * * /bin/sh /usr/bin/fileback  

DIRNAME=`ls /root | grep bak`

if [ -z "$DIRNAME" ] ; then
    mkdir /root/bak
    cd /root/bak
else
    cd /root/bak
fi

YY=`date +%y`
MM=`date +%m`
DD=`date +%d`

BACKETC=$YY$MM$DD'_etc.tar.gz'
tar zcf $BACKETC /etc/ &> /dev/null
