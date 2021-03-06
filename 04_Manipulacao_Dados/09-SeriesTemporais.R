# Analise de series temporais

# Reposit�rios de Dados de S�ries Temporais
# http://robjhyndman.com/tsdldata

# importando dados com a funcao scan()
?scan
reis <- scan("http://robjhyndman.com/tsdldata/misc/kings.dat", skip = 3)
reis
class(reis)

# Transformando os dados em series temporais
tsreis <- ts(reis)
tsreis
class(tsreis)
plot.ts(tsreis)

nascimentos <- scan("http://robjhyndman.com/tsdldata/data/nybirths.dat")
tsnascimentos <- ts(nascimentos, frequency = 12, start = c(1946, 1))
tsnascimentos
plot.ts(tsnascimentos)

# Pacote forecast
# Se for solicitado instalar da fonte, responda 'No"
install.packages("forecast")
library(xts)
library(forecast)

# Cota��o de a��es da Petrobras
# Obs: O Yahoo est� desativando o servi�o de cota��o online de a��es
url <- "http://ichart.finance.yahoo.com/table.csv?s=IBM&a=00&b=2&c=1990&d=05&e=26&f=2016&g=d&ignore=.csv"

# Lendo o conteudo da url para um dataframe
IBM.df <- read.table(url, header = TRUE, sep = ",")

# Visualizando as primeiras linhas do dataframe
head(IBM.df)				

# Convertendo o dataframe em s�rie temporal (outra forma)
IBM <- xts(IBM.df$Close, as.Date(IBM.df$Date))	
head(IBM)

# Construindo um plot
plot(IBM)		

# Criando um subset do conjunto de dados de s�ries temporais
IBM.2014 <- window(IBM,start="2014-01-01", end="2015-01-01")	

# Plotando
plot(IBM.2014)         















