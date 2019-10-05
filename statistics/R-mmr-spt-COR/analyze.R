setwd("~/mmr-spt")

catanzaro <- read.csv("catanzaro_sorted.csv", header = TRUE, sep = ",")
karasan   <- read.csv("karasan_sorted.csv",   header = TRUE, sep = ",")

catanzaroMILP_t <- subset(catanzaro, algorithm == "exact")
catanzaroVND_t  <- subset(catanzaro, algorithm == "vnd")
catanzaroLP_t   <- subset(catanzaro, algorithm == "faolp")
catanzaroSP_t   <- subset(catanzaro, algorithm == "faosp")
catanzaroLR_t   <- subset(catanzaro, algorithm == "faolr")


karasanMILP_t <- subset(karasan, algorithm == "exact")
karasanVND_t  <- subset(karasan, algorithm == "vnd")
karasanLP_t   <- subset(karasan, algorithm == "faolp")
karasanSP_t   <- subset(karasan, algorithm == "faosp")
karasanLR_t   <- subset(karasan, algorithm == "faolr")

catanzaroMILP <- subset(catanzaroMILP_t)
catanzaroVND  <- subset(catanzaroVND_t)
catanzaroLP   <- subset(catanzaroLP_t)
catanzaroSP   <- subset(catanzaroSP_t)
catanzaroLR   <- subset(catanzaroLR_t)

karasanMILP <- subset(karasanMILP_t)
karasanVND  <- subset(karasanVND_t)
karasanSP   <- subset(karasanSP_t)
karasanLP   <- subset(karasanLP_t)
karasanLR   <- subset(karasanLR_t)

best <- as.data.frame(matrix(0, nrow=nrow(karasanMILP_t), ncol=2))
colnames(best) <- c("catanzaro", "karasan")

#k_sp <- 0
#k_lp <- 0
#k_milp <- 0
#k_vnd <- 0
#c_sp <- 0
#c_lp <- 0
#c_milp <- 0
#c_vnd <- 0

for (i in 1:nrow(catanzaroMILP_t)) {
  best$catanzaro[i] <- min(catanzaroMILP_t$primal[i], 
                           catanzaroVND_t$primal[i], 
                           catanzaroSP_t$primal[i], 
                           catanzaroLP_t$primal[i],
                           catanzaroLR_t$primal[i])
  
  best$karasan[i] <- min(karasanMILP_t$primal[i], 
                         karasanVND_t$primal[i], 
                         karasanSP_t$primal[i], 
                         karasanLP_t$primal[i],
                         karasanLR_t$primal[i])
  
#  if (karasanMILP$primal[i] == best$karasan[i]) {
#    k_milp <- k_milp + 1
#  }
  
#  if (karasanVND$primal[i] == best$karasan[i]) {
#    k_vnd <- k_vnd + 1
#  }
  
#  if (karasanSP$primal[i] == best$karasan[i]) {
#    k_sp <- k_sp + 1
#  }
  
#  if (karasanLP$primal[i] == best$karasan[i]) {
#    k_lp <- k_lp + 1
#  }
  
#  if (catanzaroMILP$primal[i] == best$catanzaro[i]) {
#    c_milp <- c_milp + 1
#  }
  
#  if (catanzaroVND$primal[i] == best$catanzaro[i]) {
#    c_vnd <- c_vnd + 1
#  }
  
#  if (catanzaroSP$primal[i] == best$catanzaro[i]) {
#    c_sp <- c_sp + 1
#  }
  
#  if (catanzaroLP$primal[i] == best$catanzaro[i]) {
#    c_lp <- c_lp + 1
#  }
}

for (i in (1+nrow(catanzaroMILP_t)):nrow(catanzaroLP_t)) {
  best$catanzaro[i] <- min(catanzaroSP_t$primal[i], 
                           catanzaroLP_t$primal[i],
                           catanzaroLR_t$primal[i])
  
  best$karasan[i] <- min(karasanMILP_t$primal[i], 
                         karasanVND_t$primal[i], 
                         karasanSP_t$primal[i], 
                         karasanLP_t$primal[i],
                         karasanLR_t$primal[i])
}

for (i in (1+nrow(catanzaroLP_t)):nrow(karasanMILP_t)) {
  best$catanzaro[i] <- 1
  best$karasan[i] <- min(karasanMILP_t$primal[i], 
                         karasanVND_t$primal[i], 
                         karasanSP_t$primal[i], 
                         karasanLP_t$primal[i],
                         karasanLR_t$primal[i])
}

