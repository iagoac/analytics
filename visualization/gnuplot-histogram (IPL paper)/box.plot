set terminal pdfcairo size 7.5,3 font "Times,16"
set output 'histogram.pdf'

set style fill solid 0.8
set style data histogram
set style histogram cluster gap 1

# unset key
set key box center top width +1
# set border 2
set ytics nomirror
set xtics nomirror
set xrange[0.5:5.5]

set grid ytics

# Key means label...
set xlabel 'Ranking attributed by the bi-objective lexicographical ranking scheme'
set ylabel 'Frequency'


plot 'rankings.dat' using 2:xticlabels(1) title "IR" lc rgb "#000000",\
     'rankings.dat' using 3:xticlabels(1) title "FP" lc rgb "#555555",\
     'rankings.dat' using 4:xticlabels(1) title "RECIPE" lc rgb "#999999"

#plot for [COL=2:3:4] 'rankings.dat' using COL


#plot for [COL=2:4] 'rankings.dat' using COL:xticlabels(1)

#plot "rankings.dat" using (1):1 title 'AMU' lt 1 pointtype 7,\
#     "rankings.dat" using (2):2 title 'SBA' lt 1 pointtype 7,\
#     "rankings.dat" using (3):3 title 'VND' lt 1 pointtype 7,\
#     "200.dat" using (4):4 title 'DBH' lt 1 pointtype 7
