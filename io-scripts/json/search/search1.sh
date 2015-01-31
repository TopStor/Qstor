#!/usr/local/bin/zsh
device=$1
oper=$2
logs=`cat currenttraffic.log`
json=`echo $logs | jq  -c '.[]'`
json1=`echo $json | jq -c '.[]'`
json1=`echo "{\"device\":[\n"$json1"\n""]}"`
search=`echo $json1 | grep $device`
pre=`echo $json1 | grep -B9999999 $device| grep -v $device | tr "\n" "," | sed 's:\[,:\[:'` 
post=`echo $json1 | grep -A9999999 $device| grep -v $device| tr "\n" ","|sed 's:^:,:'|sed 's:,]},$:]}:'|sed 's:]},$:]}:'`
echo "===================== pre ==================="
echo $pre
echo "=================== search =================="
echo $search
echo "===================== post ==================="
echo $post
