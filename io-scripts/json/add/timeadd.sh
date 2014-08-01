#! /usr/local/bin/zsh
str=${@}
oper=($(echo ${str}));
end=`sed "s/]/,$oper]/" currenttmp.log`
echo $end > currenttmp.log
