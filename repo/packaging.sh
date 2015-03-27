#!/bin/sh
path=$1
user=$2
serveraddr=$3
target=$4
#mkdir $path
#cd $path ; pkg create -a ; cd -
#cd $path ; tar cvjf packages.tar.bz2 . ; cd -
cd $path ; scp packages.tar.bz2 "$user"@"$serveraddr":"$target" ;cd -
