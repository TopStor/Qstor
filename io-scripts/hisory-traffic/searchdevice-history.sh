#!/usr/local/bin/zsh
device=$1
#device=`echo $device`
logs=`cat historytraffic.log`
devices=`echo $logs | jq '.[]|.[] | .name'| sed 's:"::' | sed 's:"::'`
json=`echo $logs | jq  -c '.[]'`
json1=`echo $json | jq -c '.[]'`
json2=`echo "{\"device\":[\n"$json1"\n]}"`
echo $devices | grep "$device"  > /dev/null 2>&1 
if [ $? -ne 1 ]
then
search=`echo $json2 | grep "$device"`
pre=`echo $json2 | grep -B99999999 "$device"| grep -v "$device" | tr "\n" "," | sed 's:\[,:\[:'` 
post=`echo $json2 | grep -A99999999 "$device"| grep -v "$device"| tr "\n" ","|sed 's:^:,:'|sed 's:,]},$:]}:'`
echo $pre
echo $search
echo $post
else
json2=`echo "{\"device\":[\n"$json1"\n"`
pre=`echo $json2 |tr "\n" "," | sed 's:\[,:\[:'`
search=`echo "{\"name\":\"$device\",\"stats\":[]}"`
post=`echo "]}"`
echo $pre
echo $search
echo $post
fi
