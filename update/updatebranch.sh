#!/usr/local/bin/zsh
gpg --verify /qstor.bin > /dev/null 2>&1
if [ $? = 0 ]
then
echo "Good Update File"
cd /scripts/freebsd-wifi-build/
git init > /dev/null 2>&1 
git checkout -b hotfix > /dev/null 2>&1
gpg -d -o /update.tar.gz /qstor.bin > /dev/null 2>&1
mv /update.tar.gz /scripts/freebsd-wifi-build/ > /dev/null 2>&1
tar -xvzf update.tar.gz > /dev/null 2>&1
rm -rf update.tar.gz > /dev/null 2>&1
git am *.patch > /dev/null 2>&1
git checkout master > /dev/null 2>&1
git merge hotfix > /dev/null 2>&1
if [ $? = 0 ]
then
echo "Update Successfully."
else
echo "Already up-to-date."
fi
git branch -D hotfix > /dev/null 2>&1
#rm -rf .git
rm -rf *.patch
else
echo "Bad Update File"
fi
