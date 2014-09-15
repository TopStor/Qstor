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
echo TopStor service alive >/TopStor/txt/status.txt
echo $line > /TopStor/txt/msgfile
}
done;
echo it is dead >/TopStor/txt/status.txt
