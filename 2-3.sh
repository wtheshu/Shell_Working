#!/bin/bash
# 清除，版本3
# 一个增强的和广义的删除logfile的脚本

LOG_DIR=/var/log
ROOT_UID=0	# $SUID为0的时候，用户才具有根用户的权限
LINES =50	# 默认的保存行数
E_XCD=66	# 不能修改目录？
E_NOTROOT=67	# 非根用户将以error退出

if [ "$UID" -ne "$ROOT_UID" ]
then
    echo "Mustbe root to run this script."
    exit $E_NOTROOT
fi

if [ -n "$1" ]
# 测试是否有命令行参数（非空）。
then
    lines=$1
else
    lines=$LINES    # 默认，如果不在命令行中指定
fi

# 建议使用下边的更好的方法来检测命令行参数。
# 

