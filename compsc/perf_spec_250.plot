set boxwidth 0.3
set style data histogram
set style histogram rowstacked gap 6
set style fill pattern

set key box left top

set border 11
set xtics nomirror ("VF orig" 0, "VF+comp" 1, "VF+comp+int" 2)
set ylabel "Total Requests" offset 2,0
set yrange [0:14000]
set ytics nomirror
set y2label "CPU utilization (%)" offset -1,0
set y2range [0:50]
set y2tics autofreq

set term postscript eps enhanced size 3in,2.25in

plot "perf_spec_250.txt" using 1 ti "Good" lc 7 lt 1,\
	"" using 2 ti "Tolerable" lc 7 lt 1,\
	"" using 3 ti "Fail" lc 7 lt 1,\
	"" using 4 axis x1y2 ti "CPU%" with linespoints lc 7
