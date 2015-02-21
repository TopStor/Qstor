#!/usr/local/bin/zsh
cd /root/update
git add *
git commit -a -m 'update'
git format-patch -1
tar -cvzf /update.tar.gz *.patch
rm -rf *.patch 
exit 0
