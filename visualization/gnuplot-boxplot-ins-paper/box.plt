#!/usr/bin/env gnuplot

set terminal epslatex size 8,3 standalone font 14 monochrome
set output 'boxplot.tex'

set style fill solid 0.5 border -1
set style boxplot nooutliers
set style data boxplot
set boxwidth 0.65

set ytics nomirror
set xtics nomirror
set format y "%1.1f"
set ytics 0,0.2,1

set xtics ("0" 1, "0.1" 2,  "0.2" 3, "0.3" 4, "0.4" 5, "0.5" 6, "0.6" 7, "0.7" 8, "0.8" 9, "0.9" 10, "1" 11) scale 0.0

# Key means label...
set xlabel '$\rho$'
set ylabel '$p$-value'
set title ''

set xrange [0.5:11.5]
set y2range [0:1]

plot "bilex_box.dat" using (1):xtic(1)  lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (2):xtic(1)  lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (3):xtic(3)  lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (4):xtic(3)  lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (5):5  lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (6):6  lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (7):7  lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (8):8  lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (9):9  lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (10):10 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (11):11 lt 1 pointtype 7 notitle
     #"rejected.dat" using 1:2 with linespoints lt 1 lw 2 pointtype 7 ps 1 axes x1y2 notitle


set output # finish the current output file
system('pdflatex --interaction=batchmode boxplot.tex')
unset terminal

system('rm *.aux *.tex *.log *.eps')

#plot , \
#     "rejected.dat" using 1:3 title 'par10' with linespoints axes x1y2
