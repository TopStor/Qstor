#!/usr/local/bin/zsh
device=$1
logs=`cat currenttraffic.log`
json=`echo $logs | jq  -c '.[]'`
json1=`echo $json | jq -c '.[]'`
devstats=`echo $json1 | grep $device`
echo $devstats
