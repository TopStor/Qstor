#!/usr/local/bin/zsh
cd /TopStor
mkfifo -m 660 /tmp/msgfile
mkfifo -m 660 /tmp/ackmsg;
chgrp moataz /tmp/msgfile; chgrp moataz /tmp/ackmsg;
chown www /tmp/msgfile; chown www /tmp/ckmsg
rm /TopStor/txt/*
ClearExit() {
	echo got a signal > /TopStor/txt/sigstatus.txt
	rm /tmp/msgfile
	exit 0;
}
trap ClearExit HUP
while true; do 
{
read line < /tmp/msgfile
echo $line > /TopStor/tmpline
request=`echo $line | awk '{print $1}'`
reqparam=`echo $line | cut -d " " -f2-`
./$request $reqparam & 
}
done;
echo it is dead >/TopStor/txt/status.txt
