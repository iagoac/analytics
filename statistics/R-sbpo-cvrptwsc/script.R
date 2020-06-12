exact <- read.csv("vrp.csv", header = TRUE, sep = ",")

C  <- exact[1:40,]
R  <- exact[41:80,]
RC <- exact[81:120,]

# Tabela do C
sink("results-c.tex", append = FALSE)
cat("\\begin{table}[!t] \n")
cat("\\caption{Resultados do L-Shaped Method para as instâncias C}\n")
cat("\\label{table:resultados_c} \n")
cat("\\centering \n")
cat("\\begin{tabular}{\n  c % |V'|\n  c % |I|\n  c % inteiro\n  c % otimo\n  c\n  c\n  c\n  c\n}\n")
cat("\\toprule \n")
cat("$|V'|$ & $|I|$ & Inteiro & Ótimo & \\mc{gap (\\%)} & \\mc{# cortes} & \\mc{$t_1$ (s)} & \\mc{$t_2$ (s)} \\\\ \\midrule \n")
for (size in unique(as.list(exact$n))) {
  for (uncertain in unique(as.list(exact$I))) {
    sub <- subset(C, n == size & I == uncertain)
    cat(sprintf("\\multirow{4}{*}{%d} & %d & %d & %d & %.1f(%.0f) & %.1f(%.0f) & %.1f(%.0f) & %.1f(%.0f) \\\\ \n",
                size,
                uncertain,
                length(which(sub$GAP < 100)),
                length(which(sub$GAP == 0)), 
                mean(sub$GAP), 
                10*sd(sub$GAP),
                mean(sub$nCuts),
                10*sd(sub$nCuts),
                mean(sub$time1),
                10*sd(sub$time1),
                mean(sub$time2),
                10*sd(sub$time2)))
  }
  cat("\\midrule \n")
}
cat("\\bottomrule \n")
cat("\\end{tabular} \n")
cat("\\end{table} \n")
sink()




# Tabela do R
sink("results-r.tex", append = FALSE)
cat("\\begin{table}[!t] \n")
cat("\\caption{Resultados do L-Shaped Method para as instâncias R}\n")
cat("\\label{table:resultados_R} \n")
cat("\\centering \n")
cat("\\begin{tabular}{\n  c % |V'|\n  c % |I|\n  c % inteiro\n  c % otimo\n  c\n  c\n  c\n  c\n}\n")
cat("\\toprule \n")
cat("$|V'|$ & $|I|$ & Inteiro & Ótimo & \\mc{gap (\\%)} & \\mc{# cortes} & \\mc{$t_1$ (s)} & \\mc{$t_2$ (s)} \\\\ \\midrule \n")
for (size in unique(as.list(exact$n))) {
  for (uncertain in unique(as.list(exact$I))) {
    sub <- subset(R, n == size & I == uncertain)
    cat(sprintf("\\multirow{4}{*}{%d} & %d & %d & %d & %.1f(%.0f) & %.1f(%.0f) & %.1f(%.0f) & %.1f(%.0f) \\\\ \n",
                size,
                uncertain,
                length(which(sub$GAP < 100)),
                length(which(sub$GAP == 0)), 
                mean(sub$GAP), 
                10*sd(sub$GAP),
                mean(sub$nCuts),
                10*sd(sub$nCuts),
                mean(sub$time1),
                10*sd(sub$time1),
                mean(sub$time2),
                10*sd(sub$time2)))
  }
  cat("\\midrule \n")
}
cat("\\bottomrule \n")
cat("\\end{tabular} \n")
cat("\\end{table} \n")
sink()





# Tabela do RC
sink("results-rc.tex", append = FALSE)
cat("\\begin{table}[!t] \n")
cat("\\caption{Resultados do L-Shaped Method para as instâncias RC}\n")
cat("\\label{table:resultados_rc} \n")
cat("\\centering \n")
cat("\\begin{tabular}{\n  c % |V'|\n  c % |I|\n  c % inteiro\n  c % otimo\n  c\n  c\n  c\n  c\n}\n")
cat("\\toprule \n")
cat("$|V'|$ & $|I|$ & Inteiro & Ótimo & \\mc{gap (\\%)} & \\mc{# cortes} & \\mc{$t_1$ (s)} & \\mc{$t_2$ (s)} \\\\ \\midrule \n")
for (size in unique(as.list(exact$n))) {
  for (uncertain in unique(as.list(exact$I))) {
    sub <- subset(RC, n == size & I == uncertain)
    cat(sprintf("\\multirow{4}{*}{%d} & %d & %d & %d & %.1f(%.0f) & %.1f(%.0f) & %.1f(%.0f) & %.1f(%.0f) \\\\ \n",
                size,
                uncertain,
                length(which(sub$GAP < 100)),
                length(which(sub$GAP == 0)), 
                mean(sub$GAP), 
                10*sd(sub$GAP),
                mean(sub$nCuts),
                10*sd(sub$nCuts),
                mean(sub$time1),
                10*sd(sub$time1),
                mean(sub$time2),
                10*sd(sub$time2)))
  }
  cat("\\midrule \n")
}
cat("\\bottomrule \n")
cat("\\end{tabular} \n")
cat("\\end{table} \n")
sink()

