#!/usr/local/bin/zsh
origlog=$1
backupdir=$2
consolename=$3
startdate=$4
starttime=$5
enddate=$6
endtime=$7
readlog=`cat $consolename`
echo $readlog | jq -c '.[]'  > /dev/null 2>&1
if [ $? -ne 0  ]
then
echo "" > $origlog
logdb=`cd $backupdir ; ls -l`
origname=`echo $logdb | awk 'NR>=3{printf"%s\n",$9}' | awk -F "0" '{printf"%s\n",$1}'|awk 'END{print}'`
filenum=`echo $logdb | awk 'NR>=2{printf"%s\n",$9}' | awk -F "." '{printf"%s\n",$3}'`
for num in `echo $filenum`
do
logs=`cd $backupdir ; cat $origname$num`
devices=`echo $logs | jq '.[]|.[] | .name'| sed 's:"::' | sed 's:"::'`
for dev in `echo $devices`
do
json=`echo $logs | jq  -c '.[]|.[]'`
grep=`echo $json | grep "$dev"`
json=`echo $grep | jq  -c '.[]'|awk 'NR==2{printf"%s",$1}'|jq -c '.[]|.[]|.[]'`
dates=`echo $grep | jq  -c '.[]'|awk 'NR==2{printf"%s",$1}'|jq -c '.[]|.[]|.[]|.Date'|sed 's:"::'|sed 's:"::'`
	for date in `echo $dates`
	do
	grep=`echo $json| grep "$date"`
	Times=`echo $grep | jq -c '.[]'|awk 'NR==2{printf"%s",$1}'|jq -c '.[]'| tr "\n" ","|sed 's:,$::'`
	./add-history.sh $dev $date $consolename $Times
	done
done
cd $backupdir ; rm $origname$num ; cd -
done
else
logdb=`cd $backupdir ; ls -l`
origname=`echo $logdb | awk 'NR>=3{printf"%s\n",$9}' | awk -F "0" '{printf"%s\n",$1}'|awk 'END{print}'`
filenum=`echo $logdb | awk 'NR>=2{printf"%s\n",$9}' | awk -F "." '{printf"%s\n",$3}'`
for num in `echo $filenum`
do
logs=`cd $backupdir ; cat $origname$num`
devices=`echo $logs | jq '.[]|.[] | .name'| sed 's:"::' | sed 's:"::'`
for dev in `echo $devices`
do
json=`echo $logs | jq  -c '.[]|.[]'`
grep=`echo $json | grep "$dev"`
json=`echo $grep | jq  -c '.[]'|awk 'NR==2{printf"%s",$1}'|jq -c '.[]|.[]|.[]'`
dates=`echo $grep | jq  -c '.[]'|awk 'NR==2{printf"%s",$1}'|jq -c '.[]|.[]|.[]|.Date'|sed 's:"::'|sed 's:"::'`
        for date in `echo $dates`
        do
        grep=`echo $json| grep "$date"`
        Times=`echo $grep | jq -c '.[]'|awk 'NR==2{printf"%s",$1}'|jq -c '.[]'| tr "\n" ","|sed 's:,$::'`
	./add-history.sh $dev $date $consolename $Times
        done
done
cd $backupdir ; rm $origname$num ; cd -
done
fi

