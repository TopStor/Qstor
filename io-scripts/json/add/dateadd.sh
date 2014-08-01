#! /usr/local/bin/zsh
str=$@
str="$str"
oper=($(echo ${str}));
end=`sed "s/]}/]},$oper/" currenttmp.log`
echo $end > currenttmp.log 
