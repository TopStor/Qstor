#!/usr/local/bin/zsh
cd /
tar -xvzf test.tar.gz > /dev/null 2&>1
lsawk=`ls -l /test | awk -F" " '{printf("%s\n",$9)}'`
for n in `echo $lsawk`
do
find=`find /root/scripts1 -iname $n`
for i in `echo $find`
do 
mv /test/"$n" "$i"
done
done
