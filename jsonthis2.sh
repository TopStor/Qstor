#! /usr/local/bin/zsh
# needed the operands to be like : one vaule1 two value2 three value3 four value4
str=$@;
oper=($(echo ${str}));
n=`echo ${#oper[@]}`
streamo=`echo '{"'$oper[2]'":"'$oper[1]'"'`;
for (( c=3;c<$n;c+=2 ));
do
	streamo=`echo $streamo,'"'$oper[$(($c+1))]'"':'"'$oper[$c]'"'`;
done
streamo=`echo $streamo"}"`;
echo $streamo ;
