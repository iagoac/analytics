# Scale font and line width (dpi) by changing the size! It will always display stretched.
#set terminal  size 400,300 enhanced fname 'arial'  fsize 10 butt solid
set terminal pdfcairo font "Helvetica,7" monochrome
set output 'var.pdf'

# Key means label...
set key inside top left
set xlabel 'Hier instance'
set ylabel 'Improvement (%)'
set yrange [0:70]
set title ''
plot  "var.dat" using 1:2 title 'MinMax' with linespoints ls 5, "var.dat" using 1:3 title 'Regret' with linespoints, "var.dat" using 1:4 title 'Relative Regret' with linespoints
