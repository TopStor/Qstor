#!/usr/local/bin/zsh
cd /scripts
git init 
git add *
git commit -a -m 'add'
git checkout -b hotfix
mv /update.tar.gz /scripts
tar -xvzf update.tar.gz
rm -rf update.tar.gz
git am *-update.patch
git checkout master
git merge hotfix
git branch -D hotfix
rm -rf .git
rm -rf *-update.patch
