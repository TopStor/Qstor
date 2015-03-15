#!/usr/local/bin/zsh
readlog=`cat backupjson/currenttraffic.log`
echo $readlog | jq -c '.[]'  > /dev/null 2>&1
if [ $? -ne 0  ]
then
echo "" > backupjson/currenttraffic.log
filenum=`ls -l backupjson/currenttraffic.log.* | awk 'NR>=2{printf"%s\n",$9}' | awk -F "." '{printf"%s\n",$3}'`
for num in `echo $filenum`
do
logs=`cat backupjson/currenttraffic.log.$num`
devices=`echo $logs | jq '.[]|.[] | .name'| sed 's:"::' | sed 's:"::'`
dates=`echo $logs | jq -c '.[]|.[]' | grep ad0 | jq -c '.[]'|awk 'NR==2{printf"%s",$1}'|jq -c '.[]|.[]|.[]| .Date'`
for dev in `echo $devices`
do
json=`echo $logs | jq  -c '.[]|.[]'`
grep=`echo $json | grep "$dev"`
json=`echo $grep | jq  -c '.[]'|awk 'NR==2{printf"%s",$1}'|jq -c '.[]|.[]|.[]'`
date=`echo $grep | jq  -c '.[]'|awk 'NR==2{printf"%s",$1}'|jq -c '.[]|.[]|.[]|.Date'|sed 's:"::'|sed 's:"::'`
	for date in `echo $date`
	do
	grep=`echo $json| grep "$date"`
	Times=`echo $grep | jq -c '.[]'|awk 'NR==2{printf"%s",$1}'|jq -c '.[]'| tr "\n" ","|sed 's:,$::'`
	./add-history.sh $dev $date $Times
	done
done
done
rm  backupjson/currenttraffic.log.*
else
filenum=`ls -l backupjson/currenttraffic.log.* | awk 'NR>=2{printf"%s\n",$9}' | awk -F "." '{printf"%s\n",$3}'`
for num in `echo $filenum`
do
logs=`cat backupjson/currenttraffic.log.$num`
devices=`echo $logs | jq '.[]|.[] | .name'| sed 's:"::' | sed 's:"::'`
dates=`echo $logs | jq -c '.[]|.[]' | grep ad0 | jq -c '.[]'|awk 'NR==2{printf"%s",$1}'|jq -c '.[]|.[]|.[]| .Date'`
for dev in `echo $devices`
do
json=`echo $logs | jq  -c '.[]|.[]'`
grep=`echo $json | grep "$dev"`
json=`echo $grep | jq  -c '.[]'|awk 'NR==2{printf"%s",$1}'|jq -c '.[]|.[]|.[]'`
date=`echo $grep | jq  -c '.[]'|awk 'NR==2{printf"%s",$1}'|jq -c '.[]|.[]|.[]|.Date'|sed 's:"::'|sed 's:"::'`
        for date in `echo $date`
        do
        grep=`echo $json| grep "$date"`
        Times=`echo $grep | jq -c '.[]'|awk 'NR==2{printf"%s",$1}'|jq -c '.[]'| tr "\n" ","|sed 's:,$::'`
        ./add-history.sh $dev $date $Times
        done
done
done
rm  backupjson/currenttraffic.log.*
fi

