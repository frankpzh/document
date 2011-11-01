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
tp(x)=x/100

set term postscript eps enhanced size 6.5in,2in

set arrow 1 from 5,7 to 7.8,6
set label 1 "Migration start" at 5,7 right
set arrow 3 from 20.5,1 to 22,1
set label 3 "Service down" at 20.5,1 right
set arrow 4 from 24,5 to 23.7,2.1
set label 4 "Service up" at 23.5,5.3 center

plot "migdata/10g_pv_tp.txt" using (sec($0)):(tp($1)) ti "Throughput" with lines lw 5,\
     "migdata/10g_pv_cpu.txt" using (sec($0)):($1) axis x1y2 ti "CPU%" with lines lw 5
