#!/usr/bin/env gnuplot

set terminal epslatex size 7.5,3 standalone
set output 'pareto.tex'

set style fill solid 0.8
set ytics nomirror
set xtics nomirror

set grid lc rgb "#F2F2F2"

set xlabel 'Z_1'
set ylabel 'Z_2'


set style line 1 lt rgb "#000000" lw 12 pt 7 pointsize 3
set style line 2 lt rgb "#676767" lw 6 pt 7 pointsize 2

plot "../exact.dat" using 1:2 title '$aug\,\epsilon$-CM' with linespoints ls 1,\
     "../npe.dat"   using 1:2 title 'NPE-NSAIS'          with linespoints ls 2

unset output

set output # finish the current output file
system('pdflatex --interaction=batchmode pareto.tex')
unset terminal

system
