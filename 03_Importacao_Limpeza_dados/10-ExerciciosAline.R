# Exercicios Capitulo 4


# Exercicio 1 - Encontre e fa�a a corre��o do erro na instru��o abaixo:
write.table(mtcars, file = "mtcars2.txt", sep = "|", col.names = FALSE, qmethod = "double")
?write.table



# Exercicio 2 - Encontre e fa�a a corre��o do erro na instru��o abaixo:
install.packages("readr")
library(readr)

df_iris <- read_csv("iris.csv", col_types = list(
  Sepal.Length = col_double(),
  Sepal.Width = col_double(),
  Petal.Length = col_double(),
  Petal.Width = col_double(),
  Species = col_factor(c("setosa", "versicolor", "virginica"))
))


# Exercicio 3 - Encontre e fa�a a corre��o do erro na instru��o abaixo:
install.packages("xlsx")
library(xlsx)
df2 <- read.xlsx("UrbanPop.xlsx", sheetIndex = 3)



# Exercicio 4 - Encontre e fa�a a corre��o do erro na instru��o abaixo:
df_sono <- read_csv("http://datascienceacademy.com.br/blog/aluno/RFundamentos/Datasets/Parte3/sono.csv", col_types = list(
  nome = col_character(),
  cidade = col_character(),
  pais = col_character(),
  sono_total = col_double(),
  sono_ciclo = col_double(),
  sono_indice = col_double(),
  peso = col_integer()
))
library(dplyr)
sleepData <- select(df_sono, nome, sono_total)
df_sono %>%
  select(nome, cidade, sono_total) %>%
  arrange(cidade, sono_total) %>%
  head





# Exercicio 5 - Encontre e fa�a a corre��o do erro na instru��o abaixo:
install.packages("tidyr")
library(tidyr)
library(ggplot2)
set.seed(1)

df3 <- data.frame(
  participante = c("p1", "p2", "p3", "p4", "p5", "p6"),
  info = c("g1m", "g1m", "g1f", "g2m", "g2m", "g2m"),
  day1score = rnorm(n = 6, mean = 80, sd = 15),
  day2score = rnorm(n = 6, mean = 88, sd = 8)
)

df3 %>%
  gather(day, score, c(day1score, day2score)) %>%
  separate(col = info, into = c("group", "gender"), sep = 2) %>%
  ggplot(aes(x = day, y = score)) + 
  geom_point() +
  facet_wrap(~ group) +
  geom_smooth(method = "lm", aes(group = 1), se = F)
