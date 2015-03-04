#!/usr/local/bin/zsh
cd /root/update
git format-patch -100 HEAD --stdout > 0001-last-100-commits.patch
tar -cvzf /update.tar.gz *.patch
gpg --sign /update.tar.gz
mv /update.tar.gz.gpg /qstor.bin 
rm -rf *.patch /update.tar.gz
