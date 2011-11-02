set key box at 4.7,9.3

set xlabel "Time (s)"
set xrange [0:25]
set xtics nomirror 1
set ylabel "Throughput (Gbps)" offset 2,0
set ytics nomirror
set y2label "CPU utilization (%)" offset -1,0
set y2range [0:400]
set y2tics autofreq

sec(x)=x/10
tp(x)=x/100

set term postscript eps enhanced size 6.5in,2in

set arrow 1 from 3.5,2 to 5.4,1.8
set label 1 "Migration start" at 3.5,2 right
set arrow 2 from 22.2,8.4 to 21,8
set label 2 "Service down" at 22.2,8.4 left
set arrow 3 from 22.8,7.5 to 22.1,7.3
set label 3 "Service up" at 22.8,7.5 left

plot "migdata/10g_compsc_tp.txt" using (sec($0)):(tp($1)) ti "Throughput" with lines lw 5,\
     "migdata/10g_compsc_cpu.txt" using (sec($0)):($1) axis x1y2 ti "CPU%" with lines lw 5
