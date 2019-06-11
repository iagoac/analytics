# Scale font and line width (dpi) by changing the size! It will always display stretched.
# set terminal  size 400,300 enhanced fname 'arial'  fsize 10 butt solid
set terminal pdfcairo font "Helvetica,7" monochrome
set output 'var.pdf'

# set terminal epslatex size 4,3 standalone monochrome
# set output 'boxplot.tex'

# Key means label...
# set key right top
unset key
set xlabel '# levels'
set ylabel 'Percent'
set title ''

# set logscale x

set xtics ("5" 1, "12" 2, "14" 3, "18" 4, "18" 5, "22" 6, "56" 7, "72" 8, "89" 9, "116" 10, "227" 11, "252" 12, "252 " 13, "257" 14, "276" 15, "289" 16, "446" 17, "4374" 18, "5060" 19, "24803" 20)

set offset 1,1,1,1

f(x) = m*x + b
fit f(x) "var.dat" using 1:2 via m,b

plot  "var.dat" using 1:2 with  points ls 1 pointtype 7, \
       f(x) title "Linear regression"
