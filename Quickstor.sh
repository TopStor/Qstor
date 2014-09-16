#!/usr/local/bin/zsh
ClearExit() {
	echo got a signal > /TopStor/txt/sigstatus.txt
	exit 0;
}
trap ClearExit HUP
while true; do 
{
 sleep 2
 if [[ `service TopStor status | awk '{print $3}'` = not ]]; then
  service TopStor start
 fi
 if [[ `service QuickStor2 status | awk '{print $3}'` = not ]]; then
  service QuickStor2 start
 fi
 sleep 2
}
done;
