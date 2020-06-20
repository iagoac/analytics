d10 <- read.csv("Cata_10dias.csv", header = TRUE, sep = ";")

# removing a last empty column
d10 <- d10[,-44]

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("mixOmics")

if(!require(psych)){install.packages("psych")}
if(!require(RVAideMemoire)){install.packages("RVAideMemoire")}
if(!require(coin)){install.packages("coin")}
if(!require(reshape2)){install.packages("reshape2")}
if(!require(rcompanion)){install.packages("rcompanion")}

library("RVAideMemoire")

cochran.qtest(Presen.a_casca ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Casca_brilhante ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Casca_amarelada ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Casca_grossa  ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Casca_ressecada ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(casca_homog.nea ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(casca_gordurosa ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Interior_brilhante ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(interior_branco ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Interior_homog.neo ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Aspecto_quebradi.o ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Opaco ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Presen.a_furos ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Apar.ncia_seca ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(A_manteiga ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(A_fermentado ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(A_soro_de_leite ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(A_coalhada ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(A_leite ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(A_adocicado ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(A_suave ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Gosto_acido ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Gosto_salgado ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Gosto_adocicado ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Gosto_amargo ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Sabor_fermentado ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Sabor_amanteigado ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Sabor_ran.oso ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Sabor_leite ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Sabor_suave ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Sabor_equilibrado ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Sabor_queijo_Minas ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Quebradi.a ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Firme ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Cremosa ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Borrachenta ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Esfarelada ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Lisa ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Macia ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Compacta ~ Amostra | Provador, data = d10)$p.value
cochran.qtest(Consistente  ~ Amostra | Provador, data = d10)$p.value

