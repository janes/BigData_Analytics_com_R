# Pacotes e instala��o de pacotes

# De onde vem as fun��es? Pacotes (conjuntos de fun��es)
# Quando voc� inicia o RStudio, alguns pacotes s�o 
# carregados por padr�o

search()

install.packages(c("ggvis", "tm", "dplyr"))

library(ggvis)
library(tm)
require(dplyr)

search()
?require
detach(package:dplyr)
?attach

ls(pos = "package:tm")
ls(getNamespace("tm"), all.names = TRUE)

lsf.str("package:tm")
lsf.str("package:ggplot2")
library(ggplot2)
lsf.str("package:ggplot2")

# R possui um conjunto de datasets preinstalados. Verificar datasets package

library(MASS)
data()

?lynx
head(lynx)
head(iris)
tail(lynx)
summary(lynx)

plot(lynx)
hist(lynx)
head(iris)
iris$Sepal.Length
sum(iris$Sepal.Length)

attach(iris)
sum(iris$Sepal.Length)
