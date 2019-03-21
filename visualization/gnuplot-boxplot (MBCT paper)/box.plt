set terminal pngcairo  transparent enhanced font "arial,10" fontscale 1.0 size 600, 400
set output 'boxplot.png'

set style fill solid 0.5 border -1
set style boxplot outliers pointtype 7
set style data boxplot
set boxwidth  0.5
set pointsize 0.5

unset key
set border 2
set xtics ("aug1" 1, "aug2" 2) scale 0.0
set xtics nomirror
set ytics nomirror

plot for [i=1:2] 'times.dat' using (i):i notitle
