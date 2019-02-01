# Trabalhando com Arquivos txt

# Usando as funções base do R (pacote utils)
search()

# Importando arquivos da internet
df_pedidos <- read.table("http://datascienceacademy.com.br/blog/aluno/RFundamentos/Datasets/Parte3/pedidos.txt", sep = ',')
df_pedidos
write.table(df_pedidos, "data/pedidos.txt", sep = ",")

# Importando arquivo vom read.table()
?read.table

df1 <- read.table("data/pedidos.txt")
df1
dim(df1)

df1 <- read.table("data/pedidos.txt", header = TRUE, sep = ",")
df1
dim(df1)

df1 <- read.table("data/pedidos.txt", header = TRUE, sep = ",", 
                  col.names = c("Var1", "Var2", "Var3"))
df1
dim(df1)

df1 <- read.table("data/pedidos.txt", header = TRUE, sep = ",", 
                  col.names = c("Var1", "Var2", "Var3"),
                  na.strings = c("Zico", "Maradona"))
df1
dim(df1)
str(df1)

df1 <- read.table("data/pedidos.txt", header = TRUE, sep = ",", 
                  col.names = c("Var1", "Var2", "Var3"),
                  na.strings = c("Zico", "Maradona"),
                  stringsAsFactors = FALSE)
df1
str(df1)

# Importando arquivo com read.csv()
df2 <- read.csv("data/pedidos.txt")
df2
dim(df2)

df3 <- read.csv2("data/pedidos.txt")
df3
dim(df2)

df4 <- read.csv2("data/pedidos.txt", sep = ",")
df4
dim(df4)

# Importando arquivo com read.delim()
df5 <- read.delim("data/pedidos.txt")
df5
dim(df5)

df5 <- read.delim("data/pedidos.txt", sep = ",")
df5
dim(df5)

# Importando / Exportando

# Gerando arquivos
write.table(mtcars, file = 'data/mtcars.txt')
dir()

df_mtcars <- read.table("data/mtcars.txt")
df_mtcars
dim(df_mtcars)

write.table(mtcars, file = 'data/mtcars2.txt', sep = "|", col.names = NA, qmethod = "double")
list.files()
read.table("data/mtcars2.txt")
df_mtcars2 <- read.table("data/mtcars2.txt")
df_mtcars2

df_mtcars2 <- read.table("data/mtcars2.txt", sep = "|")
df_mtcars2

df_mtcars2 <- read.table("data/mtcars2.txt", sep = "|", encoding = "UTF-8")
df_mtcars2




