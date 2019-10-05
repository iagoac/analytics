set terminal pdfcairo size 7,4 font "Arial,14" monochrome
# set output 'socioeconomics_consumers.pdf'
set output 'socioeconomics_specialists.pdf'

set xtics("Male" 1, "Female" 2, "18-24" 4, "25-34" 5, "35-49" 6, "50-64" 7, "65+" 8, "< 1" 10, "1-2" 11, "2-3" 12, "3-8" 13, "8-16" 14, "16+" 15, "Single" 17, "Married" 18, "Divorced" 19, "Stable union" 20, "Others" 21, "Elementary school" 23, "High school" 24, "Incomplete undergraduate" 25, "Undergraduate" 26, "Incomplete graduate" 27, "Graduate" 28)

set xtics nomirror out
set xtics rotate
set xrange[0:29]

set x2tics("Gender" 1.5, "Age" 6, "Familiar income" 12.5, "Marital status" 19.5, "Educational status" 25.5) scale 0

set ytics nomirror out
set ytics 5
set yrange[0:61]
# set yrange[0:86]

unset key

set style fill solid 0.9
set boxwidth 0.9
set border 3

set grid ytics

# Key means label...
set ylabel '% of the answers'

# plot "consumers.dat" using 1:2 with boxes
plot "specialists.dat" using 1:2 with boxes
