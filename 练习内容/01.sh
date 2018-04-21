#!/bin/bash
# 批量生成随机字符文件名
# 使用for循环在/root目录下批量创建10个html文件
# 其中每个文件需要包含10个随机小写字母加固定字符串theshu
Path=/root
[ -d "$Path"  ] || mkdir -p $Path
for n in `seq 10`
do
    random=$(openssl rand -base64 40 | sed 's#[^a-z]##g' | cut -c 2-11)
    touch $Path/${random}_theshu.html
done
