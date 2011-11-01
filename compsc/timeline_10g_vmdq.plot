set key box left top

set xlabel "Time (s)"
set xrange [0:25]
set xtics nomirror 1
set ylabel "Throughput (Gb/s)" offset 2,0
set yrange [0:10]
set ytics nomirror
set y2label "CPU utilization (%)" offset -1,0
set y2range [0:400]
set y2tics autofreq

sec(x)=x/10
cpu(x)=x/1000000
tp(x)=x/100

set term postscript eps enhanced size 6.5in,2in

set arrow 1 from 8,4 to 10.7,2.3
set label 1 "Migration start" at 8,4 right
set arrow 3 from 19,3.5 to 20.7,3.5
set label 3 "Service down" at 19,3.5 right
set arrow 4 from 22.5,2 to 21.7,3.2
set label 4 "Service up" at 22.5,2 left

plot "migdata/10g_vmdq_tp.txt" using (sec($0)):(tp($1)) ti "Throughput" with lines lw 5,\
     "migdata/10g_vmdq_cpu.txt" using (sec($0)):(cpu($1)) axis x1y2 ti "CPU%" with lines lw 5
