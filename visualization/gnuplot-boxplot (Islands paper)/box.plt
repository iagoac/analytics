#!/usr/bin/env gnuplot

set terminal epslatex size 7.5,3 standalone monochrome
set output 'boxplot.tex'

set style fill solid 0.5 border -1
set style boxplot outliers pointtype 7
set style data boxplot
set boxwidth  0.5
set pointsize 0.5

unset key
# set border 2

set xtics 2,2,50 nomirror
set xlabel '$m$'
set xrange[1:51]

# set grid ytics lc rgb 'grey90'
# set yrange[0:25]
set log y
set ytics 20, 10, 50000 logscale
set ylabel 'Deviation from optimal'

plot for [i=1:49] "times.dat" using (i+1):i lt 1 pointtype 7

unset output

set output # finish the current output file
system('pdflatex --interaction=batchmode boxplot.tex')
system('rm *.aux *.eps *.log *.tex *-converted-to.pdf')
unset terminal
