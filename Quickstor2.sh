#!/usr/local/bin/zsh
ClearExit() {
	echo got a signal > /TopStor/txt/sigstatus.txt
	exit 0;
}
trap ClearExit HUP
while true; do 
{
 sleep 2 
 if [[ `service QuickStor status | awk '{print $3}'` = not ]]; then
  service QuickStor start
 fi
 sleep 2
}
done;
