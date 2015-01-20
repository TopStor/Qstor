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
xflag=`iostat -x $Device | awk -F" " 'NR==3{printf("%-7s%-8.1f%-8.1f%-8.1f%-8.1f%-8.1f%-8.1f%-6d",$1,$2,$3,$4,$5,$6,$7,$8)}'`
dflag=`iostat -d $Device | awk -F" " 'NR==3{printf("%8.3f",$3*1024)}'`
iostat=`echo -n $xflag ;echo  $dflag`
echo $iostat |
awk -F" " '
	BEGIN {
		cmd1="date +%d-%m-%Y"
		cmd2="date +%H:%M:%S"
		}
		{ cmd1|getline date; cmd2|getline time;\
		printf(" %-8s| %s | %s | %-8.3f| %-8.3f| %-8.3f| %-8.3f| %-8d|\n",$1,date,time,$9,$2,$3,$7,$6)
		close(cmd1)
		close(cmd2)

	     }'


