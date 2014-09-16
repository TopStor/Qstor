#! /usr/local/bin/zsh
# needed the operands to be like : one:two:three:four
list=$1;
list2=`echo $list | sed 's/:/:o","/g'| sed 's/:/":"/g'`;
list4=`echo '{"'$list2'":"o"}'`
echo $list4;
