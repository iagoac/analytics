data <- read.csv("results/table2.csv", header = TRUE, sep = ",")

sink("table-mbct-2.tex")
cat("\\toprule \n")
cat("\\textbf{Size} & \\textbf{Avg. Degree} & \\mc{\\textbf{$|\\mathcal{F}|$}} & \\mc{\\textbf{$|\\mathcal{D}|$}} & \\mc{\\textbf{$M_1$}} & \\mc{\\textbf{$M_2$}} & \\mc{\\textbf{$M_3$}} \\\\ \\midrule \n")
for (s in c(25,50)) {
  for (d in c(3,5,10)) {
    sub <- subset(data, size == s & degree == d)
    cat("\\multicolumn{3}{*}{", s, "} &", d, "& ")
    cat(sprintf("%.2f(%.2f) & %.2f(%.2f) & %.2f(%.2f) & %.2f(%.2f) & %.2f(%.2f) \\\\ \n",
                mean(sub$exact), sd(sub$exact),
                mean(sub$npe),   sd(sub$npe),
                mean(sub$intersection_percent)*100, sd(sub$intersection_percent)*100,
                mean(sub$m2), sd(sub$m2), 
                mean(sub$m3), sd(sub$m3)))
  }
}
cat("\\midrule \n")
cat("\\multicolumn{2}{c}{\\textbf{Average}} & ")
cat(sprintf("%.2f(%.2f) & %.2f(%.2f) & %.2f(%.2f) & %.2f(%.2f) & %.2f(%.2f) \\\\ \n",
            mean(data$exact), sd(data$exact),
            mean(data$npe), sd(data$npe),
            mean(data$intersection_percent)*100, sd(data$intersection_percent)*100,
            mean(data$m2), sd(data$m2), 
            mean(data$m3), sd(data$m3)))
cat("\\bottomrule")
sink()
