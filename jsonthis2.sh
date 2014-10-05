#! /usr/local/bin/zsh
# needed the operands to be like : one vaule1 two value2 three value3 four value4
oper=($@);
streamo=`echo '{"'$oper[1]'":"'$oper[2]`;
for (( c=3;c<$#;c+=2 ));
do
	streamo=`echo $streamo,'"'$oper[$c]'"':'"'$oper[$(($c+1))]'"'`;
done
streamo=`echo $streamo"}"`;
echo $streamo;
