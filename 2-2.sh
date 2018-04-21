#!/bin/bash
# 清除：一个改良的清除脚本
# Cleanup，版本2
# 在此处插入代码，来打印错误消息，并且在不是root身份的时候退出。

LOG_DIR=/var/log
cd $LOG_DIR	# 使用变量，当然比把代码写死的好

cat /dev/null > messages
cat /dev/null > wtmp

echo "Logs cleaned up."

exit	# 这个命令是一种正确并且合适的推出脚本的方法
