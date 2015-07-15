#!/usr/local/bin/zsh
origlog=$1
backupdir=$2
consolename=$3
startdate=$4
starttime=$5
enddate=$6
endtime=$7
lsbakdir=`cd $backupdir ; ls -lD "%d/%m/%Y"\|"%H:%M:%S" $origlog*`
ld=`echo $lsbakdir | grep -A9999 $startdate | grep -B9999 $enddate`
lt=`echo $ld | grep -A9999 $starttime | grep -B9999 $endtime`
readlog=`cat $consolename`
echo $readlog | jq -c '.[]'  > /dev/null 2>&1
if [ $? -ne 0  ]
then
echo "" > $consolename
origname=`echo $lt | awk 'NR>=1{printf"%s\n",$7}' | awk -F "0" '{printf"%s\n",$1}'|awk 'END{print}'`
filenum=`echo $lt | awk 'NR>=1{printf"%s\n",$7}' | awk -F "." '{printf"%s\n",$3}'`
for num in `echo $filenum`
do
echo $num
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
done
else
origname=`echo $lt | awk 'NR>=1{printf"%s\n",$7}' | awk -F "0" '{printf"%s\n",$1}'|awk 'END{print}'`
filenum=`echo $lt | awk 'NR>=1{printf"%s\n",$7}' | awk -F "." '{printf"%s\n",$3}'`
for num in `echo $filenum`
do
echo $num
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
done
fi

