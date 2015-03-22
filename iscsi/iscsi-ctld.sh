#!/usr/local/bin/zsh
ag=$1
type=$2
user=$3
secret=$4
pg=$5
addr=$6
lun=$7
size=$8
path=$9
tgt=$10
echo "	pidfile /var/run/ctld.pid
	auth-group $ag {
		$type $user $secret
	}
        portal-group	$pg {
		discovery-auth-group no-authentication
		listen	$addr
	  
        }
        target iqn.2015-03.qstor.com:$tgt {
		auth-group $ag 
		portal-group $pg
		lun $lun {
		     path $path
		     size $size"G"
		}
	}" > /etc/ctl.conf
