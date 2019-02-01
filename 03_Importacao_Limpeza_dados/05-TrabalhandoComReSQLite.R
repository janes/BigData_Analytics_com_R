# Banco de dados

# Instalar SQLite
install.packages("RSQLite")
install.packages("digest")
library(digest)
library(RSQLite)


# Remove o banco SQLite, caso ele exista (não é oobrigatário)
system("del exemplo.db") # comando para Windows
# system("rm exemplo.db") # comando no Mac e Linux

# Criando driver de conexão ao banco de dados
drv = dbDriver("SQLite")
con = dbConnect(drv, dbname = "data/exemplo.db")
dbListTables(con)

# Criando uma tabela e carregando com dados do dataset mtcars
dbWriteTable(con, "mtcars", mtcars, row.names = TRUE)

# Listando uma tabela
dbListTables(con)
dbExistsTable(con, "mtcars")
dbExistsTable(con, "mtcars2")
dbListFields(con, "mtcars")

# Lendo o conteúdo da tabela
dbReadTable(con, "mtcars")

# Criando apenas a definição da tabela
dbWriteTable(con, "mtcars2", mtcars[0, ], row.names = TRUE)
dbListTables(con)
dbReadTable(con, "mtcars2")


# executando consultas no banco de dados
query = "select row_names from mtcars"
rs = dbSendQuery(con, query)
dados = fetch(rs, n = -1)
dados
class(dados)

query2 = "select row_names from mtcars"
rs2 = dbSendQuery(con, query2)
while (!dbHasCompleted(rs2)) {
  dados2 = fetch(rs2, n = -1)
  print(dados2$row_names)
}

query3 = "select disp, hp from mtcars where disp > 160"
rs3 = dbSendQuery(con, query3)
dados3 = fetch(rs3, n = -1)
dados3

query4 = "select row_names, avg(hp) from mtcars group by row_names"
rs4 = dbSendQuery(con, query4)
dados4 = fetch(rs4, n = -1)
dados4

# Criando uma tabela a partir de um arquivo
dbWriteTable(con, "tempo", "tempo.txt", sep = ",", header = T)
dbListTables(con)
dbReadTable(con, "tempo")

# Encerrando a conexão
dbDisconnect(con)

# Carregando dados no banco de dados
# http://dados.gov.br/dataset/indice-nacional-de-precos-ao-consumidor-amplo-15-ipca-15

# Criando driver e conexão ao banco de dados
drv = dbDriver("SQLite")
con = dbConnect(drv, dbname = "data/exemplo.db")

dbWriteTable(con, "indices", "data/indice.csv", sep = "|", header = T)

dbRemoveTable(con, "indices")

dbWriteTable(con, "indices", "data/indice.csv", sep = "|", header = T)
dbListTables(con)
dbReadTable(con, "indices")

df <- dbReadTable(con, "indices")
df
str(df)
sapply(df, class)

hist(df$agosto)
df_mean <- unlist(lapply(df[, c(4, 5, 6, 7, 8)], mean))
df_mean

dbDisconnect(con)





