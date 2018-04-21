---
title: shell实现发告警的收敛
date: 2018-01-27 11:51:15
categories: Shell
tags:
---

> GO

## 需求：

由于某些公共平台告警有5分钟延迟，这样对业务来说时效性非常不好，只好动手写了一个shell脚本来实现监控和告警。之前是只要触发了告警阈值，就立即告警，为了保证时效性，只能用cron实现，一分钟检测一次，这样的好处是，发现问题就告警，坏处是，当出现问题，一分钟一个告警，一分钟一个，若是监控的项目多，10分钟可能就上百。这严重影响了问题，以及浪费了短信成本。于是乎，想办法搞个收敛机制。思路是：
1. 监控的某个服务出现了问题，首先会去比较一下上一次出问题时的时间，分两种情况，大于1小时，或者在1小时之内。
2. 当大于1小时，说明这个问题出现后，已经正常，然后又过了很久再次出现，这时，我们需要打个标记，说明问题开始出现了。
3. 当小于1小时，说明问题刚刚出现，还没有修复，这时就需要首先发一个告警，告诉相关人员，出问题了，在问题解决之前，我们是保持十分钟一次告警的频率，比之前的一分钟1次降低了10倍的频率，大大降低了骚扰程度和短信成本。

## 实现：

其shell代码如下所示：
```sh
#!/bin/bash

log=$1
t_s=`date +%s`
t_s2=`tail -1 /tmp/$log | awk '{print $1}'`

echo $t_s >> /tmp/$log

v=$[$t_s-$t_s2]
echo v

if [ $v -gt 3600 ]
then
	$send_mail -r fi $rtx_res -s $phone -t "$addr $1 $2" -c "weishequ $1 $2"
	echo "0" > /tmp/$log.txt
else
	nu=`cat /tmp/$log.txt`
	nu2=$[$nu+1]
	echo $nu2 > /tmp/$log.txt
	if [ $nu2 -gt 10 ]
	then
		$send_mail -r $rtx_res -s $phone -t "$addr $1 $2" -c "weishequ $1 $2 and the trouble continue 10 min."
		echo "0" > /tmp/$log.txt
	fi
fi
```

假如，这个文件的名字叫做 sendm.sh，我是这样去使用它的：`sh sendm.sh load $load`

其中，load是我们的监控项目，在脚本中会用作日志名字，第二个参数是load值，这个需要还有个脚本去监控系统load获取load的值，去比较，然后判断是否告警。



> OK
