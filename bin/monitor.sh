#!/bin/sh
cd /root/17ce
PID=`pidof 17ce_v3`
echo "pid: $PID"
if [ "x$PID" = 'x' ]; then
	echo "process die"
	/etc/init.d/17ceclient start
else
	echo "process ok"
	MEM=`ps|grep 17ce_v3|grep -v grep|awk '{print $3}'`
	if [ "$MEM" -gt 25000 ]; then
		echo "mem out: $MEM"
		/etc/init.d/17ceclient restart
	else
		echo "mem ok"
		LOGSIZE=`ls 17ce_v3.log  -l| awk '{print $5}'`
		if [ "$LOGSIZE" -gt 1000000 ]; then
			echo "log size out: $MEM"
			/etc/init.d/17ceclient restart
		else
			echo "log size ok"
		fi
	fi
fi


VERSION=`./17ce_v3 -v`
echo "current version: $VERSION"

STR="this is a string"
TEMPSTR=`curl -k -m 10 http://www.cdnunion.com/FP2P/soft/17ce_version.php 2>/dev/null`
TVER=`echo $TEMPSTR|awk '{print $1}'`
TURL=`echo $TEMPSTR|awk '{print $2}'`
if echo "$TURL" |grep -q "http"
then
	echo "get version:$TVER, get update url:$TURL"
	if [ "x$VERSION" != "x$TVER" ]; then
		echo "updating..."
		if curl -o update.tgz -k -m 60 $TURL
		then
			echo "download ok"
			/etc/init.d/17ceclient stop
			killall -9 17ce_v3
			tar zxf update.tgz
			/etc/init.d/17ceclient start
			echo "update ok"
		else
			echo "download failed"
		fi
	else
		echo "17ce is already the newest version"
	fi
fi

