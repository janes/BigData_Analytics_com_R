# Trabalhando com arquivos csv

# Usando o pacote readr
install.packages("readr")
library(readr)

# Abre o promt para escolher o arquivo
meu_arquivo <- read_csv(file.choose())
meu_arquivo <- read_delim(file.choose(), delim = "|")


# Importando arquivos
df1 <- read_table("data/temperaturas.txt", col_names = c("DAY", "MONTH", "YEAR", "TEMP"))
head(df1)
str(df1)
read_lines("data/temperaturas.txt", skip = 0, n_max = -1L)
read_file("data/temperaturas.txt")

# Exportando e Importando
write_csv(iris, "data/iris.csv")
dir()

# col_integer(): 
# col_double(): 
# col_logical(): 
# col_character(): 
# col_factor(): 
# col_skip(): 
# col_date() (alias = ?D?), col_datetime() (alias = ?T?), col_time() (?t?) 

df_iris <- read_csv("data/iris.csv", col_types = list(
  Sepal.Length = col_double(),
  Sepal.Width = col_double(),
  Petal.Length = col_double(),
  Petal.Width = col_double(),
  Species = col_factor(c("setosa", "versicolor", "virginica"))
))
dim(df_iris)
str(df_iris)

# Importando
df_cad <- read_csv("http://datascienceacademy.com.br/blog/aluno/RFundamentos/Datasets/Parte3/cadastro.csv")
head(df_cad)

update.packages ()
install.packages('knitr')
install.packages("dplyr")
library(dplyr)
options(warn = -1)

df_cad <- tbl_df(df_cad)
head(df_cad)
View(df_cad)

write_csv(df_cad, "data/df_cad_bkp.csv")

# Importando vários arquivos simultaneamente
list.files()
lista_arquivos <- list.files("C:/Projetos/Git_Projetos/BD_Analytics_com_R/03_Importação e Limpeza de dados/data/", full.names = TRUE)
class(lista_arquivos)
lista_arquivos

lista_arquivos2 <- lapply(lista_arquivos, read_csv)
problems(lista_arquivos2)

# Parsing
parse_date("01/02/15", "%m/%d/%y")
parse_date("01/02/15", "%d/%m/%y")
parse_date("01/02/34", "%y/%m/%d")
parse_date("01/02/22", "%y/%m/%d")

locale("en")
locale("fr")
locale("pt")

# http://www.bigmemory.org 
install.packages("bigmemory")
library(bigmemory)
?bigmemory
bigdata <- read.big.matrix(filename = "data/cadastro.csv", sep = ",", header = TRUE, skip = 1)


