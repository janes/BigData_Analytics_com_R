# RProfiler - Performance do script para analise de dados

a <- c(1, 2, 3)
b <- c(4, 5, 6)

# iniciando o profile - guarda todas as informações
?Rprof
Rprof("debuger.txt")
df = data.frame(a, b)
df

# código que não deve fazer parte do profile
Rprof(NULL)
str(df)

# Interrompendo o profile
Rprof()

# sumarizando os resultados
summaryRprof("debuger.txt")

# utilizando um arquivo temporario
Rprof(tem <- tempfile())
example(glm)
Rprof()
summaryRprof(tem)

install.packages("profr")
library(profr)
install.packages("ggplot2")
library(ggplot2)
?profr

x = profr(example(glm))
x
ggplot2(x)











