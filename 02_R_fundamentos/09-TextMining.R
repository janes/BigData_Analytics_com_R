# Text Mining

# Exemplo 1
install.packages(c("SnowballC", "wordcloud", "RColorBrewer"))
library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)
options(warn = -1)

# Carregando o dataset
df <- read.csv('data/questoes.csv', stringsAsFactors = FALSE)
head(df)

# Criando um Corpus
dfCorpus <- Corpus(VectorSource(df$Question))
class(dfCorpus)

# imprimindo uma linha do Corpus
dfCorpus
dfCorpus[[1]][[1]]

# Remove pontuação
dfCorpus <- tm_map(dfCorpus, removePunctuation)

# Remover palavras específicas do inglês
dfCorpus <- tm_map(dfCorpus, removeWords, stopwords("english"))

# Neste processo, várias versões de uma palavra são convertidas em uma única instância
dfCorpus <- tm_map(dfCorpus, stemDocument)


# ajustando o encoding (se necess?rio)
# dfCorpus <- iconv(dfCorpus, "UTF-8)

# wordcloud
wordcloud(dfCorpus, max.words = 100, random.order = FALSE)


# Exemplo 2
install.packages("tm")
install.packages("SnowballC")
install.packages("wordcloud")
install.packages("RColorBrewer")

library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)

# Lendo o arquivo
arquivo <- "http://www.sthda.com/sthda/RDoc/example-files/martin-luther-king-i-have-a-dream-speech.txt"
texto <- readLines(arquivo)

# Carregando os dados como Corpus
docs <- Corpus(VectorSource(texto))

# Pré-processamento
inspect(docs)
toSpace <- content_transformer(function (x, pattern) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")

# Converte o texto para minusculo
docs <- tm_map(docs, content_transformer(tolower))

# Remove números
docs <- tm_map(docs, removeNumbers)

# Remove as palavras mais comuns do idioma inglês
docs <- tm_map(docs, removeWords, stopwords("english"))

# Definindo um vetor de palavras a serem removidas do texto
docs <- tm_map(docs, removeWords, c("blabla1", "blabla2"))

# Remove pontuação
docs <- tm_map(docs, removePunctuation)

# Elimina espaços extras
docs <- tm_map(docs, stripWhitespace)

# text stemming
docs <- tm_map(docs, stemDocument)

# Matriz de frequência
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m), decreasing = TRUE)
d <- data.frame(word = names(v), freq = v)
head(d, 10)

# wordclound
set.seed(1234)

wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words = 200, random.order = TRUE,
          colors = brewer.pal(8, "Dark2"))

#  tabela de frequência
findFreqTerms(dtm, lowfreq = 4)
findAssocs(dtm, terms = "freedom", corlimit = 0.3)
head(d,10)

# Gráficos de barras com palavras mais frequentes
barplot(d[1:10,]$freq, las = 2, names.arg = d[1:10,]$word,
        col = "lightblue", main = "Mostra a frequencia da palavra",
        ylab = "Palavras frequentes")





