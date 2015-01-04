#!/usr/local/bin/zsh
#Drow I/O Stat on FreeBSD
if [ "$1" = "config" ]; 
	then
		echo 'I/O Stat by bytes'
		echo 'graph args --base 1024 -l 0'
		echo 'graph vlabel MB per ${graph_period} read+written'
		echo 'graph category disk'
		echo 'graph info This graph shows the I/O to and from block devices'

    		drives=`/usr/sbin/iostat -I -x | 
			awk '/^device/ { next; } // { print $1; }' | 
			awk '/extended/ { next; } // { print $1; }'`
    			echo -n 'graph order'

    		for d in $drives; do
       			echo -n ' '${d}' read '${d}' write'
    		done

    		echo
    		for d in $drives; do
       			echo "${d} read-label ${d}"
       			echo "${d} read-type DERIVE"
       			echo "${d} read-min 0"
       			echo "${d} read-graph no"
       			echo "${d} write-label ${d}"
       			echo "${d} write-info I/O on device ${d}"
       			echo "${d} write-type DERIVE"
       			echo "${d} write-min 0"
       			echo "${d} write-negative ${d}_read"
    		done
exit 0
fi

/usr/sbin/iostat -I -x |
	awk '/^device/ { next; } //'  | 
	awk '/extended/ { next; } //' |
	awk ' {print $1 " read-value " int($4); print $1 " write-value " int($5);}'
