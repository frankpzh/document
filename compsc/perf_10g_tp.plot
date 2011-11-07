set style fill pattern
set style histogram clustered gap 6 title
set style data histogram

set key box left top

set xtics nomirror ("scp" 0, "netperf" 1)
set ytics nomirror
set ylabel "Throughput (Gbps)" offset 2,0
set yrange [0:10]
set y2tics
set y2label "CPU utilization (%)"
set y2range [0:400]

m2g(x)=x/1000

set term postscript eps enhanced size 3in,2.25in

plot [-0.5:1.5]\
     'perf_10g_tp.txt' using (m2g($1)) title "Dom0 TP" fs p 0 lc 7 lt 1,\
     '' using (m2g($2)) title "VF orig TP" fs p 1 lc 7 lt 1,\
     '' using (m2g($3)) title "VF+comp TP" fs p 2 lc 7 lt 1,\
     '' using (m2g($4)) title "VF+comp+int TP" fs p 4 lc 7 lt 1,\
     'perf_10g_tp_cpu.txt' using 1 axis x1y2 ti "Dom0 CPU" with linespoints,\
     '' using 2 axis x1y2 ti "VF orig CPU" with linespoints,\
     '' using 3 axis x1y2 ti "VF+comp CPU" with linespoints,\
     '' using 4 axis x1y2 ti "VF+comp+int CPU" with linespoints
