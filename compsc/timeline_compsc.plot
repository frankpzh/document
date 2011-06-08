set key box left top

set xlabel "Time (s)"
set xrange [0:25]
set xtics nomirror 1
set ylabel "Throughput (Mb/s)" offset 2,0
set ytics nomirror
set y2label "CPU utilization (%)" offset -1,0
set y2range [0:400]
set y2tics autofreq

sec(x)=x/10
cpu(x)=x/1000000
tp(x)=x/100000*8

set term postscript eps enhanced size 6.5in,2.25in
set output "timeline_compsc.eps"

set arrow 1 from 3,200 to 4.9,100
set label 1 "Migration start" at 3,200 right
set arrow 2 from 20,850 to 21.65,900
set label 2 "Service down" at 20,850 right
set arrow 3 from 20,750 to 22.9,850
set label 3 "Service up" at 20,750 right

plot "migdata/compsc_tp.txt" using (sec($0)):(tp($1)) ti "Throughput" with lines lw 5,\
     "migdata/compsc_cpu.txt" using (sec($0)):(cpu($1)) axis x1y2 ti "CPU%" with lines lw 5
