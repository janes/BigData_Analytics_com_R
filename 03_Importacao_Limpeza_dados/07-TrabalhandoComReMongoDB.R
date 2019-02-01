# R com MongoDB

# Criando uma coleção no MongoDB
# 1- Abrir um prompt ou terminal e iniciar o MongoDB com o comando: mongod  (manter a janela aberta)
# 2- Abrir outro prompt ou terminal e navegar até o diretório bin dentro do diretório de instalação do MongoDB e executar na linha de comando:

# --> No MacOS ou Linux, execute:  ./mongoimport --db users --collection contatos --file ~/Projetos/Git_Projetos/BD_Analytics_com_R/03_Importação e Limpeza de dados/data/zips.json
# --> No Windows, execute:  mongoimport --db users --collection contatos --file C:\Projetos\R\zips.json

# *** Atenção *** - substituir C:\Projetos\Git_Projetos\BD_Analytics_com_R\03_Importação e Limpeza de dados\data
# pelo diretório na sua máquina onde você salvou o arquivo zips.json

# podemos utilizar o pacote rmongo, mas o mesmo tem dependencia do java

# O pacote rmongodb deve ser instalado a partir do reposit?rio no Github.

# RMongoDB

# Instala??o dos pacotes
install.packages("devtools")
library(devtools)
install_github("mongosoup/rmongodb")
library(rmongodb)

# Criando a conexão 
help("mongo.create")
mongo <- mongo.create()
mongo

# checando a conexão
mongo.is.connected(mongo)

if(mongo.is.connected(mongo) == TRUE){
  mongo.get.databases(mongo)
}

# Armazena o nome de uma das coleções
coll <- "users.contatos"

# Contando os registros em uma coleção
help("mongo.count")
mongo.count(mongo, coll)

# Buscando um registro em uma coleção
mongo.find.one(mongo, coll)

# Obtendo um vetor de valores distintos das chaves de uma coleção
res <- mongo.distinct(mongo, coll, "city")
head(res)

# Obtendo um vetor de valores distintos das chaves de uma coleção
# e gerando um histograma
pop <- mongo.distinct(mongo, coll, "pop")
hist(pop)

# Contando os elementos
nr <- mongo.count(mongo, coll, list("pop" = list("$lte" = 2)))
print(nr)

# Buscando todos os elementos
pops <- mongo.find.all(mongo, coll, list("pop" = list("$lte" = 2)))
head(pops, 2)

# Encerrando a conexão
mongo.destroy(mongo)

# Criando e validando um arquivo json
library(jsonlite)
json_arquivo <- '{"pop":{"$lte":2}, "pop":{"$gte":1}}'
cat(prettify(json_arquivo))

validate(json_arquivo)























