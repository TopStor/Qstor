#!/usr/local/bin/zsh
device=$1
logs="currenttraffic.log"
awk=`awk -F"]}]}," '{for(i=1;i<=NF;i++){print $i"]}]}]}"}}' $logs `
#json1=`echo $json | jq -c '.[]'`
#json=`echo $awk | grep $device`
#if [ $device = ad0 ]
#then
#json=`echo $json | jq  -c '.[]|.[]'`
#pre='{"device":['
#fi
#pre=`for (( i=1;i<=1000;i++ )); do echo $awk | grep -Ai $device ; done `
#end=`echo $json | sed "s/]}/]},$oper/"`
#add=`echo $end`
#json=`echo $json | jq  -c '.[]'`
#echo $devstats
#pre=`echo $awk | grep -v $device`
#pre=`echo  $json ; echo $pre `
#pre=`echo $pre | jq -c '{device:[.]}'`
echo "================ pre ===================="
echo $pre
echo "================= search ================" 
echo $json
