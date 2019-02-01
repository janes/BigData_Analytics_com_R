# Gráficos em R

getwd()

# lista de pacotes base carregados
search()

# Demo (demonstra a utilização dos gráficos)
demo("graphics")

# plot básico
x = 5:7
y = 8:10
plot(x,y)
?plot

altura <- c(145, 167, 176, 123, 150)
largura <- c(51, 63, 64, 40, 55)
plot(altura, largura)

# plotando um Dataframe
?lynx
plot(lynx)
plot(lynx, ylab = "Plots com Dataframes", xlab = "")
plot(lynx, ylab = "Plots com Dataframes", xlab = "Observações")
plot(lynx, main = "Plots com Dataframes", col = "red")
plot(lynx, main = "Plots com Dataframes", col = "red", col.main = 52, cex.main = 1.5)

library(datasets)
hist(warpbreaks$breaks)

airquality
transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")

## Especificando os parâmetros
# col - cor do plotting
# lty - tipo de linha
# lwd - largura de linha
# pch - símbolo no plot
# xlab - label do eixo x
# ylab - label do eixo y
# las - como os labels dos eixos são orientados
# bg - background color
# mfrow - número de plots por linha
# mfcool - número de plots por coluna

## Funções básicas de Plot
# plot() - scatterplots
# lines() -  adiciona linhas ao gráfico
# points() - adiciona pontos ao gráfico
# text() - adiciona label ao gráfico
# title() - adiciona título ao gráfico

?par
par()
par("pch")
par("lty")
x = 2:4
plot(x, pch = "c")
par(mfrow = c(2,2), col.axis = "red")
plot(1:8, las = 0, xlab = "xlab", ylab = "ylab", main = "LAS = 0")
plot(1:8, las = 1, xlab = "xlab", ylab = "ylab", main = "LAS = 1")
plot(1:8, las = 2, xlab = "xlab", ylab = "ylab", main = "LAS = 2")
plot(1:8, las = 3, xlab = "xlab", ylab = "ylab", main = "LAS = 3")
legend("topright", pch = 1, col = c("blue", "red"), legend = c("Var1", "Var2"))


# Cores disponíveis
colors()

# Salvando os gráficos

# png
png("Grafico1.png", width = 500, height = 500, res = 72)
plot(iris$Sepal.Length, iris$Petal.Length, col = iris$Species,
     main = "Gráfico gerado a partir do Iris")
dev.off()

# pdf
pdf("Grafico2.pdf")
plot(iris$Sepal.Length, iris$Petal.Length, col = iris$Species,
     main = "Gráfico gerado a partir do Iris")
dev.off()

# Estendendo as funções do plot
install.packages("plotrix")
library(plotrix)
?plotrix

par(mfrow = c(1,1), col.axis = "red")
plot(1:6, las = 3, xlab = "lty 1:6", ylab = "", main = "Mais opções ao plot")
ablineclip(v = 1, lty = 1, col = "sienna2", lwd = 2)
ablineclip(v = 2, lty = 1, col = "sienna2", lwd = 2)
ablineclip(v = 3, lty = 1, col = "sienna2", lwd = 2)
ablineclip(v = 4, lty = 1, col = "sienna2", lwd = 2)
ablineclip(v = 5, lty = 1, col = "sienna2", lwd = 2)
ablineclip(v = 6, lty = 1, col = "sienna2", lwd = 2)
ablineclip(v = 7, lty = 1, col = "sienna2", lwd = 2)


plot(lynx)
plot(lynx, type = "p", main = "Type p")
plot(lynx, type = "l", main = "Type l")
plot(lynx, type = "b", main = "Type b")
plot(lynx, type = "o", main = "Type o")
plot(lynx, type = "h", main = "Type h")
plot(lynx, type = "s", main = "Type s")
plot(lynx, type = "n", main = "Type n")

# Dois plots juntos
par(mar = c(4,3,3,3), col.axis = "black")
plot(cars$speed, type = "s", col = "red", bty = "n", xlab = "Cars ID", ylab = "")
text(8, 14, "Velocidade", cex = 0.85, col = "red")
par(new = T)
plot(cars$dist, type = "s", bty = "n", ann = F, axes = F, col = "darkblue")
axis(side = 4)
text(37, 18, "Distância", cex = 0.85, col = "darkblue")
title(main = "Velocidade x Distância")

# Plots a partir de datasets
df <- read.csv("pibpercap.csv", stringsAsFactors = F)
df_1982 <- subset(df, ano == 1982)
plot(expectativa ~ pibpercap, data = df_1982, log = "x")
head(df)

mycol <- c(Asia = "tomato", Europe = "Chocolate4", Africa = "dodgerblue2",
           Americas = "darkgoldenrod1", Oceania = "green4")