# cat(k_milp/60*100, "&", k_vnd/60*100, "&", k_sp/60*100, "&", k_lp/60*100, "\n")
# cat(c_milp/60*100, "&", c_vnd/60*100, "&", c_sp/60*100, "&", c_lp/60*100)

# average
# cat((k_milp+c_milp)/480*100, "&", (k_vnd+c_vnd)/480*100, "&", (k_sp+c_sp)/480*100, "&", (k_lp+c_lp)/480*100)

catanzaroSP_t$gap = 100*((catanzaroSP_t$primal-best$catanzaro[1:165])/best$catanzaro[1:165])
catanzaroLP_t$gap = 100*((catanzaroLP_t$primal-best$catanzaro[1:165])/best$catanzaro[1:165])
catanzaroLR_t$gap = 100*((catanzaroLR_t$primal-best$catanzaro[1:165])/best$catanzaro[1:165])
catanzaroVND_t$gap = 100*((catanzaroVND_t$primal-best$catanzaro[1:135])/best$catanzaro[1:135])

karasanSP_t$gap = 100*((karasanSP_t$primal-best$karasan)/best$karasan)
karasanLP_t$gap = 100*((karasanLP_t$primal-best$karasan)/best$karasan)
karasanLR_t$gap = 100*((karasanLR_t$primal-best$karasan)/best$karasan)
karasanVND_t$gap = 100*((karasanVND_t$primal-best$karasan)/best$karasan)

# Montar as tabelas do CPLEX
# Tabela CPLEX catanzaro
sink("randomMILP.tex", append = FALSE)
cat("\\begin{table}[!t] \n")
cat("\\caption{Results for the MILP formulation on random graphs} \n")
cat("\\label{table:randomMILP} \n")
cat("\\resizebox{\\textwidth}{!}{% \n")
cat("\\begin{tabular}{lllllllllll} \n")
cat("\\toprule \n")
cat("\\multirow{3}{*}{size} & \\multirow{3}{*}{D} & \\multicolumn{9}{c}{interval} \\\\ \\cmidrule(lr){3-11} \n")
cat("                       &                     & \\multicolumn{3}{c}{0.3} & \\multicolumn{3}{c}{0.6} & \\multicolumn{3}{c}{0.9} \\\\ \\cmidrule(lr){3-5} \\cmidrule(lr){6-8} \\cmidrule(lr){9-11} \\n")
cat("                       &                     & opt & gap (\\%) & t (s) & opt & gap (\\%) & t (s) & opt & gap (\\%) & t (s)            \\\\  \\cmidrule(lr){1-2} \\cmidrule(lr){3-3} \\cmidrule(lr){4-4}  \\cmidrule(lr){5-5} \\cmidrule(lr){6-6} \\cmidrule(lr){7-7} \\cmidrule(lr){8-8} \\cmidrule(lr){9-9} \\cmidrule(lr){10-10} \\cmidrule(lr){11-11} \n")
for (nodes in unique(as.list(catanzaroMILP$size))) {
  cat("\\multirow{4}{*}{", nodes, "}")
  for (d in unique(as.list(catanzaroMILP$D))) {
    cat("&", d, "& ")
    for (variation in unique(as.list(catanzaroMILP$interval))) {
      sub <- subset(catanzaroMILP_t, size == nodes & D == d & interval == variation)
      cat(sprintf("%d & %.1f(%.1f) & %.1f(%.1f) &", 
                  nrow(subset(sub, status == "Optimal")), 
                  mean(sub$gap), 
                  sd(sub$gap),
                  mean(subset(sub, status == "Optimal")$time),
                  sd(subset(sub, status == "Optimal")$time)))
    }
    cat("\\\\ \n")
  }
  cat("\\midrule\n")
}
cat("\\bottomrule \n")
cat("\\end{tabular}% \n}\n")
cat("\\end{table} \n")
sink()




