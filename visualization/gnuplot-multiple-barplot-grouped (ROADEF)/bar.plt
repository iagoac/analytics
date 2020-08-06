#!/usr/bin/env gnuplot

set terminal epslatex size 8,3.5 standalone font 14
set output 'barplot.tex'

set xtics nomirror out

set style data histogram
set style histogram cluster gap 2
# set key horizontal top center
set key outside right top

set ytics in
set xrange [-0.5:2.5]
set yrange [15:45]
set ytics 15,5,45

set style fill solid 0.9
set boxwidth 0.9
# set border 3

set grid ytics lt rgb "#A0A0A0"

# Key means label...
set ylabel 'Relative optimality gap'

plot 'heuristics.dat' using 2:xtic(1) title col linecolor rgb "#000000", \
        '' using 3:xtic(1) title col linecolor rgb "#272727", \
        '' using 4:xtic(1) title col linecolor rgb "#505050", \
        '' using 5:xtic(1) title col linecolor rgb "#777777", \
        '' using 6:xtic(1) title col linecolor rgb "#A0A0A0", \
        '' using 7:xtic(1) title col linecolor rgb "#C7C7C7"

set output # finish the current output file
system('pdflatex --interaction=batchmode barplot.tex')
unset terminal

system('rm *.aux *.tex *.log *.eps')
