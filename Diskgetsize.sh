#! /usr/local/bin/zsh
# needed the operands to be like : one:two:three:four
size=0;
for disk in "$@"
do
x=`diskinfo -v $disk | sed -n -e 3p | awk '{print $1}'`;
y=$(($x/1024/1024/1024));
size=$(($size+$y));
done
echo $size
