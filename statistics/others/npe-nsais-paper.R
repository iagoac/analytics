# leitura do arquivo .csv
data <- read.csv("iago-tst.csv", header = TRUE, sep = ",")

# separa os 7 algoritimos
es_ga     <- subset(data, algorithm == "es-ga")
es_nsais  <- subset(data, algorithm == "es-nsais")
es_nsga   <- subset(data, algorithm == "es-nsga")
nrk_nsga  <- subset(data, algorithm == "nrk-nsga")
nrk_nsais <- subset(data, algorithm == "nrk-nsais")
nd_nsais  <- subset(data, algorithm == "nd-nsais")
npe_nsais <- subset(data, algorithm == "ndp-nsais")
nrk_spea  <- subset(data, algorithm == "nrk-spea")
es_spea   <- subset(data, algorithm == "es-spea")

# es_ga tem 4 funções objetivos
# Vamos tratalas como 4 algoritmos diferentes
es_gaF1 <- subset(es_ga, objective == "F1")
es_gaF2 <- subset(es_ga, objective == "F2")
es_gaF3 <- subset(es_ga, objective == "F3")
es_gaF4 <- subset(es_ga, objective == "F4")


averages <- as.data.frame(matrix(0, nrow=210, ncol = 15))


colnames(averages) <- c("size",
                        "degree",
                        "repetition",
                        "es_gaF1", 
                        "es_gaF2", 
                        "es_gaF3", 
                        "es_gaF4",
                        "es_nsais",
                        "es_nsga",
                        "nd_nsais",
                        "npe_nsais",
                        "nrk_nsga",
                        "nrk_nsais",
                        "nrk_spea",
                        "es_spea")

count <- 1
for (nodes in unique(as.list(data$size))) {
  for (deg in unique(as.list(data$degree))) {
    for (rep in unique(as.list(data$repetition))) {
      # cat(nodes, " ", deg, " ", rep,  "\n")
      averages$size[count]       <- nodes
      averages$degree[count]     <- deg
      averages$repetition[count] <- rep
      averages$es_gaF1[count]    <- mean(subset(es_gaF1,   size == nodes & degree == deg & repetition == rep)$hypervolume)
      averages$es_gaF2[count]    <- mean(subset(es_gaF2,   size == nodes & degree == deg & repetition == rep)$hypervolume)
      averages$es_gaF3[count]    <- mean(subset(es_gaF3,   size == nodes & degree == deg & repetition == rep)$hypervolume)
      averages$es_gaF4[count]    <- mean(subset(es_gaF4,   size == nodes & degree == deg & repetition == rep)$hypervolume)
      averages$es_nsais[count]   <- mean(subset(es_nsais,  size == nodes & degree == deg & repetition == rep)$hypervolume)
      averages$es_nsga[count]    <- mean(subset(es_nsga,   size == nodes & degree == deg & repetition == rep)$hypervolume)
      averages$nd_nsais[count]   <- mean(subset(nd_nsais,  size == nodes & degree == deg & repetition == rep)$hypervolume)
      averages$npe_nsais[count]  <- mean(subset(npe_nsais, size == nodes & degree == deg & repetition == rep)$hypervolume)
      averages$nrk_nsga[count]   <- mean(subset(nrk_nsga,  size == nodes & degree == deg & repetition == rep)$hypervolume)
      averages$nrk_nsais[count]  <- mean(subset(nrk_nsais, size == nodes & degree == deg & repetition == rep)$hypervolume)
      averages$nrk_spea[count]   <- mean(subset(nrk_spea,  size == nodes & degree == deg & repetition == rep)$hypervolume)
      averages$es_spea[count]    <- mean(subset(es_spea,   size == nodes & degree == deg & repetition == rep)$hypervolume)
      count <- count + 1 
    }
  }
}

# computa a melhor solução para cada tupla (#vertices, grau)
best <- as.data.frame(matrix(0, nrow=nrow(averages), ncol=4))
colnames(best) <- c("size", "degree", "repetition", "star")

for (i in 1:nrow(averages)) {
  best$size[i]       <- averages$size[i]
  best$degree[i]     <- averages$degree[i]
  best$repetition[i] <- averages$repetition[i]
  best$star[i]       <- max(averages$es_gaF1[i],
                            averages$es_gaF2[i], 
                            averages$es_gaF3[i], 
                            averages$es_gaF4[i], 
                            averages$es_nsais[i], 
                            averages$es_nsga[i], 
                            averages$nd_nsais[i], 
                            averages$npe_nsais[i], 
                            averages$nrk_nsga[i], 
                            averages$nrk_nsais[i],
                            averages$nrk_spea[i],
                            averages$es_spea[i])
}


# calcula os desvios percentuais em relação a melhor solução
devs <- as.data.frame(matrix(0, nrow=nrow(averages), ncol = 15))
colnames(devs) <- c("size",
                    "degree",
                    "repetition",
                    "es_gaF1", 
                    "es_gaF2", 
                    "es_gaF3", 
                    "es_gaF4",
                    "es_nsais",
                    "es_nsga",
                    "nd_nsais",
                    "npe_nsais",
                    "nrk_nsga",
                    "nrk_nsais",
                    "nrk_spea",
                    "es_spea")

