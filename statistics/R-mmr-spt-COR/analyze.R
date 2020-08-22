setwd("~/mmr-spt")

catanzaro <- read.csv("catanzaro_sorted.csv", header = TRUE, sep = ",")
karasan   <- read.csv("karasan_sorted.csv",   header = TRUE, sep = ",")

catanzaroMILP_t <- subset(catanzaro, algorithm == "exact")
catanzaroVND_t  <- subset(catanzaro, algorithm == "vnd")
catanzaroSBA_t   <- subset(catanzaro, algorithm == "faoamu")
catanzaroLR_t   <- subset(catanzaro, algorithm == "faolr")


karasanMILP_t <- subset(karasan, algorithm == "exact")
karasanVND_t  <- subset(karasan, algorithm == "vnd")
karasanSBA_t   <- subset(karasan, algorithm == "faoamu")
karasanLR_t   <- subset(karasan, algorithm == "faolr")

catanzaroMILP <- subset(catanzaroMILP_t)
catanzaroVND  <- subset(catanzaroVND_t)
catanzaroSBA   <- subset(catanzaroSBA_t)
catanzaroLR   <- subset(catanzaroLR_t)

karasanMILP <- subset(karasanMILP_t)
karasanVND  <- subset(karasanVND_t)
karasanSBA   <- subset(karasanSBA_t)
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
                           catanzaroSBA_t$primal[i], 
                           catanzaroLR_t$primal[i])
  
  best$karasan[i] <- min(karasanMILP_t$primal[i], 
                         karasanVND_t$primal[i], 
                         karasanSBA_t$primal[i], 
                         karasanLR_t$primal[i])
}


a <- subset(karasanSBA_t,  size == 200 & layers == 5)
b <- subset(karasanLR_t,   size == 200 & layers == 5)
c <- subset(karasanMILP_t, size == 200 & layers == 5)
d <- subset(karasanVND_t,  size == 200 & layers == 5)
e <- a


for (i in 1:nrow(a)) {
  e$primal[i] <- min(a$primal[i], b$primal[i], c$primal[i], d$primal[i])
  a$gap[i] = 100*((a$primal[i]-e$primal[i])/e$primal[i])
  b$gap[i] = 100*((b$primal[i]-e$primal[i])/e$primal[i])
  d$gap[i] = 100*((d$primal[i]-e$primal[i])/e$primal[i])
}

mean(a$gap)
sd(a$gap)
mean(b$gap)
sd(b$gap)
mean(d$gap)
sd(d$gap)



for (i in (1+nrow(catanzaroMILP_t)):nrow(catanzaroLR_t)) {
    best$catanzaro[i] <- min(catanzaroSBA_t$primal[i], 
                           catanzaroMILP_t$primal[i],
                           catanzaroVND_t$primal[i],
                           catanzaroLR_t$primal[i])
  
  best$karasan[i] <- min(karasanMILP_t$primal[i], 
                         karasanVND_t$primal[i], 
                         karasanSBA_t$primal[i], 
                         karasanLR_t$primal[i])
}

for (i in (1+nrow(catanzaroLR_t)):nrow(karasanMILP_t)) {
  best$catanzaro[i] <- catanzaroSBA_t$primal[i]
  best$karasan[i] <- min(karasanMILP_t$primal[i], 
                         karasanVND_t$primal[i], 
                         karasanLR_t$primal[i])
}

# cat(k_milp/60*100, "&", k_vnd/60*100, "&", k_sp/60*100, "&", k_lp/60*100, "\n")
# cat(c_milp/60*100, "&", c_vnd/60*100, "&", c_sp/60*100, "&", c_lp/60*100)

# average
# cat((k_milp+c_milp)/480*100, "&", (k_vnd+c_vnd)/480*100, "&", (k_sp+c_sp)/480*100, "&", (k_lp+c_lp)/480*100)

catanzaroSBA_t$gap = 100*((catanzaroSBA_t$primal-best$catanzaro)/best$catanzaro)
catanzaroLR_t$gap = 100*((catanzaroLR_t$primal-best$catanzaro[1:165])/best$catanzaro[1:165])
catanzaroVND_t$gap = 100*((catanzaroVND_t$primal-best$catanzaro[1:135])/best$catanzaro[1:135])

karasanSBA_t$gap = 100*((karasanSBA_t$primal-best$karasan)/best$karasan)
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



