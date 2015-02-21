#!/usr/local/bin/zsh
cd /root/update
git checkout -b hotfix
tar -xvzf *.tar.gz
rm -rf *.tar.gz
git add *
git commit -a -m 'Update commit'
git checkout master
git merge hotfix 
git commit -a -m 'v1.1'
git branch -D hotfix
exit 0
