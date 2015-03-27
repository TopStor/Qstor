#!/usr/local/bin/zsh
url=$1
mkdir -p /usr/local/etc/pkg/repos
echo "FreeBSD: { enabled: no }" > /usr/local/etc/pkg/repos/FreeBSD.conf
echo "REPONAME: { url: "$url"}" > /usr/local/etc/pkg/repos/REPONAME.conf
