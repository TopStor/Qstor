#!/usr/local/bin/zsh
pass=$1
cd /scripts
git init 
git add *
git commit -a -m 'add'
git checkout -b hotfix
gpg -d -o /update.tar.gz /update.tar.gz.gpg
echo $? >> /dev/null
mv /update.tar.gz /scripts
tar -xvzf update.tar.gz
rm -rf update.tar.gz
git am *-update.patch
git checkout master
git merge hotfix
git branch -D hotfix
rm -rf .git
rm -rf *-update.patch
