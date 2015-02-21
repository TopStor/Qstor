#!/usr/local/bin/zsh
strstart=$1
strend=$2
file=$3
grepstart=`grep -B99999999 $strstart $file | grep -v $strstart`
grepend=`grep -A99999999 $strend $file | grep -v $strend`
echo $grepstart
echo $grepend
