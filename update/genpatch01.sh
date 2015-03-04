#!/usr/local/bin/zsh
cd /root/scripts
mkdir /test
edite=`git diff --name-only master`
for n in `echo $edite`
do
cp "$n" /test/
tar -cvzf /test.tar.gz /test > /dev/null 2>&1
done
rm -rf /test
#################### encription ###################
