#!/usr/local/bin/zsh
device=$1
oper=$2
logs=`cat currenttraffic.log`
json=`echo $logs | jq  -c '.[]'`
json1=`echo $json | jq -c '.[]'`
devstats=`echo $json1 | grep $device`
end=`echo $devstats | sed "s/]}/]},$oper/"`
add=`echo $end`
pre=`echo $json1 | grep -v $device`
json2=`echo "{\"device\":["$pre"\n"$add| tr "\n" ","|sed 's/,$/]}/'`
echo "=================== search =================="
echo $devstats
echo "===================== add ==================="
echo $add
echo "===================== collect ==================="
echo $json2
