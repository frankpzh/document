set key box right top

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

set term postscript eps enhanced size 6.5in,2in

set arrow 1 from 2,500 to 2.65,150
set label 1 "Hot unplug" at 2.3,530 right
set arrow 2 from 3,700 to 4.3,600
set label 2 "Migration start" at 3,700 right
set arrow 3 from 18,150 to 19.4,150
set label 3 "Service down" at 18,150 right
set arrow 4 from 22,100 to 20.7,100
set label 4 "Service up" at 22,100 left

plot "migdata/bond_tp.txt" using (sec($0)):(tp($1)) ti "Throughput" with lines lw 5,\
     "migdata/bond_cpu.txt" using (sec($0)):(cpu($1)) axis x1y2 ti "CPU%" with lines lw 5
