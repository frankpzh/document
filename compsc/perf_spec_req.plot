set style data histogram
set style fill pattern

set key box left top

set border 3
set xlabel "Sessions"
set xtics nomirror ("50" 0, "100" 1, "150" 2, "200" 3, "250" 4)
set ylabel "Good Requests" offset 2,0
set yrange [0:10000]
set ytics nomirror

set term postscript eps enhanced size 3in,2.25in
set output "perf_spec_req.eps"

plot "perf_spec_req.txt" using 2 ti "VF orig reqs" lc 7 lt 1,\
	"" using 5 ti "VF+comp reqs" lc 7 lt 1,\
	"" using 8 ti "VF+comp+int reqs" lc 7 lt 1