#!/usr/local/bin/zsh
#-------------------------------------------------------------------------#
#- Author  of this  Program: Abdo Farag 				 -#
#- E-Mail Address of Author: abdofarag85@gmail.com    	                 -#
#- Program Name and Release: IOPs Status Monitoring                      -#
#- Date and Time of Release: 10-2-2015		                         -#
#-                                                                       -#
#- Description and Usage:                                                -#
#-        This script should be run from "Cron Jop" every 10 minutes	 -#
#- to create reports based on statistics  gathered  from   IOSTAT	 -#
#- IOSTAT  is  used  to report about disk I/O activity and throughput.	 -#
#--------------------------BEGIN PROGRAM----------------------------------#

which iostat > /dev/null 2>&1
if [ $? -ne 0 ]
then
  echo "iostat command not found!"
  exit 0
fi

if [ $# -lt 1 ]
then
  echo "diskname argument not specified!"
  exit
fi
os=`uname`
Device=$1
iostat -x  $Device|
awk -F" " '
	BEGIN {
		cmd="date +%m-%d-%Y...%H:%M:%S"
		printf "%s%s%s%s%s%s%s%s\n", \
		"<<Device>> |","    Date   -|-  Time   |"," <<kread/s>> |"," <<kwrite/s>> |"," <<IO r/s>> |"," <<IO w/s>> |"," <<srv_c>> |"," <<qlen>> |"}
		NF==8,NR==NR{ cmd|getline now; \
		printf("%-10s | %s | %-12.2f| %-13.2f| %-11.2f| %-11.2f| %-10.2f| %-9d|\n",$1,now,$4,$5,$2,$3,$7,$6)
		close(cmd) 
	     }'

