set terminal pdfcairo size 12,5.5 font "Arial,14"
# set output 'socioeconomics_consumers.pdf'
set output 'socioeconomics_specialists.pdf'

set xtics("Male" 1.5, "Female" 3.5, "18-24" 6.5, "25-34" 8.5, "35-49" 10.5, "50-64" 12,5, "65+" 14.5, "< 1" 17.5, "1-2" 19.5, "2-3" 21.5, "3-8" 23.5, "8-16" 25.5, "16+" 27.5, "Single" 30.5, "Married" 32.5, "Divorced" 34.5, "Stable union" 36.5, "Others" 38.5, "Elementary school" 41.5, "High school" 43.5, "Incomplete undergraduate" 45.5, "Undergraduate" 47.5, "Incomplete graduate" 49.5, "Graduate" 51.5)
set x2tics("Sex" 3, "Age" 10.5, "Family income (minimum wages)" 22.5, "Marital status" 34.5, "Educational status" 46.5)

set xtics nomirror out
set xtics rotate
set ytics rotate
set xrange[0:53]

set ytics nomirror out
set ytics 10

set style fill solid 0.9
set boxwidth 0.9
set border 3

set grid ytics
unset key

# Key means label...
set ylabel '% of the answers'

plot "consumers.dat" using 1:2 with boxes linecolor rgb "#333333" title "Consumers", \
     "specialists.dat" using 1:2 with boxes linecolor rgb "#999999" title "Specialists"
