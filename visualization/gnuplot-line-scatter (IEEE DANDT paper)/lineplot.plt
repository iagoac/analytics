# Scale font and line width (dpi) by changing the size! It will always display stretched.
# set terminal  size 400,300 enhanced fname 'arial'  fsize 10 butt solid
# set terminal pdfcairo font "Helvetica,7" monochrome
# set output 'var.pdf'

set terminal epslatex size 4,3 standalone monochrome
set output 'boxplot.tex'

# Key means label...
unset key
set xlabel '\# levels'
set ylabel 'Percent'
set title ''

set xtics ("5" 1, "12" 2, "14" 3, "18" 4, "18" 5, "22" 6, "56" 7, "72" 8, "89" 9, "116" 10, "252" 11, "252 " 12, "257" 13, "276" 14, "289" 15, "446" 16, "4374" 17, "5060" 18, "24803" 19)

set offset 1,1,1,1

plot  "var.dat" using 1:2 with linespoints ls 1 pointtype 7
