### Transformação
# ... cont do script 00


source("tools/ClassTools.R")
Credit <- read.csv("data/credito.csv", header = F, stringsAsFactors = F)
metaFrame <- data.frame(colNames, isOrdered, I(factOrder))
Credit <- fact.set(Credit, metaFrame)
  
# Balancear o numeto de casos positivos e negativos
Credit <- equ.Frame(Credit, 2)

# Transformando variaveis numericas em variaveis categoricas
toFactors <- c("Duration", "CreditAmount", "Age")
maxVals <- c(100, 1000000, 100)
facNames <- unlist(lapply(toFactors, function(x) paste(x, "_f", sep = "")))
Credit[, facNames] <- Map(function(x, y) quantize.num(Credit[, x], maxval = y), toFactors, maxVals)

str(Credit)
