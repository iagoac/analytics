set terminal pdfcairo font "Arial,10" monochrome
set output 'sba.pdf'

set y2tics out
set ytics nomirror out
set xtics nomirror out

set grid

# Key means label...
set key inside top left box 1
set xlabel 'Number of evaluated scenarios'
set ylabel 'Solution value'
set y2label "Time (seconds)"
set title ''
plot "grafico.txt" using 1:2 title 'Solution value' with lines, \
     "grafico.txt" using 1:3 title 'Time' with lines axes x1y2, \
     "grafico.txt" using 1:2 notitle with points pointtype 7 pointsize 0.5
