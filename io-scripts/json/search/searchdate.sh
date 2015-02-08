#!/usr/local/bin/zsh
device=$1
date=$2
search1=`./searchdevice.sh $device`
search1=`echo $search1 | awk 'NR==2{printf"%s",$1}'`
json=`echo $search1 | jq -c '.[]'| awk 'NR==2{printf"%s",$1}'|jq -c '.[]|.[]|.[]'`
json1=`echo "{\"name\":\"$device\",\"stats\":[{\"Dates\":[\n"$json"\n]}]}"`
search=`echo $json1 | grep $date`
pre=`echo $json1 | grep -B99999999 $date| grep -v $date | tr "\n" "," | sed 's:\[,:\[:'` 
post=`echo $json1 | grep -A99999999 $date| grep -v $date| tr "\n" ","|sed 's:^:,:'|sed 's:,]}]},$:]}]}:'`
#echo "===================== pre ==================="
echo $pre
#echo "=================== search =================="
echo $search
#echo "===================== post ==================="
echo $post
