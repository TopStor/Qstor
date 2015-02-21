#!/usr/local/bin/zsh
cd /root/update
git add *
git commit -a -m 'add'
git format-patch -1
tar -cvzf /patches.tar.gz *.patch
rm -rf *.patch 
exit 0
