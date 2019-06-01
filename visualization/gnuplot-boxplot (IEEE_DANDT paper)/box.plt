#!/usr/bin/env gnuplot

set terminal epslatex size 4,3 standalone monochrome
set output 'boxplot.tex'

set style fill solid 0.5 border -1
set style boxplot outliers pointtype 7
set style data boxplot
set boxwidth  0.5
set pointsize 0.5

unset key
# set border 2
set ytics nomirror
set xtics nomirror

set grid ytics

set xtics ("OSA" 1, "SSA" 2) scale 0.0
set xtics nomirror
set ytics nomirror

set ylabel '\# points'

set yrange[0:300]


plot "points.dat" using (1):1 lt 1 pointtype 7,\
     "points.dat" using (2):2 lt 1 pointtype 7

unset output

set output # finish the current output file
system('pdflatex --interaction=batchmode boxplot.tex')
unset terminal
