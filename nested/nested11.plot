set style data histogram
set style fill pattern

set border 3
set key left over

set xlabel "CINT Benchmarks" font ",20"
set xtics nomirror rotate by -45 \
    ("perlbench" 0, "bzip2" 1, "gcc" 2, "mcf" 3,\
    "gobmk" 4, "hmmer" 5, "sjeng" 6, "libquantum" 7, "h264ref" 8,\
    "omnetpp" 9, "astar" 10, "xalancbmk" 11, "AVG" 12)
set ylabel "L2/L1 Performance Radio" offset 2,0 font ",20"
set yrange [0:1]
set ytics nomirror 0.1
set grid y

set term postscript eps enhanced size 7.2in,2.2in
plot "nested11.txt" using 1 ti "Basic",\
     "" using 2 ti "Bypass" ls 1,\
     "" using 3 ti "PV VMCS" ls 1,\
     "" using 4 ti "Host EPT" ls 1 fs p 4,\
     "" using 5 ti "Host/Virtual EPT" ls 1 fs p 5,\
     "" using 6 ti "Host/Virtual EPT + PV VMCS" ls 1 fs p 6
