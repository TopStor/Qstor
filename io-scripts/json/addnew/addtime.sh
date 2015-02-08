#!/usr/local/bin/zsh
device=$1
date=$2
oper=$3
searchdate1=`cd ../search/ && ./searchdate.sh $device $date && cd -`
pre=`echo $searchdate1 | awk 'NR==1{printf"%s",$1}'`
post=`echo $searchdate1 | awk 'NR==3{printf"%s",$1}'`
search=`echo $searchdate1 | awk 'NR==2{printf"%s",$1}'`
search=`echo $search | sed "s:}]}:,$oper]}:"`
afteradd=`echo -n $pre ; echo -n $search ; echo $post;`
searchdevice=`cd ../search/ && ./searchdevice.sh $device  && cd -`
pre=`echo $searchdevice | awk 'NR==1{printf"%s",$1}'`
post=`echo $searchdevice | awk 'NR==3{printf"%s",$1}'`
search=`echo $afteradd`
end=`echo -n $pre ; echo -n $search ; echo $post;`
echo $end
