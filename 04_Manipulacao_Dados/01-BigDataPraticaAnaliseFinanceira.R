# Big Data na Pratica - Buscando Dados para Analise Financeira

# Pacote especifico para analise financeira
# http://www.quantmod.com

# Series temporais 
# xts e moments

# Configurando o diretório
setwd("C:/Projetos/Git_Projetos/BD_Analytics_com_R/04_Manipulacao_Dados")
getwd()

# Instalando e carregando os pacotes
install.packages("quantmod")
install.packages("xts")
install.packages("moments")
library(quantmod)
library(xts)
library(moments)

# Seleção do período de análise
startDate = as.Date("2018-01-21")
endDate = as.Date("2018-06-21")

# Download dos dados do período
# Obs: O Yahoo está desativando o serviço de cotações online de ações
?getSymbols
getSymbols("PETR4.SA", src = "yahoo", from = startDate, to = endDate, auto.assign = T)
PETR4.SA = readRDS("PETR4.SA_2007.rds")

# checando o tipo de dado retornado
class(PETR4.SA)
is.xts(PETR4.SA)

# mostra os primeiros registros para as ações da petrobras
head(PETR4.SA)

# Analisando os dados de fechamento
PETR4.SA.Close <- PETR4.SA[, "PETR4.SA.Close"]
is.xts(PETR4.SA.Close)
?Cl
head(Cl(PETR4.SA),3)

# Agora, vamos plotar o gráfico da Petrobras
# Gráfico de candlestick da Petrobras
# para mapear dados financeiros
?candleChart
candleChart(PETR4.SA)

# Plot do fechamento
plot(PETR4.SA.Close, main = "Fechamento Diario Acoes Petrobras",
     col = "red", xlab = "Data", ylab = "Preco", major.ticks = "months",
     minor.ticks = FALSE)

# Adicionado as bandas de bollinger ao gráfico, com média de 20 períodos e 2 desvios
# Bollinger Band
# Como o desvio padrão é uma medida de volatilidade, 
# Bollinger Bands ajustam-se às condições de mercado. Mercados mais voláteis, 
# possuem as bandas mais distantes da média, enquanto mercados menso voláteis possuem as
# bancas mais próximas da média
# ou seja, adicionamos um desvio padrão
?addBBands
addBBands(n = 20, sd = 2)

# Adicionando o indicador ADX, média 11 do tipo exponencial
?addADX
addADX(n = 11, maType = "EMA")

# Calculando logs diários
?log
PETR4.SA.ret <- diff(log(PETR4.SA.Close), lag = 1)

# Removendo valores NA na posição 1
PETR4.SA.ret <- PETR4.SA.ret[-1]

# Plotar a taxa de retorno
plot(PETR4.SA.ret, main = "Fechamento Diario das Acoes da Petrobras",
     col = "red", xlab = "Data", ylab = "Retorno", major.ticks = "months",
     minor.ticks = FALSE)

# Calculando algumas medidas estatisticas
statNames <- c("Mean", "Standard Deviation", "Skewness", "kurtosis")
PETR4.SA.stats <- c(mean(PETR4.SA.ret), sd(PETR4.SA.ret), skewness(PETR4.SA.ret),
                    kurtosis(PETR4.SA.ret))
names(PETR4.SA.stats) <- statNames
PETR4.SA.stats

# Salvando os dados em um arquivo .rds (arquivo em formato binário do R)
# getSymbols("PETR4.SA", src = 'yahoo')
saveRDS(PETR4.SA, file = "PETR4.SA.rds") # Salva os dados em formato binário
Ptr = readRDS("data/PETR4.SA.rds")
dir()
head(Ptr)



