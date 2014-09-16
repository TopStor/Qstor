#!/usr/local/bin/zsh
mkfifo -m 660 /tmp/msgfile
chgrp moataz /tmp/msgfile
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
echo $request > /TopStor/tmpline2
echo $reqparam  >> /TopStor/tmpline2
}
done;
echo it is dead >/TopStor/txt/status.txt
