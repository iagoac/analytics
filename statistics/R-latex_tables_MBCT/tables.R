#################################
############ TABLE 1 ############
#################################

obj1 <- read.csv("obj-1/obj1.csv", header = TRUE, sep = ",")
obj2 <- read.csv("obj-2/obj2.csv", header = TRUE, sep = ",")

sink("table-mbct-1.tex")

cat("\\textbf{Size} & \\textbf{Avg. Degree} & \\mc{\\textbf{$|\\mathcal{F}|$}} & \\mc{\\textbf{aug\\,\\epsilon\\text{-}CM_1}} & \\mc{\\textbf{aug\\,\\epsilon\\text{-}CM_2}} & \\mc{\\textbf{Proportion}} \\\\ \\midrule \n")
for (s in c(25,50)) {
  for (d in c(3,5,10)) {
    sub1 <- subset(obj1, size == s & degree == d)
    sub2 <- subset(obj2, size == s & degree == d)
    cat("\\multirow{3}{*}{", s, "} &", d, "& ")
    cat(sprintf("%.2f(%.2f) & %.2f(%.2f) & %.2f(%.2f) & %.2f \\\\ \n",
                mean(sub1$points), sd(sub1$points),
                mean(sub1$time), sd(sub1$time),
                mean(sub2$time), sd(sub2$time),
                mean((sub1$time/sub2$time)*100)))
  }
}
cat("\\midrule \n")
cat("\\multicolumn{2}{c}{\\textbf{Average}} & ")
cat(sprintf("%.2f(%.2f) & %.2f(%.2f) & %.2f(%.2f) & %.2f \\\\ \n",
            mean(obj1$points), sd(obj1$points),
            mean(obj1$time), sd(obj1$time),
            mean(obj2$time), sd(obj2$time),
            mean((obj2$time/obj1$time)*100)))
cat("\\bottomrule")
sink()

shapiro.test(obj1$time)
shapiro.test(obj2$time)

wilcox.test(obj1$time, obj2$time, paired = TRUE, alternative = "two.sided")

#################################
############ TABLE 2 ############
#################################

data <- read.csv("table2.csv", header = TRUE, sep = ",")
sink("table-mbct-2.tex")
cat("\\toprule \n")
cat("\\textbf{Size} & \\textbf{Avg. Degree} & \\mc{\\textbf{$|\\mathcal{F}|$}} & \\mc{\\textbf{$|\\mathcal{D}|$}} & \\mc{\\textbf{$M_1$}} & \\mc{\\textbf{$M_2$}} & \\mc{\\textbf{$M_3$}} \\\\ \\midrule \n")
for (s in c(25,50)) {
  for (d in c(3,5,10)) {
    sub <- subset(data, size == s & degree == d)
    cat("\\multirow{3}{*}{", s, "} &", d, "& ")
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
