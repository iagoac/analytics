setwd("~/michele/tangerina")

# uvas <- read.csv("uvas.csv", header = TRUE, sep = ",")
tangerinas <- read.csv("tangerina.csv", header = TRUE, sep = ",")

sink("media_tangerinas.txt")
cat("altura, diametro, firmeza, l_fruto, a_fruto, b_fruto, c_fruto, h_fruto, l_suco, a_suco, b_suco, c_suco, h_suco, l_polpa, a_polpa, b_polpa, c_polpa, h_polpa, peso, volume, rendimento, ph, ss, naoh, at, ratio\n")
for (dat in unique(as.list(uvas$data))) {
  sub1 <- subset(uvas, data == dat)
  for (t in unique(as.list(sub1$tratamento))) {
    sub <- subset(sub1, tratamento == t)
    cat(sprintf("%s, %d, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f\n", 
                dat,
                t,
                mean(sub$altura, na.rm = T),
                mean(sub$diametro, na.rm = T),
                mean(sub$firmeza, na.rm = T),
                mean(sub$l_fruto, na.rm = T),
                mean(sub$a_fruto, na.rm = T),
                mean(sub$b_fruto, na.rm = T),
                mean(sub$c_fruto, na.rm = T),
                mean(sub$h_fruto, na.rm = T),
                mean(sub$l_suco, na.rm = T),
                mean(sub$a_suco, na.rm = T),
                mean(sub$b_suco, na.rm = T),
                mean(sub$c_suco, na.rm = T),
                mean(sub$h_suco, na.rm = T),
                mean(sub$peso, na.rm = T),
                mean(sub$volume, na.rm = T),
                mean(sub$rendimento, na.rm = T),
                mean(sub$ph, na.rm = T),
                mean(sub$ss, na.rm = T),
                mean(sub$naoh, na.rm = T),
                mean(sub$at, na.rm = T),
                mean(sub$ratio, na.rm = T)))
  }
}
sink()

sink("media_tangerinas.txt")
cat("diametro,altura,firmeza,l_casca,a_casca,b_casca,c_casca,h_casca,l_polpa,a_polpa,b_polpa,c_polpa,h_polpa,l_suco,a_suco,b_suco,c_suco,h_suco,peso,volume,rendimento,ph,ss,naoh,at,ratio\n")
for (dat in unique(as.list(tangerinas$data))) {
  sub1 <- subset(tangerinas, data == dat)
  for (t in unique(as.list(sub1$tratamento))) {
    sub <- subset(sub1, tratamento == t)
    cat(sprintf("%s, %d, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f\n", 
                dat,
                t,
                mean(sub$diametro, na.rm = T),
                mean(sub$altura, na.rm = T),
                mean(sub$firmeza, na.rm = T),
                mean(sub$l_casca, na.rm = T),
                mean(sub$a_casca, na.rm = T),
                mean(sub$b_casca, na.rm = T),
                mean(sub$c_casca, na.rm = T),
                mean(sub$h_casca, na.rm = T),
                mean(sub$l_polpa, na.rm = T),
                mean(sub$a_polpa, na.rm = T),
                mean(sub$b_polpa, na.rm = T),
                mean(sub$c_polpa, na.rm = T),
                mean(sub$h_polpa, na.rm = T),
                mean(sub$l_suco, na.rm = T),
                mean(sub$a_suco, na.rm = T),
                mean(sub$b_suco, na.rm = T),
                mean(sub$c_suco, na.rm = T),
                mean(sub$h_suco, na.rm = T),
                mean(sub$peso, na.rm = T),
                mean(sub$volume, na.rm = T),
                mean(sub$rendimento, na.rm = T),
                mean(sub$ph, na.rm = T),
                mean(sub$ss, na.rm = T),
                mean(sub$naoh, na.rm = T),
                mean(sub$at, na.rm = T),
                mean(sub$ratio, na.rm = T)))
  }
}
sink()