plot(expectativa ~ pibpercap, data = df_1982, log = "x", col = mycol[continente])

mycex <- function(var, r, f = sqrt){
  x = f(var)
  x_scaled = (x - min(x)) / (max(x) - min(x))
  r[1] + x_scaled * (r[2] - r[1])
}

plot(expectativa ~ pibpercap, data = df_1982, log = "x",
     col = mycol[continente],
     cex = mycex(pop, r = c(0.2,10)))


################################################################
### Scatterplots

# Define os dados
set.seed(67)
x = rnorm(10,5,7)
y = rpois(10,7)
z = rnorm(10,6,7)
t = rpois(10,9)

# cria o plot
plot(x, y, col = 123, pch = 10, main = "Multi Scatterplot",
     col.main = "red", cex.main = 1.5, xlab = "indep",
     ylab = "depend")

# Adiciona outros dados
points(z, t, col = "blue", pch = 4)
points(y, t, col = 777, pch = 9)

# Cria Legenda
legend(-6,5.9, legend = c("Nível 1", "Nível 2", "Nível 3"),
       col = c(123, "blue", 777), pch = c(10,4,9),
       cex = 0.65, bty = "n")


################################################################
### Boxplots
?boxplot
?sleep

# Permite utilizar as colunas sem especificar o nome do dataset
attach(sleep)

# Construção do boxplot
sleepboxplot = boxplot(data = sleep, extra ~ group,
                       main = "Duração do sono",
                       col.main = "red", ylab = "horas", xlab = "Droga")

# cálculo da média
means = by(extra, group, mean)
means

# Adiciona a média ao gráfico
points(means, col = "red")

# Boxplot horizontal
horizontalboxplot = boxplot(data = sleep, extra ~ group,
                            ylab = "", xlab = "", horizontal = T)

horizontalboxplot = boxplot(data = sleep, extra ~ group,
                            ylab = "", xlab = "", horizontal = T,
                            col = c("blue", "red"))

################################################################
### Histogramas
?hist
?cars

# Definindo os dados
dados = cars$speed

# Contruindo um histograma
hist(dados)

# Conforme consta no help, o parâmetro breaks pode ser um dos itens abaixo:
# Um vetor para os pontos de quebra entre as células do histograma
# Uma função para calcular o vetor de breakpoints
# Um único número que representa o número de células para o histograma
# Uma cadeia de caracteres que nomeia um algoritmo para calcular o número de células 
# Uma função para calcular o número de células.
hist(dados, breaks = 10)
hist(dados, labels = T, breaks = c(0,5,10,20,30))
hist(dados, labels = T, breaks = 10)
hist(dados, labels = T, ylim = c(0,10), breaks = 10)

# Adicionando linhas ao histograma
hey = hist(dados, breaks = 10)
xaxis = seq(min(dados), max(dados), length = 10)
yaxis = dnorm(xaxis, mean = mean(dados),sd = sd(dados))
yaxis = yaxis * diff(hey$mids) * length(dados)

lines(xaxis, yaxis, col = "red")

################################################################
### Gráficos em Pizza

.Platform$GUI
?pie

# Criando as fatias
fatias = c(40,20,40)

# Nomeando as labels
paises = c("Brasil", "Argentina", "Chile")

# Unindo paises e fatias
paises = paste(paises, fatias)
paises = paste(paises, "%", sep = "")

# Construindo um gráfico
pie(fatias, labels = paises, col = c("darksalmon", "gainsboro", "lemonchiffon4"),
    main = "Distribuição de Vendas")

# Trabalhando com dataframes
attach(iris)
Values = table(Species)
labels = paste(names(Values))
pie(Values, labels = labels, main = "Distribuição de Espécies")

# 3D
install.packages("plotrix")
library(plotrix)

pie3D(fatias, labels = paises, explode = 0.05,
      col = c("steelblue1", "tomato2", "tan3"),
      main = "Distribuição de Vendas")

################################################################
### Bar plots

?barplot

# Preparando os dados
casamentos <- matrix(c(652,1537,598,242,36,46,38,21,218,327,106,67),
                      nrow = 3, byrow = T)
casamentos

# Nomeando linhas e colunas na matriz
colnames(casamentos) <- c("0","1-150","151-300",">300")
row.names(casamentos) <- c("Casados","Divorciados","Solteiro")
casamentos

# construindo o plot
# os 3 estados civis são representados na mesma coluna para as diferentes quantidade
barplot(casamentos, beside = T)

# Com a transposta da matriz, invertemos as posições entre estado civil e faixa de quantidade
barplot(t(casamentos), beside = T)







