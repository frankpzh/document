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

set arrow 1 from 3,550 to 3.4,300
set label 1 "Migration start" at 3,550 right
set arrow 2 from 17.5,900 to 20.45,850
set label 2 "Short service down" at 17.5,900 right
set arrow 3 from 22.3,800 to 21,740
set label 3 "Service down" at 22.3,800 left
set arrow 4 from 23.3,645 to 22.65,620
set label 4 "Service up" at 23,670 left

plot "migdata/pv_tp.txt" using (sec($0)):(tp($1)) ti "Throughput" with lines lw 5,\
     "migdata/pv_cpu.txt" using (sec($0)):(cpu($1)) axis x1y2 ti "CPU%" with lines lw 5
