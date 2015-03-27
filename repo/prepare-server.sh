#!/bin/sh
path=$1
url=$2
cd $path ; tar xvjf packages.tar.bz2 ; cd -
cd $path ; pkg repo . ; cd -
