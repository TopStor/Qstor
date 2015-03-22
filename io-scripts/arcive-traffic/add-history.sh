#!/usr/local/bin/zsh
device=$1
date=$2
endlog=$3
oper=$4
searchdate1=`./searchdate-history.sh $device $date $endlog`
pre=`echo $searchdate1 | awk 'NR==1{printf"%s",$1}'`
post=`echo $searchdate1 | awk 'NR==3{printf"%s",$1}'`
search=`echo $searchdate1 | awk 'NR==2{printf"%s",$1}'`
search1=`echo $search | jq -c '.[]' |awk 'NR==2{printf"%s",$1}'|jq -c '.[]'`
echo $search1 | grep time > /dev/null 2>&1
if [ $? -ne 1 ]
then
search=`echo $search | sed "s/]}/,$oper]}/"`
afteradd=`echo -n $pre ; echo -n $search ; echo $post;`
searchdevice=`./searchdevice-history.sh $device $endlog`
pre=`echo $searchdevice | awk 'NR==1{printf"%s",$1}'`
post=`echo $searchdevice | awk 'NR==3{printf"%s",$1}'`
search=`echo $afteradd`
end=`echo -n $pre ; echo -n $search ; echo $post;`
echo $end > $endlog
else
search=`echo $search | sed "s/]}/$oper]}/"`
afteradd=`echo -n $pre ; echo -n $search ; echo $post;`
searchdevice=`./searchdevice-history.sh $device $endlog`
pre=`echo $searchdevice | awk 'NR==1{printf"%s",$1}'`
post=`echo $searchdevice | awk 'NR==3{printf"%s",$1}'`
search=`echo $afteradd`
end=`echo -n $pre ; echo -n $search ; echo $post;`
echo $end > $endlog
fi
