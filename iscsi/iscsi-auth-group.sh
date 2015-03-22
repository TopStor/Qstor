#!/usr/local/bin/zsh
ag=$1
types=$2
user=$3
secret=$4
mutualuser=$5
mutualsecret=$6
name=\"$7\"
portal=\"$8\"
conf=`cat /etc/ctl.conf`
pid=`echo "pidfile /var/run/ctld.pid"`
authg=`echo $conf | grep auth-group | grep { | awk -F" " '{printf"%s\n",$2}'`
portalg=`echo $conf | grep portal-group | grep { | awk -F" " '{printf"%s\n",$2}'`
targets=`echo $conf | grep target | grep { | awk -F" " '{printf"%s\n",$2}' | awk -F":" '{printf"%s\n",$2}'`
iqn=`echo $conf | grep target | grep { | awk -F" " '{printf"%s\n",$2}'| awk -F":" 'NR==1{printf"%s\n",$1}'`
echo $pid
echo echo $conf | grep auth-group | grep {  > /dev/null 2>&1
if [ $? -ne 0 ]; then
auth=`echo  "auth-group $ag {" `
	if [ "$types" = chap-mutual ]; then
		cont=`echo $types \"$user\" \"$secret\" \"$mutualuser\" \"$mutualsecret\"`
		initn=`echo "initiator-name" $name`
		initp=`echo  "initiator-portal" $portal`
	elif [ "$types" = chap ]; then
		cont=`echo $types \"$user\" \"$secret\"`
		initn=`echo "initiator-name" $name`
		initp=`echo  "initiator-portal" $portal`
	else
		echo "chose right auth method chap or chap-mutual"
	fi
end=`echo "}"`
auth=`echo $auth ; echo $cont ;echo $initn ; echo $initp ; echo $end`
else [ $? -eq 0 ];
	for ags in `echo $authg | grep -v $ag`
	do
		allauth=`echo $conf | sed -n "/auth-group $ags {/,/}/p"`
		echo $allauth
	done	
	auth=`echo $conf | sed -n "/auth-group $ag {/,/}/p"`
	echo $authg | grep "$ag" > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		if [ "$types" = chap-mutual ]; then
		echo $auth | grep chap-mutual > /dev/null 2>&1
			if [ $? -eq 0 ]; then
				auth=`echo $auth | awk -F"}" '{printf"%s\n" ,$1}'`
				cont=`echo $types \"$user\" \"$secret\" \"$mutualuser\" \"$mutualsecret\"`
				initn=`echo "initiator-name" $name`
				initp=`echo  "initiator-portal" $portal`
				end=`echo "}"`
				auth=`echo $auth ; echo $cont ;echo $initn ; echo $initp ; echo $end`
			else
			#	echo "Please use one auth method"
				auth=`echo $auth` 
			fi
		elif [ "$types" = chap ]; then
		echo $auth | grep mutual > /dev/null 2>&1
                       	if [ $? -ne 0 ]; then
                       		auth=`echo $auth | awk -F"}" '{printf"%s\n" ,$1}'`
                       		cont=`echo $types \"$user\" \"$secret\"`
				initn=`echo "initiator-name" $name`
				initp=`echo  "initiator-portal" $portal`
                                end=`echo "}"`
                                auth=`echo $auth ; echo $cont ;echo $initn ; echo $initp ; echo $end`
                       	else
                        #	echo "Please use one auth method"
				auth=`echo $auth `
                       	fi
		else
                #      	echo "chose right auth method chap or chap-mutual"
			auth=`echo $auth `
                fi
	else [ $? -ne 0 ]
		auth=`echo "auth-group $ag {" `
                if [ "$types" = chap-mutual ]; then
                       	cont=`echo $types \"$user\" \"$secret\" \"$mutualuser\" \"$mutualsecret\"`
			initn=`echo "initiator-name" $name`
			initp=`echo  "initiator-portal" $portal`
       	        elif [ "$types" = chap ]; then
                       	cont=`echo $types \"$user\" \"$secret\"`
			initn=`echo "initiator-name" $name`
			initp=`echo  "initiator-portal" $portal`
		else
                #      	echo "chose right auth method chap or chap-mutual"
               	fi
		end=`echo "}"`
                auth=`echo $auth ; echo $cont ;echo $initn ; echo $initp ; echo $end`
	fi
fi
echo $auth
for portalg in `echo $portalg`
do
	portal=`echo $conf | sed -n "/portal-group $portalg {/,/}/p"`
	echo $portal
done
for tgt in `echo $targets`
do
	target=`echo $conf | sed -n "/target $iqn:$tgt {/,/}/p"`
	echo $target
done
