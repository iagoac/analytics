set terminal epslatex size 8,3 standalone font 14
set output 're2-by-k.tex'

# Key means label...
set key at 25,0.965 top right
# set key top right
set xlabel 'k'
set ylabel 'R(e)'
set title ''

set xtics nomirror
set ytics nomirror
set xtics 10,1,25
set ytics 0.5,0.1,1.01

set xrange [9.5:25.5]
set yrange [0.50:1.02]

plot  "re2-by-k.dat" using 1:2 with linespoints ls 1 pointtype 13 pi -1 ps 3.5 lc rgb '#88000000' title 'Bi-objective Lexicographical Ranking',\
      "re2-by-k.dat" using 1:3 with linespoints ls 1 pointtype 5 pi -1 ps 2.75 lc rgb '#22666666'title 'PAR10 scores',\
      "re2-by-k.dat" using 1:5 with linespoints ls 1 pointtype 7 pi -1 ps 3.5 lc rgb '#44333333'title 'Skillings-Mack test',\
      "re2-by-k.dat" using 1:4 with linespoints ls 1 pointtype 9 pi -1 ps 3.5 lc rgb '#00999999' title 'Wittkowski test'

set output # finish the current output file
system('pdflatex --interaction=batchmode re2-by-k.tex')
unset terminal

system('rm *.aux *.tex *.log *.eps')
