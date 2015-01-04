sub my_action {
###############
# Realtime Monitor
# (c) 2014 Günther Alka


my (@S, $I, $H );
$I=`iostat -x`;
@S=split(/\n/,$I);
$H=25*@S;
if ($H<251) { $H=250; }  # min height
if (!($cfg{'ver'}=~/c|m/)) { print "requires monitor extension!"; &log_end; exit;   }

print "<script language='javascript'>document.getElementById('hl').innerHTML='I/O Stat Realtime monitoring'</script>\n";


  ##############  stat ###################

   print <<EoF;

<div id='wsdata' style='position:absolute; top: 155px; left:5px; z-index:1100; color:#666666; font-size:10px'>connect to websocket-server..</div>
<table style='width:1200px'>

<tr><td>
     <!-- iostat r/w -->
     <canvas id="cvs1" width="1024" height="$H">[No canvas support]</canvas>

</td><td></tr>
     <!-- graph-height -->
     <canvas id="cvs2" width="1024" height="$H">[No canvas support]</canvas>
</td></tr>

</table>


<!-- iostat script -->
<script type="text/javascript">

    // iostat
    rgraph_iostat=function(data) {

           // reset or old values keep visible
           var canvas = document.getElementById('cvs1');
           RGraph.Reset(canvas);

           canvas = document.getElementById('cvs2');
           RGraph.Reset(canvas);

           // prepare data
           var adata=data.split(";");

           var alabels1=adata[2].split(",");     // labels1 (y-values=sd1,sd2)
           var alabels2=adata[6].split(",");     // labels1 (y-values=sd1,sd2)
           var n=alabels1.length;                 // number of devices

           var akeys1=adata[3].split(",");       // keys1  (x values=read,write)
           var akeys2=adata[7].split(",");       // keys2

           var data1=adata[4].split(":");         // data1
           var data2=adata[8].split(":");         // data2

           var adata1=new Array(n);              // array of data1 (array of arrays)
           var adata2=new Array(n);              // array of data2 diskdatas (array of arrays)

           var busy=adata[9];                    // busy
           var avbusy=adata[10];                 // busy 10s

           // diskdata: build array of arrays
           for (var i = 0; i < n; i++ ) {
                adata1[i] = data1[i].split(",");
           }

           // disk_avrg_data: build array of arrays
           for (var i = 0; i < n; i++ ) {
                adata2[i] = data2[i].split(",");
           }

           var hbar1 = new RGraph.HBar('cvs1',adata1)
               .Set('title', 'iostat: read/write per/s')
               .Set('title.size', '9')
               .Set('title.vpos', 0.5)

               .Set('gutter.top', 45)

               .Set('grouping', 'grouped')
               .Set('shadow', true)
               .Set('vmargin', 3)             // affects bar-thickness
               .Set('xmax', adata[1])          // x-range 1000, 2000,..
               .Set('labels', alabels1)
               .Set('key', akeys1 )

               .Set('key.position', 'gutter')
               .Set('key.position.gutter.boxed', false)
               .Set('key.colors', ['green','#c0ebc0','red','#fe9e9e'])
               .Set('colors', ['Gradient(#7ae472:green)',
                               'Gradient(#c0ebc0:#c0ebc0)',
                               'Gradient(#fa8973:red)',
                               'Gradient(#fbe3de:#ecbc91)'
                               ])
                .Draw(hbar1);



           // wait, await, w%, b%
           var hbar2 = new RGraph.HBar('cvs2', adata2 )
               .Set('title', 'iostat: wait/ w%/ b%  //CPU busy/10s_avrg = ' +busy +'%/ ' +avbusy +'%')
               .Set('title.size', '9')
               .Set('title.vpos', 0.5)
               .Set('gutter.top', 45)

               .Set('grouping', 'grouped')
               .Set('shadow', true)
               .Set('vmargin', 3)
               .Set('xmax', 100)        // x-range max
               .Set('xmin', 0)          // x-range min 0
               .Set('labels', alabels2)
               .Set('key', akeys2 )
               .Set('key.position', 'gutter')

               .Set('key.position.gutter.boxed', false)
               .Set('key.colors', ['red','#fcb39d','blue','green'])
               .Set('colors', ['Gradient(#fa8973:red)',
                               'Gradient(#fcb39d:#fcb39d)',
                               'Gradient(#bbc8fe:blue)',
                               'Gradient(#7ae472:green)'
                               ])
                .Draw(hbar2);
    }


</script>

EoF

} #/ my_action

1; 
