# Trabalhando Com arquivos excel


# Instalar o Java - JDK 1.8
# http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html

# Windows
# Fa�a o download do JDK gratuitamente no site da Oracle
# Instale no seu computador
# Configure a vari�vel de ambiente JAVA_HOME apontantando para o diret�rio de instala��o do JDK
# Inclua o diret�rio JAVA_HOME/bin na vari�vel de ambiente PATH

# Mac e Linux
# Fa�a o download do JDK gratuitamente no site da Oracle
# Instale no seu computador
# Abra um terminal e execute: sudo R CMD javareconf

# ********** Pacotes que requerem Java **********
# XLConnect
# xlsx
# rJava 


# readxl

# Instalando os pacotes
install.packages("rJava")
install.packages("xlsx")
install.packages("XLConnect")
install.packages("readxl")
install.packages("gdata")
library(XLConnect)
library(readxl)
library(rJava)
library(xlsx)
library(gdata)

# Obs: Ao carregar todos os pacotes que manipulam excel, pode gerar problema de namespace, pois alguns pacotes
# possuem o mesmo nome de fun��es (que s�o diferentes entre os pacotes). Para evitar problemas, carregue e use
# os pacotes de forma individual (n�o carregue todos os pacotes de uma �nica vez).



# Pacote readxl

# Lista as worksheet no arquivo excel (guias)
excel_sheets("data/UrbanPop.xlsx")

# Lendo a planilha do excel
read_excel("data/UrbanPop.xlsx")
head(read_excel("data/UrbanPop.xlsx"))
read_excel("data/UrbanPop.xlsx", sheet = "Period2")
read_excel("data/UrbanPop.xlsx", sheet = 3)
read_excel("data/UrbanPop.xlsx", sheet = 4)

# Importando uma worksheet para um dataframe
df <- read_excel("data/UrbanPop.xlsx", sheet = 3)
head(df)

# Importando todas as worksheets
df_todas <- lapply(excel_sheets("data/UrbanPop.xlsx"), read_excel, path = "data/UrbanPop.xlsx")
df_todas
class(df_todas)



# Pacote XLConnect
arq1 = XLConnect::loadWorkbook("data/UrbanPop.xlsx")
df1 = readWorksheet(arq1, sheet = "Period1", header = TRUE)
df1
class(df1)


# Pacote xlsx
df2 <- read.xlsx("data/UrbanPop.xlsx", sheetIndex = 1)
df2

df3 <- read.xlsx("data/UrbanPop.xlsx", sheetIndex = 1,
                 startRow = 1, colIndex = 2)
df3

df4 <- readWorksheetFormFile("data/UrbanPop.xlsx", sheet = 1,
                             startRow = 4, endCol = 2)
df4

write.xlsx(df4, "data/df4.xlsx", sheetName = "Data Frame")
dir()

# Pacote gdata
arq1 <- xls2csv("data/df4.xlsx", sheet = 1, na.strings = "EMPTY")
arq1
