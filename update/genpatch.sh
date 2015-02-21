#!/usr/local/bin/zsh
cd /root/Qstor/update
git checkout update
git format-patch -1
tar -cvzf /patches.tar.gz *.patch
rm -rf *.patch 
exit 0
