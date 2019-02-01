# Big Data na prática- Temperatura média nas cidades Brasileiras

# verificando diretório
getwd()
setwd("C:/Projetos/Git_Projetos/BD_Analytics_com_R/02_R_fundamentos")

# Dataset:
# Berkeley Earth
# http://berkeleyearth.org/data
# TemperaturasGlobais.csv ~ 78 MB (zip) ~ 496 MB (unzip)

# Instalando e Carregando Pacotes
# Obs: os pacotes precisam ser instalados apenas uma vez. Se já instalou em outros scripts, não é necessário instalar novamente!
install.packages("readr")
install.packages("data.table")
install.packages("dplyr")
install.packages("ggplot2")
library(readr)
library(dplyr)
library(ggplot2)
library(scales)
library(data.table)
#library(dtplyr)

# carregando os dados (usando um timer para comprar o tempo de carregamento ccom diferentes funções)

# usando read.csv2()
system.time(df_teste1 <- read.csv2("data/TemperaturasGlobais.csv"))

# usando read.table()
system.time(df_teste2 <- read.table("data/TemperaturasGlobais.csv"))

#  Usando fread()
?fread
system.time(df <- fread("data/TemperaturasGlobais.csv"))
system.time(df2 <- fread("data/TemperaturasGlobais.csv"))

# criando subsets ddos dados carregados
cidadesBrasil <- subset(df, Country == 'Brazil')
cidadesBrasil <- na.omit(cidadesBrasil)
head(cidadesBrasil)
nrow(df)
nrow(cidadesBrasil)
dim(cidadesBrasil)

# Preparando e organizando

# convertendo as datas
cidadesBrasil$dt <- as.POSIXct(cidadesBrasil$dt, format='%Y-%m-%d')
cidadesBrasil$Month <- month(cidadesBrasil$dt)
cidadesBrasil$Year <- year(cidadesBrasil$dt)

# Carregando os subsets

# Palmas
plm <- subset(cidadesBrasil, City == 'Palmas')
plm <- subset(plm, Year %in% c(1796,1846,1896,1946,1996,2012))

# Curitiba
crt <- subset(cidadesBrasil, City == 'Curitiba')
crt <- subset(crt, Year %in% c(1796,1846,1896,1946,1996,2012))

# Recife
recf <- subset(cidadesBrasil, City == 'Recife')
recf <- subset(recf, Year %in% c(1796,1846,1896,1946,1996,2012))

# Construindo os plots
p_plm <- ggplot(plm, aes(x = (Month), y = AverageTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE,fill = NA, size = 2) +
  theme_light(base_size = 20) +
  xlab("Mês") +
  ylab("Temperatura média") +
  scale_color_discrete("") +
  ggtitle("Temperatura média ao longo dos anos em Palmas") + 
  theme(plot.title = element_text(size = 18))

p_crt <- ggplot(crt, aes(x = (Month), y = AverageTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE,fill = NA, size = 2) +
  theme_light(base_size = 20) +
  xlab("Mês") +
  ylab("Temperatura média") +
  scale_color_discrete("") +
  ggtitle("Temperatura média ao longo dos anos em Curitiba") + 
  theme(plot.title = element_text(size = 18))


p_recf <- ggplot(recf, aes(x = (Month), y = AverageTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE,fill = NA, size = 2) +
  theme_light(base_size = 20) +
  xlab("Mês") +
  ylab("Temperatura média") +
  scale_color_discrete("") +
  ggtitle("Temperatura média ao longo dos anos em Recife") + 
  theme(plot.title = element_text(size = 18))

# Plotando
p_plm
p_crt
p_recf


