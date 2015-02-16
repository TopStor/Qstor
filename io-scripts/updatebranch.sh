#!/usr/local/bin/zsh
cd /scripts
git init 
git add *
git commit -a -m 'add'
git checkout -b hotfix
cp /*-update.patch /scripts
git am *-update.patch
git checkout master
git merge hotfix
git branch -D hotfix
rm -rf .git
rm -rf *-update.patch
