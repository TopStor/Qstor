#!/usr/local/bin/zsh
cd /root/update
git format-patch -1
tar -cvzf /update.tar.gz *.patch
gpg --sign /update.tar.gz
mv /update.tar.gz.gpg /qstor.bin 
rm -rf *.patch /update.tar.gz
exit 0
