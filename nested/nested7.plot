set style data histogram
set style fill pattern

set border 3

set xlabel "Total PF and PF Breakdown" font ",20"
set xtics nomirror ("Total PF" 0, "L0 shadow PF" 1, "L1 shadow PF" 2, "L2 PF" 3)
set ylabel "Page Fault Event Number" offset 2,0 font ",20"
set yrange [0:1000000]
set ytics nomirror 100000 format "%.0f"

set term postscript eps enhanced
plot "nested7.dat" using 1 ti "Original",\
     "" using 2 ti "Bypass" ls 1