set terminal pdfcairo size 7,4 font "Times,12" monochrome
set output 'socioeconomics_consumers.pdf'
# set output 'socioeconomics_specialists.pdf'

set key outside top right spacing 2

set xlabel 'Beer'
set ylabel 'Have previously used the preferred beer glass (%)'

set xrange[0.8:5.2]
set xtics 1 nomirror

set yrange [80:102]
set ytics 4 nomirror

set grid ytics

plot  "preference.dat" using 1:2 title 'Consumers' with linespoints ls 5 lw 4 pointtype 7 ps 1.4, "preference.dat" using 1:3 title 'Specialists' with linespoints ls 5 lw 4 pointtype 5 ps 1.4
