#!/usr/local/bin/zsh
logs=`cat ../currenttraffic.log`
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
echo " " > ../currenttraffic.log