# Tabela CPLEX Karasan
sink("layeredMILP.tex", append = FALSE)
cat("\\begin{table}[!t] \n")
cat("\\caption{Results for the MILP formulation on layered graphs} \n")
cat("\\label{table:layeredMILP} \n")
cat("\\resizebox{\\textwidth}{!}{% \n")
cat("\\begin{tabular}{lllllllllll} \n")
cat("\\toprule \n")
cat("\\multirow{3}{*}{size} & \\multirow{3}{*}{L} & \\multicolumn{9}{c}{interval} \\\\ \\cmidrule(lr){3-11} \n")
cat("                       &                     & \\multicolumn{3}{c}{0.3} & \\multicolumn{3}{c}{0.6} & \\multicolumn{3}{c}{0.9} \\\\ \\cmidrule(lr){3-5} \\cmidrule(lr){6-8} \\cmidrule(lr){9-11} \\n")
cat("                       &                     & opt & gap (\\%) & t (s) & opt & gap (\\%) & t (s) & opt & gap (\\%) & t (s)            \\\\  \\midrule \n")
for (nodes in unique(as.list(karasanMILP$size))) {
  cat("\\multirow{4}{*}{", nodes, "}")
  for (l in unique(as.list(karasanMILP$layers))) {
    cat(" &", l, "& ")
    for (variation in unique(as.list(karasanMILP$interval))) {
      sub <- subset(karasanMILP, size == nodes & layers == l & interval == variation)
      cat(sprintf("%d & %.1f(%.1f) & %.1f(%.1f) &", 
                  nrow(subset(sub, status == "Optimal")), 
                  mean(sub$gap), 
                  sd(sub$gap),
                  mean(subset(sub, status == "Optimal")$time),
                  sd(subset(sub, status == "Optimal")$time)))
    }
    cat("\\\\ \n")
  }
  cat("\\midrule\n")
}
cat("\\bottomrule \n")
cat("\\end{tabular}% \n}\n")
cat("\\end{table} \n")
sink()



# Tabela heurísticas catanzaro
sink("randomHeuristics.tex", append = FALSE)
cat("\\begin{table}[!t] \n")
cat("\\caption{Results for the heuristics on random digraphs} \n")
cat("\\label{table:randomHeuristics100} \n")
cat("\\resizebox{\\textwidth}{!}{% \n")
cat("\\begin{tabular}{cccccccccc} \n")
cat("\\toprule \n")
cat("            &             &  \\multicolumn{2}{c}{VND~\\cite{Carvalho2018}} & \\multicolumn{2}{c}{FO-HD}  & \\multicolumn{2}{c}{FO-LP}   & \\multicolumn{2}{c}{FO-LR} \\\\ \\cmidrule(lr){3-4} \\cmidrule(lr){5-6} \\cmidrule(lr){7-8} \\cmidrule(lr){9-10}\n")
cat("$|N|$ & D & dev (\\%) & t (s)        & dev (\\%) & t (s)        & dev (\\%) & t (s)        & dev (\\%) & t (s)        & dev (\\%) & t (s)        \\\\ \\midrule \n")
for (tamanho in unique(as.list(catanzaroMILP_t$size))) {
  cat("\\multirow{4}{*}{", tamanho, "}")
  for (d in unique(as.list(catanzaroMILP_t$D))) {  
    cat(" &", d, "& ")
    subSP  <- subset(catanzaroSP_t,  size == tamanho & D == d)
    subLP  <- subset(catanzaroLP_t,  size == tamanho & D == d)
    subVND <- subset(catanzaroVND_t, size == tamanho & D == d)
    subLR  <- subset(catanzaroLR_t,  size == tamanho & D == d)
    
    cat(sprintf("%.1f(%.1f) & %.1f(%.1f) & %.1f(%.1f) & %.1f(%.1f) & %.1f(%.1f) & %.1f(%.1f) & %.1f(%.1f) & %.1f(%.1f) \\\\ \n", 
                mean(subVND$gap), 
                sd  (subVND$gap),
                mean(subVND$time), 
                sd  (subVND$time), 
                mean(subSP$gap), 
                sd  (subSP$gap),
                mean(subSP$time), 
                sd  (subSP$time),
                mean(subLP$gap), 
                sd  (subLP$gap),
                mean(subLP$time), 
                sd  (subLP$time),
                mean(subLR$gap), 
                sd  (subLR$gap),
                mean(subLR$time), 
                sd  (subLR$time)))
  }
  cat("\\midrule\n")
}
cat("\\multicolumn{2}{l}{\\textbf{Average}} &")
cat(sprintf("%.1f & %.1f & %.1f & %.1f & %.1f & %.1f \\\\ \n", 
            mean(catanzaroVND_t$gap), 
            mean(catanzaroVND_t$time), 
            mean(catanzaroSP_t$gap), 
            mean(catanzaroSP_t$time),
            mean(catanzaroLP_t$gap), 
            mean(catanzaroLP_t$time)))

cat("\\bottomrule \n")
cat("\\end{tabular}% \n}\n")
cat("\\end{table} \n")
sink()





# tabelas heuristicas karasan

