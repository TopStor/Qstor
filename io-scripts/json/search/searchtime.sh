#!/usr/local/bin/zsh
device=$1
date=$2
Time=$3
search2=`./searchdate.sh $device $date`
search2=`echo $search2 | awk 'NR==2{printf"%s",$1}'`
json=`echo $search2 | jq -c '.[]'| awk 'NR==2{printf"%s",$1}'|jq -c '.[]'`
json1=`echo "{\"Date\":\"$date\",\"times\":[\n"$json"\n]}"`
search=`echo $json1 | grep $Time`
pre=`echo $json1 | grep -B99999999 $Time| grep -v $Time | tr "\n" "," | sed 's:\[,:\[:'` 
post=`echo $json1 | grep -A99999999 $Time| grep -v $Time| tr "\n" ","|sed 's:^:,:'|sed 's:,]},$:]}:'`
#echo "===================== pre ==================="
echo $pre
#echo "=================== search =================="
echo $search
#echo "===================== post ==================="
echo $post
