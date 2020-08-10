requiredPackages = c('MatrixCorrelation')
for(p in requiredPackages){
  if(!require(p,character.only = TRUE)) install.packages(p)
  library(p,character.only = TRUE)
}
remove(p, requiredPackages)

matriz_um <- matrix(
  c(2.59,2.15,4.59,4.68,4.56,4.35,4.32,
    2.04,2.26,4.27,4.46,4.53,4.71,4.98,
    2.15,2.30,4.32,4.54,4.58,4.54,4.83,
    2.03,2.44,4.40,4.78,5.04,4.49,4.07,
    2.09,2.50,4.27,4.94,4.88,4.36,4.19),
  nrow = 5, # numero de linhas da matriz_1
  ncol = 7, # numero de colunas da matriz_1
  byrow = TRUE)


matriz_2 <- matrix(
  c(3.53,2.16,4.68,4.32,4.79,4.74,3.79,
    2.58,2.32,4.32,4.26,4.32,4.89,5.32,
    2.58,2.53,4.21,4.79,4.47,4.58,4.84,
    2.53,2.63,3.68,4.84,5.58,5.26,3.47,
    2.53,2.37,3.84,5.05,5.42,5.37,3.42),
  nrow = 5, # numero de linhas da matriz_2
  ncol = 7, # numero de colunas da matriz_2
  byrow = TRUE)


allCorrelations(consumers,specialists,methods = "RV")