# Tabela heuristicas catanzaro
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
    subSBA  <- subset(catanzaroSBA_t,  size == tamanho & D == d)
    subVND <- subset(catanzaroVND_t, size == tamanho & D == d)
    subLR  <- subset(catanzaroLR_t,  size == tamanho & D == d)
    
    cat(sprintf("%.1f(%.1f) & %.1f(%.1f) & %.1f(%.1f) & %.1f(%.1f) & %.1f(%.1f) & %.1f(%.1f) \\\\ \n", 
                mean(subSBA$gap), 
                sd  (subSBA$gap),
                mean(subSBA$time), 
                sd  (subSBA$time),
                mean(subVND$gap), 
                sd  (subVND$gap),
                mean(subVND$time), 
                sd  (subVND$time), 
                mean(subLR$gap), 
                sd  (subLR$gap),
                mean(subLR$time), 
                sd  (subLR$time)))
  }
  cat("\\midrule\n")
}
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
cat("            &             &  \\multicolumn{2}{c}{VND~\\cite{Carvalho2018}} & \\multicolumn{2}{c}{$FO-SBA$}  & \\multicolumn{2}{c}{$F\\&O_{lp}$} \\\\ \\cmidrule(lr){3-4} \\cmidrule(lr){5-6} \\cmidrule(lr){7-8}\n")
cat("$|N|$ & $\\omega$ & \\mc{dev (\\%)} & \\mc{t (s)} & \\mc{dev (\\%)} & \\mc{t (s)} & \\mc{dev (\\%)} & \\mc{t (s)} \\\\ \\midrule \n")
for (tamanho in unique(as.list(karasanMILP_t$size))) {
  cat("\\multirow{4}{*}{", tamanho, "}")
  for (l in unique(as.list(karasanMILP_t$layers))) {
    cat(" &", l, "&")

    subSP  <- subset(karasanSBA_t,  size == tamanho & layers == l)
    subLR  <- subset(karasanLR_t,  size == tamanho & layers == l)
    
    cat(sprintf("%.1f(%.1f) & %.1f(%.1f) \\\\ \n", 
                #mean(subVND$gap), 
                #sd  (subVND$gap),
                #mean(subVND$time), 
                #sd  (subVND$time), 
                mean(subSP$gap), 
                sd  (subSP$gap),
                mean(subSP$time), 
                sd  (subSP$time)))
                #mean(subLR$gap), 
                #sd  (subLR$gap),
                #mean(subLR$time), 
                #sd  (subLR$time)))
  }
  cat("\\midrule\n")
}
# cat("\\multicolumn{2}{l}{\\textbf{Average}} &")
# cat(sprintf("\\mc{%.1f} & \\mc{%.1f} & \\mc{%.1f} & \\mc{%.1f} & \\mc{%.1f} & \\mc{%.1f} \\\\ \n", 
#            mean(karasanVND_t$gap), 
#            mean(karasanVND_t$time), 
#            mean(karasanSP_t$gap), 
#            mean(karasanSP_t$time),
#            mean(karasanLP_t$gap), 
#            mean(karasanLP_t$time)))

#cat("\\bottomrule \n")
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
for (nodes in unique(as.list(catanzaroSBA_t$size))) {
  cat("\\multirow{4}{*}{", nodes, "}")
  for (d in unique(as.list(catanzaroSBA_t$D))) {
    cat("&", d, "& ")
    total_arcs <- nodes*(nodes-1) * (d/100);
    sub <- subset(catanzaroSBA_t, size == nodes & D == d)
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
for (nodes in unique(as.list(karasanSBA_t$size))) {
  cat("\\multirow{4}{*}{", nodes, "}")
  for (l in unique(as.list(karasanSBA_t$layers))) {
    cat("&", l, "& ")
    total_arcs <- ((nodes/l)-1)*(l*l)+2*l
    sub <- subset(karasanSBA_t, size == nodes & layers == l)
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
x <- c("vnd", "faosba", "faolr")
colnames(df) <- x

df$vnd   <- karasanVND_t$gap
df$faosba <- karasanSBA_t$gap
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

posthoc.friedman.nemenyi.test(as.matrix(df))

df$vnd <- karasanVND_t$gap
df$faosp <- karasanSP_t$gap
df$faolp <- karasanLP_t$gap

posthoc.friedman.nemenyi.test(as.matrix(df))
