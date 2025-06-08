set terminal epslatex size 8,3 standalone font 12
set output 'm-vs-im.tex'

# Key means label...
# set grid
set mxtics 3
unset key
set xlabel '$m$'
set ylabel '$im$'
set title ''

set xtics nomirror
set ytics nomirror
set xtics 2,4,50
set ytics 0,0.1,1

set xrange [1:51]
set yrange [0:1]

f(x) = m*x + b
fit f(x) "data.dat" using 1:2 via m,b

# Computing the statistics for the regression line
stats 'data.dat' using 1:2 name "A"

plot  "data.dat" using 1:2 with points ls 1 pointtype 7 pi -1 ps 2 lc rgb '#00000000', f(x) lc rgb '#000'

set output # finish the current output file
system('pdflatex --interaction=batchmode m-vs-im.tex')
unset terminal

system('rm *.aux *.tex *.log *.eps')
