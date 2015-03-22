#!/usr/local/bin/zsh
device=$1
date=$2
logs=$3
search1=`./searchdevice-history.sh $device $logs`
search1=`echo $search1 | awk 'NR==2{printf"%s",$1}'`
dates=`echo $search1 | jq -c '.[]'| awk 'NR==2{printf"%s",$1}'|jq -c '.[]|.[]|.[]|.Date'| sed 's:"::' | sed 's:"::'`
json=`echo $search1 | jq -c '.[]'| awk 'NR==2{printf"%s",$1}'|jq -c '.[]|.[]|.[]'`
echo $dates | grep $date > /dev/null 2>&1
if [ $? -ne 1 ]
then
json1=`echo "{\"name\":\"$device\",\"stats\":[{\"Dates\":[\n"$json"\n]}]}"`
echo $json1 |grep $date | grep "times" > /dev/null 2>&1
	if [ $? -ne 1 ]
	then
	search=`echo $json1 | grep $date`
	else
	search=`echo  "{\"Date\":\"$date\",\"times\":[]}"`
	fi
search=`echo $search`
pre=`echo $json1 | grep -B99999999 $date| grep -v $date | tr "\n" "," | sed 's:\[,:\[:'` 
post=`echo $json1 | grep -A99999999 $date| grep -v $date| tr "\n" ","|sed 's:^:,:'|sed 's:,]}]},$:]}]}:'`
echo $pre
echo $search
echo $post
else
json=`echo $json`
pre=`echo "{\"name\":\"$device\",\"stats\":[{\"Dates\":[\n"$json"\n"|tr "\n" ","| sed 's:\[,:\[:' | sed 's:\]},,:]},:'| sed 's:\[,,:[:' `
search=`echo "{\"Date\":\"$date\",\"times\":[]}"`
post=`echo "]}]}"`
echo $pre
echo $search
echo $post
fi