sink("layeredHeuristics.tex", append = FALSE)
cat("\\begin{table}[!t] \n")
cat("\\caption{Results for the heuristics on layered digraphs} \n")
cat("\\label{table:layeredHeuristics} \n")
cat("\\resizebox{\\textwidth}{!}{% \n")
cat("\\begin{tabular}{cccccccc} \n")
cat("\\toprule \n")
cat("            &             &  \\multicolumn{2}{c}{VND~\\cite{Carvalho2018}} & \\multicolumn{2}{c}{$F\\&O_{sp}$}  & \\multicolumn{2}{c}{$F\\&O_{lp}$} \\\\ \\cmidrule(lr){3-4} \\cmidrule(lr){5-6} \\cmidrule(lr){7-8}\n")
cat("$|N|$ & $\\omega$ & \\mc{dev (\\%)} & \\mc{t (s)} & \\mc{dev (\\%)} & \\mc{t (s)} & \\mc{dev (\\%)} & \\mc{t (s)} \\\\ \\midrule \n")
for (tamanho in unique(as.list(karasanMILP_t$size))) {
  cat("\\multirow{4}{*}{", tamanho, "}")
  for (l in unique(as.list(karasanMILP_t$layers))) {
    cat(" &", l, "&")

    subSP  <- subset(karasanSP_t,  size == tamanho & layers == l)
    subLP  <- subset(karasanLP_t,  size == tamanho & layers == l)
    subVND <- subset(karasanVND_t, size == tamanho & layers == l)
    subLR  <- subset(karasanLR_t,  size == tamanho & layers == l)
    
    cat(sprintf("%.1f(%.1f) & %.1f(%.1f) & %.1f(%.1f) & %.1f(%.1f) & %.1f(%.1f) & %.1f(%.1f) & %.1f(%.1f) & %.1f(%.1f) \\\\ \n", 
                mean(subVND$gap), 
                sd  (subVND$gap),
                mean(subVND$time), 
                sd  (subVND$time), 
                mean(subSP$gap), 
                sd  (subSP$gap),
                mean(subSP$time), 
                sd  (subSP$time),
                mean(subLP$gap), 
                sd  (subLP$gap),
                mean(subLP$time), 
                sd  (subLP$time),
                mean(subLR$gap), 
                sd  (subLR$gap),
                mean(subLR$time), 
                sd  (subLR$time)))
  }
  cat("\\midrule\n")
}
cat("\\multicolumn{2}{l}{\\textbf{Average}} &")
cat(sprintf("\\mc{%.1f} & \\mc{%.1f} & \\mc{%.1f} & \\mc{%.1f} & \\mc{%.1f} & \\mc{%.1f} \\\\ \n", 
            mean(karasanVND_t$gap), 
            mean(karasanVND_t$time), 
            mean(karasanSP_t$gap), 
            mean(karasanSP_t$time),
            mean(karasanLP_t$gap), 
            mean(karasanLP_t$time)))

cat("\\bottomrule \n")
cat("\\end{tabular}% \n}\n")
cat("\\end{table} \n")
sink()


# tabela análise DBH
# instancias catanzaro

sink("randomReduction.tex", append = FALSE)
cat("\\begin{table}[!t] \n")
cat("\\caption{Results for the F\\&O on random graphs} \n")
cat("\\label{table:randomFAO} \n")
cat("\\resizebox{\\textwidth}{!}{% \n")
cat("\\begin{tabular}{rcccccccccc} \n")
cat("\\toprule \n")
cat("     &   &       & \\multicolumn{4}{c}{$F\\&O_{sp}$} & \\multicolumn{4}{c}{$F\\&O_{lp}$} \\\\ \\cmidrule(lr){4-7} \\cmidrule(lr){8-11} \n")
cat("Size & D & $|A|$ & $|A'|$ & R (\\%) & t_p (s) & t_t (s) & $|A'|$ & R (\\%) & t_p (s) & t_t (s)  \\\\  \\midrule \n")
for (nodes in unique(as.list(catanzaroSP_t$size))) {
  cat("\\multirow{4}{*}{", nodes, "}")
  for (d in unique(as.list(catanzaroSP_t$D))) {
    cat("&", d, "& ")
    total_arcs <- nodes*(nodes-1) * (d/100);
    sub <- subset(catanzaroSP_t, size == nodes & D == d)
    cat(sprintf("%.1f(%.1f) & %.1f & %.1f(%.1f) & %.1f(%.1f) &", 
                mean(sub$arcs),
                sd(sub$arcs), 
                (mean(sub$arcs)/total_arcs)*100,
                mean(sub$pp_time),
                sd(sub$pp_time),
                mean(sub$time-sub$pp_time),
                sd(sub$time-sub$pp_time)))
    
    sub <- subset(catanzaroLR_t, size == nodes & D == d)
    cat(sprintf("%.1f(%.1f) & %.1f & %.1f(%.1f) & %.1f(%.1f)", 
                mean(sub$arcs),
                sd(sub$arcs), 
                ((mean(sub$arcs)/total_arcs))*100,
                mean(sub$pp_time),
                sd(sub$pp_time),
                mean(sub$time-sub$pp_time),
                sd(sub$time-sub$pp_time)))
    cat("\\\\ \n")
  }
  cat("\\midrule\n")
}

