#!/usr/bin/env gnuplot

set terminal epslatex size 8,3 standalone font 14 monochrome
set output 'boxplot.tex'

set style fill solid 0.5 border -1
set style boxplot nooutliers
set style data boxplot
set boxwidth 0.65

set y2tics
set ytics nomirror
set xtics nomirror
set format y "%1.1f"
set ytics 0,0.2,1

# Key means label...
set xlabel 'k'
set ylabel '$p$-value'
set y2label "number of rejections"
set title ''

set xrange [9:51]
set y2range [0:500]

plot "bilex_box.dat" using (10):1  lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (11):2  lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (12):3  lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (13):4  lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (14):5  lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (15):6  lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (16):7  lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (17):8  lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (18):9  lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (19):10 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (20):11 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (21):12 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (22):13 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (23):14 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (24):15 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (25):16 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (26):17 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (27):18 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (28):19 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (29):20 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (30):21 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (31):22 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (32):23 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (33):24 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (34):25 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (35):26 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (36):27 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (37):28 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (38):29 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (39):30 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (40):31 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (41):32 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (42):33 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (43):34 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (44):35 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (45):36 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (46):37 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (47):38 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (48):39 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (49):40 lt 1 pointtype 7 notitle,\
     "bilex_box.dat" using (50):41 lt 1 pointtype 7 notitle,\
     "rejected.dat" using 1:2 with linespoints lt 1 lw 2 pointtype 7 ps 1 axes x1y2 notitle


set output # finish the current output file
system('pdflatex --interaction=batchmode boxplot.tex')
unset terminal

system('rm *.aux *.tex *.log *.eps')

#plot , \
#     "rejected.dat" using 1:3 title 'par10' with linespoints axes x1y2
