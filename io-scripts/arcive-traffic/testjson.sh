#!/usr/local/bin/zsh
currentlog=$1
backupdir=$2
origfile=`echo $1 | tr "/" "\n"|awk 'END{print}'`
logdb=`cd $backupdir ; ls -l $origfile*`
filenum=`echo $logdb | awk 'NR>=2{printf"%s\n",$9}' | awk -F "." '{printf"%s\n",$3}'`
lastfile=`echo $filenum | awk 'END{print}' `
nextfile=$(($lastfile + 1))
if [ "$lastfile" -lt "009"  ]; then
nextname=`echo $origfile."00"$nextfile`
elif [[ "$lastfile" -ge "009" && "$lastfile" -lt "099"  ]]; then
nextname=`echo $origfile."0"$nextfile`
else [ "$lastfile" -ge "099"  ]
nextname=`echo $origfile.$nextfile`
fi
historylog=$backupdir$nextname
readlog=`cat $currentlog`
echo $readlog | jq -c '.[]'  > /dev/null 2>&1 
if [ $? -ne 0  ]
then
echo "" > $currentlog
else
cp $currentlog $historylog 
readlog=`cat $historylog`
	echo $readlog | jq -c '.[]'  > /dev/null 2>&1
	if [ $? -ne 0 ]
	then
	cp $currentlog $historylog
	else
	echo "" > $currentlog
	fi
fi