cat("\\multicolumn{4}{l}{\\textbf{Average}} &")
# for (variation in unique(as.list(catanzaroDBH$interval))) {
#  sub <- subset(catanzaroDBH, interval == variation)
#  cat(sprintf(" & %.1f & %.1f &", 
#              mean(sub$timePP),
#              mean(sub$timeTotal)))
#}
cat("\\\\ \n")
cat("\\bottomrule \n")
cat("\\end{tabular}% \n}\n")
cat("\\end{table} \n")
sink()


# layered DBH
sink("layeredReduction.tex", append = FALSE)
cat("\\begin{table}[!t] \n")
cat("\\caption{Results for the F\\&O on random graphs} \n")
cat("\\label{table:randomFAO} \n")
cat("\\resizebox{\\textwidth}{!}{% \n")
cat("\\begin{tabular}{rcccccccccc} \n")
cat("\\toprule \n")
cat("     &   &       & \\multicolumn{4}{c}{$F\\&O_{sp}$} & \\multicolumn{4}{c}{$F\\&O_{lp}$} \\\\ \\cmidrule(lr){4-7} \\cmidrule(lr){8-11} \n")
cat("Size & $\\omega$ & $|A|$ & $|A'|$ & \\mc{R (\\%)} & \\mc{$t_p$ (s)} & \\mc{$t_t$ (s)} & $|A'|$ & \\mc{R (\\%)} & \\mc{$t_p$ (s)} & \\mc{$t_t$ (s)}  \\\\  \\midrule \n")
for (nodes in unique(as.list(karasanSP_t$size))) {
  cat("\\multirow{4}{*}{", nodes, "}")
  for (l in unique(as.list(karasanSP_t$layers))) {
    cat("&", l, "& ")
    total_arcs <- ((nodes/l)-1)*(l*l)+2*l
    sub <- subset(karasanSP_t, size == nodes & layers == l)
    cat(sprintf("& %.1f(%.1f) & %.1f & %.1f(%.1f) & %.1f(%.1f) &", 
                mean(sub$arcs),
                sd(sub$arcs), 
                ((mean(sub$arcs)/total_arcs))*100,
                mean(sub$pp_time),
                sd(sub$pp_time),
                mean(sub$time-sub$pp_time),
                sd(sub$time-sub$pp_time)))
    
    sub <- subset(karasanLR_t, size == nodes & layers == l)
    cat(sprintf("%.1f(%.1f) & %.1f & %.1f(%.1f) & %.1f(%.1f)", 
                mean(sub$arcs),
                sd(sub$arcs), 
                ((mean(sub$arcs)/total_arcs))*100,
                mean(sub$pp_time),
                sd(sub$pp_time),
                mean(sub$time-sub$pp_time),
                sd(sub$time-sub$pp_time)))
    cat("\\\\ \n")
  }
  cat("\\midrule\n")
}
cat("\\bottomrule \n")
cat("\\end{tabular}% \n}\n")
cat("\\end{table} \n")
sink()

shapiro.test()
# arrumando os dados para o teste de Friedman

karasanSP_t[166:180,]$gap <- 9999
karasanLR_t[166:180,]$gap <- 9999
karasanVND_t[136:180,]$gap <- 9999

df <- data.frame(matrix(ncol = 3, nrow = 180))
x <- c("vnd", "faosp", "faolr")
colnames(df) <- x

df$vnd   <- karasanVND_t$gap
df$faosp <- karasanSP_t$gap
df$faolr <- karasanLR_t$gap

friedman.test(as.matrix(df))

bmr = mlr::benchmarkResultFromDataFrame(df)
cd = generateCritDifferencesData(bmr)
plotCritDifferences(cd)

library(PMCMR)

library(dunn.test)

dunn.test(x=list(catanzaroVND_t$gap, catanzaroSP_t$gap, catanzaroLR_t$gap), list = TRUE, label = TRUE, method = "bonferroni")
dunn.test(x=list(karasanVND_t$gap,   karasanSP_t$gap,   karasanLR_t$gap),   list = TRUE, label = TRUE, method = "bonferroni")

dunn.test(df, label = TRUE)

a <- posthoc.friedman.nemenyi.test(as.matrix(df))

df$vnd <- karasanVND_t$gap
df$faosp <- karasanSP_t$gap
df$faolp <- karasanLP_t$gap

posthoc.friedman.nemenyi.test(as.matrix(df))
