#! /usr/local/bin/zsh
# needed the operands to be like : one vaule1 two value2 three value3 four value4
if [ $# -lt 1 ]
then
  echo "diskname argument not specified!"
  exit
fi

Device=$1;
output=`./script6.sh $Device | awk -F"|" 'NR==1{printf("%s%s%s%s%s%s%s%s",$1,$2,$3,$4,$5,$6,$7,$8)}'`;
str=$(echo $output);
#str=$@;
oper=($(echo ${str}));
n=`echo ${#oper[@]}`
streamo=`echo '{"'$oper[1]'":"'$oper[2]'"'`;
for (( c=3;c<$n;c+=2 ));
do
        streamo=`echo $streamo,'"'$oper[$c]'"':'"'$oper[$(($c+1))]'"'`;
done
streamo=`echo $streamo"}"`;
echo $streamo ;

