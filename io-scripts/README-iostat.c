################
you should copy iostat.c in this path
cp iostat.c /usr/src/usr.sbin/iostat/iostat.c

or edite this lines in orignal file
   742			/*printf("                        extended device statistics  ");*/
   743			if (Tflag > 0)
   744				printf("      tty ");
   745			if (Cflag > 0)
   746				printf("           cpu ");
   747			/*printf("\n");*/
   748			if (Iflag == 0) {
   749				/*printf("device     r/s   w/s    kr/s    kw/s qlen "
   750				    "svc_t  %%b  ");*/
   751			} else {
   752				printf("device           r/i         w/i         kr/i"
   753				    "         kw/i qlen   tsvc_t/i      sb/i  ");
   754			}
   755			if (Tflag > 0)
   756				printf("tin  tout ");
   757			if (Cflag > 0)
   758				printf("us ni sy in id ");
   759			/*printf("\n");*/

after edite this file run in [/usr/src/usr.sbin/iostat/]  dir
make && make install

just you will get the perfect output .
#################
