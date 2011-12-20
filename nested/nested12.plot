set style data histogram
set style fill pattern

set border 3
set key left over

set xlabel "CFP Benchmarks" font ",20"
set xtics nomirror rotate by -45 \
    ("bwaves" 0, "gamess" 1, "milc" 2, "zeusmp" 3, "gromacs" 4,\
    "cactusADM" 5, "leslie3d" 6, "namd" 7, "dealll" 8, "soplex" 9,\
    "povray" 10, "calculix" 11, "GemsFDTD" 12, "tonto" 13, "lbm" 14,\
    "wrf" 15, "sphinx3" 16, "AVG" 17)
set ylabel "L2/L1 Performance Radio" offset 2,0 font ",20"
set yrange [0:1]
set ytics nomirror 0.1
set grid y

set term postscript eps enhanced size 7.2in,2.2in
plot "nested12.txt" using 1 ti "Basic",\
     "" using 2 ti "Bypass" ls 1,\
     "" using 3 ti "PV VMCS" ls 1,\
     "" using 4 ti "Host EPT" ls 1 fs p 4,\
     "" using 5 ti "Host/Virtual EPT" ls 1 fs p 5,\
     "" using 6 ti "Host/Virtual EPT + PV VMCS" ls 1 fs p 6
