# Cleanup
# 清除：清除/var/log/下的log文件

cd /var/log
cat /dev/null > messages
cat /dev/null > wtmp
echo "Logs cleaned up."