for (i in 1:nrow(averages)) {
  devs$size[i]       <- averages$size[i]
  devs$degree[i]     <- averages$degree[i]
  devs$repetition[i] <- averages$repetition[i]
  devs$es_gaF1[i]    <- ((best$star[i] - averages$es_gaF1[i])   / best$star[i])
  devs$es_gaF2[i]    <- ((best$star[i] - averages$es_gaF2[i])   / best$star[i])
  devs$es_gaF3[i]    <- ((best$star[i] - averages$es_gaF3[i])   / best$star[i])
  devs$es_gaF4[i]    <- ((best$star[i] - averages$es_gaF4[i])   / best$star[i])
  devs$es_nsais[i]   <- ((best$star[i] - averages$es_nsais[i])  / best$star[i])
  devs$es_nsga[i]    <- ((best$star[i] - averages$es_nsga[i])   / best$star[i])
  devs$nd_nsais[i]   <- ((best$star[i] - averages$nd_nsais[i])  / best$star[i])
  devs$npe_nsais[i]  <- ((best$star[i] - averages$npe_nsais[i]) / best$star[i])
  devs$nrk_nsga[i]   <- ((best$star[i] - averages$nrk_nsga[i])  / best$star[i])
  devs$nrk_nsais[i]  <- ((best$star[i] - averages$nrk_nsais[i]) / best$star[i])
  devs$nrk_spea[i]   <- ((best$star[i] - averages$nrk_spea[i])  / best$star[i])
  devs$es_spea[i]    <- ((best$star[i] - averages$es_spea[i])   / best$star[i])
}

# imprime as tres tabelas em arquivo

#tableName <- sprintf("table%.0f.tex",deg)
#sink(tableName)
sink("tableSWEVO.tex")
cat("\\textbf{Size} & \\textbf{Avg. Degree} & \\textbf{NPE-NSAIS} & \\textbf{ESE-NSAIS} & \\textbf{ES-NSGA} & \\textbf{NRK-NSGA} & \\textbf{ES-SPEA} & \\textbf{NRK-SPEA} \\\\ \\midrule \n")
for (nodes in unique(as.list(devs$size))) {
  cat("\\multirow{3}{*}{", nodes, "}")
  for (deg in c(3, 5, 10)) {
    subDevs <- subset(devs, size == nodes & degree == deg)
    cat(sprintf("& %.0f & %.2f(%.2f) & %.2f(%.2f) & %.2f(%.2f) & %.2f(%.2f) & %.2f(%.2f) & %.2f(%.2f) \\\\ \n",
                deg,
                #100*mean(subDevs$nrk_nsga),
                #100*sd  (subDevs$nrk_nsga),
                #100*mean(subDevs$es_nsga),
                #100*sd  (subDevs$es_nsga),
                #100*mean(subDevs$nrk_nsais),
                #100*sd  (subDevs$nrk_nsais),
                #100*mean(subDevs$es_nsais),
                #100*sd  (subDevs$es_nsais),
                100*mean(subDevs$es_nsais),
                100*sd  (subDevs$es_nsais),
                100*mean(subDevs$es_nsga),
                100*sd  (subDevs$es_nsga),
                100*mean(subDevs$es_spea),
                100*sd  (subDevs$es_spea),
                100*mean(subDevs$nrk_nsais),
                100*sd  (subDevs$nrk_nsais),
                100*mean(subDevs$nrk_nsga),
                100*sd  (subDevs$nrk_nsga),
                100*mean(subDevs$nrk_spea),
                100*sd  (subDevs$nrk_spea)))
  }
  cat("\\midrule \n")
}
cat("\\multicol{2}{r}{\\textbf{Average}} & ")
subDevs <- subset(devs, degree == deg)
cat(sprintf("%.2f(%.2f) & %.2f(%.2f) & %.2f(%.2f) & %.2f(%.2f) & %.2f(%.2f) & %.2f(%.2f) \\\\ \n",
            100*mean(subDevs$es_nsais),
            100*sd  (subDevs$es_nsais),
            100*mean(subDevs$es_nsga),
            100*sd  (subDevs$es_nsga),
            100*mean(subDevs$es_spea),
            100*sd  (subDevs$es_spea),
            100*mean(subDevs$nrk_nsais),
            100*sd  (subDevs$nrk_nsais),
            100*mean(subDevs$nrk_nsga),
            100*sd  (subDevs$nrk_nsga),
            100*mean(subDevs$nrk_spea),
            100*sd  (subDevs$nrk_spea)))
cat("\\bottomrule")
sink()


# vamos fazer o teste de friedman
frData <- as.matrix(devs)

wilcox.test(devs$npe_nsais, devs$nrk_spea, paired = TRUE, alternative = "less")

friedman.test(frData[,8:15])
library(PMCMR)
library(multcompView)
a <- posthoc.friedman.nemenyi.test(frData[,8:15], p.adjust.method = "BH")
frData[,c(8,15)]

