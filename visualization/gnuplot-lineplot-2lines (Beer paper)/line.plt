set terminal pdfcairo size 7,4 font "Arial,14" monochrome
set output 'socioeconomics_consumers.pdf'
# set output 'socioeconomics_specialists.pdf'

set key outside top right spacing 2

set ylabel 'Have previously used the preferred beer glass (%)'

set xrange[0.8:5.2]
set xtics("Draft beer" 1, "Weizen" 2, "Lager" 3, "Red Ale" 4, "Dunkel Weizen" 5)

set yrange [80:102]
set ytics 4 nomirror

set grid ytics

plot  "preference.dat" using 1:2 title 'Consumers' with linespoints ls 5 lw 4 pointtype 7 ps 1.4, "preference.dat" using 1:3 title 'Specialists' with linespoints ls 5 lw 4 pointtype 5 ps 1.4
