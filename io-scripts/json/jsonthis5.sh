#! /usr/local/bin/zsh
# needed the operands to be like : one vaule1 two value2 three value3 four value4
if [ $# -lt 1 ]
then
  echo "diskname argument not specified!"
  exit
fi
Device=$1;
output=`./script6.sh $Device | awk -F"|" 'NR==1{printf("%s%s%s%s%s%s%s%s",$1,$2,$3,$4,$5,$6,$7,$8)}'`;
name=`echo $output|awk '{printf $1}'`;
Date=`echo $output|awk '{printf $2}'`;
Time=`echo $output|awk '{printf $3}'`;
bw=`echo $output|awk '{printf $4}'`;
rs=`echo $output|awk '{printf $5}'`;
ws=`echo $output|awk '{printf $6}'`;
svct=`echo $output|awk '{printf $7}'`;
qlen=`echo $output|awk '{printf $8}'`;
oper=($(echo ${name});$(echo ${Date});$(echo ${Time}) ;$(echo ${bw}) ;$(echo ${rs}) ;$(echo ${ws}) ;$(echo ${svct}) ;$(echo ${qlen}));
title=`echo '{"name":"'$name'","stats":[{"Dates":[{"Date":"'$Date'","times":['`;
echo $title;
streamo=`echo '{"time":"'$oper[3]'","bw":'$oper[4]'","rs":'$oper[5]'","ws":'$oper[6]'","svct":'$oper[7]'","qlen":'$oper[8]'"'`;
streamo=`echo $streamo"},"`;
echo $streamo"]}]}]}";
