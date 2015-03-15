#!/usr/local/bin/zsh
currentlog=$1
origfile=`echo $1 | tr "/" "\n"|awk 'END{print}'`
filenum=`ls -l backupjson | awk 'NR>=2{printf"%s\n",$9}' | awk -F "." '{printf"%s\n",$3}'`
lastfile=`echo $filenum | awk 'END{print}' `
nextfile=$(($lastfile + 1))
nextname=`echo $origfile."00"$nextfile`
historylog=backupjson/$nextname
readlog=`cat $1`
echo $readlog | jq -c '.[]'  > /dev/null 2>&1 
if [ $? -ne 0  ]
then
echo "" > $1
else
cp $1 $historylog 
readlog=`cat $historylog`
	echo $readlog | jq -c '.[]'  > /dev/null 2>&1
	if [ $? -ne 0 ]
	then
	cp $1 $historylog
	else
	echo "" > $1
	fi
fi
