set terminal pdfcairo size 7,4 font "Arial,14"
set output 'importance_consumers.pdf'
# set output 'importance_specialists.pdf'

set xtics nomirror out
set xtics rotate

set style data histogram
set style histogram cluster gap 1

set ytics nomirror out
set auto x

set style fill solid 0.9
set boxwidth 0.9
set border 3

set grid ytics

# Key means label...
set ylabel '# of answers'

plot 'consumers.dat' using 2:xtic(1) title col linecolor rgb "#CCCCCC", \
        '' using 3:xtic(1) title col linecolor rgb "#888888", \
        '' using 4:xtic(1) title col linecolor rgb "#111111"

# plot 'specialists.dat' using 2:xtic(1) title col linecolor rgb "#CCCCCC", \
#        '' using 3:xtic(1) title col linecolor rgb "#888888", \
#        '' using 4:xtic(1) title col linecolor rgb "#111111"
