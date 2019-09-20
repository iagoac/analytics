# open files
setwd("~/Documents/ieee-computers")
library(PMCMR)
simd <-  read.csv("iago-simd.csv",  header = TRUE, sep = ",")
mcore <- read.csv("iago-mcore.csv", header = TRUE, sep = ",")
dist  <- read.csv("iago-dist.csv",  header = TRUE, sep = ",")
batch <- read.csv("iago-batch.csv", header = TRUE, sep = ",")
gray  <- read.csv("iago-gray.csv",  header = TRUE, sep = ",")
order <- read.csv("iago-order.csv", header = TRUE, sep = ",")
watch <- read.csv("iago-watch.csv", header = TRUE, sep = ",")

# experiment 1 -- simd enabled or disabled
simd_yes <- subset(simd, has.simd == "1")
simd_no  <- subset(simd, has.simd == "0")
df <- data.frame(simd_yes$time, simd_yes$complete, simd_no$time, simd_no$complete)

# speedup
mean(subset(df, simd_no.complete == "1")$simd_no.time) / mean(subset(df, simd_no.complete == "1")$simd_yes.time)
# effectively increases the time of those algorithms
for(i in 1:nrow(df)) {
  if (df[i,]$simd_no.complete == "0") {
    df[i,]$simd_no.time <- 99999.99
  }
}
# next, we need to remove the completion data from our data frame
df <- subset(df, simd_yes.complete == "1")
df <- data.frame(df$simd_no.time, df$simd_yes.time)
wilcox.test(df$df.simd_no.time, df$df.simd_yes.time, paired = TRUE)
remove(df, simd, simd_no, simd_yes, i)

# experimento 2 -- multi-core 
mcore_1 <- subset(mcore, threads == "1" & done == "1")
mcore_2 <- subset(mcore, threads == "2" & done == "1")
mcore_4 <- subset(mcore, threads == "4" & done == "1")

# speedups
mean(mcore_1$time) / mean(mcore_4$time)
mean(mcore_2$time) / mean(mcore_4$time)

df <- data.frame(mcore_1$time, mcore_2$time, mcore_4$time)
friedman.test(as.matrix(df))
posthoc.friedman.nemenyi.test(as.matrix(df))
remove(df, mcore_1, mcore_2, mcore_4, mcore)


# experiment 3 -- distributed
dist_1  <- subset(dist, computers == "1")
dist_2  <- subset(dist, computers == "2")
dist_4  <- subset(dist, computers == "4")
dist_8  <- subset(dist, computers == "8")
dist_16 <- subset(dist, computers == "16")

# builds a data.frame to increase the time of those algorithms who could't be run
df <- data.frame(dist_1$time, dist_1$complete, dist_2$time, dist_2$complete, dist_4$time, dist_4$complete, dist_8$time, dist_8$complete, dist_16$time, dist_16$complete)
mean(subset(df, dist_1.complete == "1")$dist_1.time) / mean(subset(df, dist_1.complete == "1")$dist_16.time)
df <- subset(df, dist_16.complete == "1")

# effectively increases the time of those algorithms
for(i in 1:nrow(df)) {
  if (df[i,]$dist_1.complete == "0") {
    df[i,]$dist_1.time <- 99999.99
  }
  if (df[i,]$dist_2.complete == "0") {
    df[i,]$dist_2.time <- 99999.99
  }
  if (df[i,]$dist_4.complete == "0") {
    df[i,]$dist_4.time <- 99999.99
  }
  if (df[i,]$dist_8.complete == "0") {
    df[i,]$dist_8.time <- 99999.99
  }
}

# next, we need to remove the completion data from our data frame
df <- data.frame(df$dist_1.time, df$dist_2.time, df$dist_4.time, df$dist_8.time, df$dist_16.time)

# thus, we can apply the Friedman's test and the subsequent Nemenyi's test
friedman.test(as.matrix(df))
posthoc.friedman.nemenyi.test(as.matrix(df))
remove(df, dist, dist_1, dist_2, dist_4, dist_8, dist_16, i)

# experiment 4 -- memory-reduction
for (b in unique(as.list(batch$bitset.size))) {
  s <- subset(batch, bitset.size == b & complete == "1")
  cat(b, " ", nrow(s), " ", mean(s$time), "\n")
}
