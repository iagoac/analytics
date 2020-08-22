setwd("C:/github/analytics/statistics/R-latex-tables-anor-biobjective-trees")

hop1   <- read.csv("hop/cost/results.csv",    header = TRUE, sep = ",")
hop2   <- read.csv("hop/hop/results.csv",     header = TRUE, sep = ",")
delay1 <- read.csv("delay/cost/results.csv",  header = TRUE, sep = ",")
delay2 <- read.csv("delay/delay/results.csv", header = TRUE, sep = ",")

sink("hc-results.tex", append = FALSE)
cat("\\begin{table}[!t] \n")
cat("\\caption{Comparison of the two $aug\\,\\epsilon\\text{-}CM$ implementations for B-HCMST}\n")
cat("\\label{table:hc_results} \n")
cat("\\centering \n")
cat("\\begin{tabular}{\n  c\n  c\n  c\n  c\n  c\n  c\n}\n")
cat("\\toprule \n")
cat("    &       & \\multicolumn{2}{c}{Weight}     & \\multicolumn{2}{c}{Hop}        \\\\ \\cmidrule(lr){3-4} \\cmidrule(r){5-6} \n")
cat("Set & $|N|$ & \\mc{# optimal} & \\mc{time (s)} & \\mc{# optimal} & \\mc{time (s)} \\\\ \\midrule \n")
for (t in unique(as.list(hop1$type))) {
  for (s in unique(as.list(hop1$size))) {
    sub1 <- subset(hop1, type == t & size == s)
    sub2 <- subset(hop2, type == t & size == s)
    cat(sprintf("\\multirow{3}{*}{\\textsc{%s}} & %d & %d & %.1f(%.0f)  & %d & %.1f(%.0f) \\\\ \n",
                t,
                s,
                length(which(sub1$status=="Optimal")), 
                mean(sub1$time), 
                10*sd(sub1$time),
                length(which(sub2$status=="Optimal")), 
                mean(sub2$time), 
                10*sd(sub2$time)))
  }
  cat("\\midrule \n")
}
cat("\\bottomrule \n")
cat("\\end{tabular} \n")
cat("\\end{table} \n")
remove(s, t, sub1, sub2)
sink()



sink("dc-results.tex", append = FALSE)
cat("\\begin{table}[!t] \n")
cat("\\caption{Comparison of the two $aug\\,\\epsilon\\text{-}CM$ implementations for B-DCMST}\n")
cat("\\label{table:dc_results} \n")
cat("\\centering \n")
cat("\\begin{tabular}{\n  c\n  c\n  c\n  c\n  c\n  c\n}\n")
cat("\\toprule \n")
cat("    &       & \\multicolumn{2}{c}{Weight}     & \\multicolumn{2}{c}{Delay}      \\\\ \\cmidrule(lr){3-4} \\cmidrule(r){5-6} \n")
cat("Set & $|N|$ & \\mc{# optimal} & \\mc{time (s)} & \\mc{# optimal} & \\mc{time (s)} \\\\ \\midrule \n")
for (t in unique(as.list(delay1$type))) {
  for (s in unique(as.list(delay1$size))) {
    sub1 <- subset(delay1, type == t & size == s)
    sub2 <- subset(delay2, type == t & size == s)
    cat(sprintf("\\multirow{3}{*}{\\textsc{%s}} & %d & %d & %.1f(%.0f)  & %d & %.1f(%.0f) \\\\ \n",
                t,
                s,
                length(which(sub1$status=="Optimal")), 
                mean(sub1$time), 
                10*sd(sub1$time),
                length(which(sub2$status=="Optimal")), 
                mean(sub2$time), 
                10*sd(sub2$time)))
  }
  cat("\\midrule \n")
}
cat("\\bottomrule \n")
cat("\\end{tabular} \n")
cat("\\end{table} \n")
remove(s, t, sub1, sub2)
sink()

# normality tests
shapiro.test(subset(delay1, type == "tc")$time)
shapiro.test(subset(delay1, type == "te")$time)
shapiro.test(subset(delay2, type == "tc")$time)
shapiro.test(subset(delay2, type == "te")$time)
shapiro.test(subset(hop1,   type == "tc")$time)
shapiro.test(subset(hop1,   type == "te")$time)
shapiro.test(subset(hop2,   type == "tc")$time)
shapiro.test(subset(hop2,   type == "te")$time)


# paired wilcoxon's tests
wilcox.test(subset(hop1, type == "tc")$time, subset(hop2, type == "tc")$time, paired = TRUE, alternative = "two.sided")
wilcox.test(subset(hop1, type == "te")$time, subset(hop2, type == "te")$time, paired = TRUE, alternative = "two.sided")

wilcox.test(subset(delay1, type == "tc")$time, subset(delay2, type == "tc")$time, paired = TRUE, alternative = "two.sided")
wilcox.test(subset(delay1, type == "te")$time, subset(delay2, type == "te")$time, paired = TRUE, alternative = "two.sided")
