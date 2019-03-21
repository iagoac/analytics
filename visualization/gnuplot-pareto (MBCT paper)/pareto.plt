#!/usr/bin/env gnuplot

set terminal epslatex size 7.5,3 standalone
set output 'pareto.tex'

set style fill solid 0.8
set ytics nomirror
set xtics nomirror

set grid lc rgb "#B5B5B5"

set xlabel 'Z_1'
set ylabel 'Z_2'

set offset 1,2,2,1

# set xrange [*:*] noextend; set yrange [*:*] noextend

# set label 1 "$M_1 = 81.81" left at graph 0.855,0.68 front
# set label 2 "$M_2 = 2.07$" left at graph 0.855,0.56 front
# set label 3 "$M_3 = 0.87$" left at graph 0.855,0.44 front

set style line 1 lt rgb "#000000" lw 12 pt 7 pointsize 3
set style line 2 lt rgb "#676767" lw 6 pt 7 pointsize 2

plot "../exact.dat" using 1:2 title '$aug\,\epsilon$-CM' with linespoints ls 1,\
     "../npe.dat"   using 1:2 title 'NPE-NSAIS'          with linespoints ls 2

unset output

set output # finish the current output file
system('pdflatex --interaction=batchmode pareto.tex')
unset terminal

system
