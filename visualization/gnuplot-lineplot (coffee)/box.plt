#!/usr/bin/env gnuplot

set terminal jpeg large size 800,500 enhanced
set output 'boxplot.jpg'

set style fill solid 0.2 border -1

# set border 2
set ytics nomirror
set xtics nomirror

set key outside

set xrange[0.8:3.2]
set yrange[1:5]

set grid ytics lc rgb "#DEDEDE"

set xtics ("Yellow Bourbon" 1, "Timor Hybrid" 2, "Pacamara" 3) scale 0.0
set xtics nomirror
set ytics nomirror

set xlabel 'Coffee'
set ylabel 'Buy intention'


plot  "data.dat" using 1:2 title 'Hario V-60' with linespoints lw 1 pointtype 5 ps 1.4,\
      "data.dat" using 1:4 title 'Conventional brewed' with linespoints lw 1 pointtype 7 ps 1.4,\
      "data.dat" using 1:6 title 'French Press' with linespoints lw 1 pointtype 9 ps 1.4,\
      "data.dat" using 1:8 title 'Espresso' with linespoints lw 1 pointtype 13 ps 1.4
