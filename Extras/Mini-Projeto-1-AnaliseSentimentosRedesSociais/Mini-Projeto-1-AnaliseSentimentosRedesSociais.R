# Mini-Projeto 1 - Análise de Sentimentos em Redes Sociais

# Configurando os diretorios
getwd()
setwd("C:/Projetos/R/MachineLearning")

## Etapa 1 - Pacotes e Autenticação

# Instalando e carregando o pacote do twitterR
install.packages("twitteR")
install.packages("httr")
library(twitteR)
library(httr)

# Carregando a biblioteca com funções de limpeza
source("uteis.R")

# Chaves de autenticacao no Twitter
key <- ""
secret <- ""
token <- ""
tokenSecret <- ""

# Autenticacao. Responda 1 quando perguntado sobre utilizar direct connection
setup_twitter_oauth(key, secret, token, tokenSecret)

## Etapa 2 - Conexao e captura de tweets

# Verificando a timeline do usuario
userTimeline('dsacademybr')

# Capturando os tweets
tema <- "BigData"
qtd_tweets <- 100
lingua <- "pt"
tweetData = searchTwitter(tema, n = qtd_tweets, lang = lingua)

# Visualizando as primeiras linhas do objeto tweetdata
head(tweetData)


## Etapa 3 - Tratamento dos dados coletados atraves de text mining

# Instalando o pacote para Text Mining
install.packages("tm")
install.packages("SnowballC")
library(SnowballC)
library(tm)
options(warn = -1)

# Tratamento (limpeza, organização e transformacao) dos dados coletados
tweetList <- sapply(tweetData, function(x) x$getText())
tweetList <- iconv(tweetList, to = "utf-8", sub = "")
tweetList <- limpaTweets(tweetList)
tweetCorpus <- Corpus(VectorSource(tweetList))
tweetCorpus <- tm_map(tweetCorpus, removePunctuation)
tweetCorpus <- tm_map(tweetCorpus, content_transformer(tolower))
tweetCorpus <- tm_map(tweetCorpus, function(x) removeWords(x, stopwords()))

# Convertendo o objeto Corpus para texto plano
# tweetCorpus <- tm_map(tweetCorpus, PlainTextDocument)
termo_por_documento = as.matrix(TermDocumentMatrix(tweetCorpus), control = list(stopwords = c(stopwords("portuguese"))))


## Etapa 4 - Wordcloud, associações entre as palavras e dendograma

# Instalando o pacote wordcloud
install.packages("RColorBrewer")
install.packages("wordcloud")
library(RColorBrewer)
library(wordcloud)

# Gerando uma nuvem de palavras
pal2 <- brewer.pal(8, "Dark2")

wordcloud(tweetCorpus,
          min.freq = 2,
          scale = c(5,1),
          random.color = F,
          max.words = 60,
          random.order = F,
          colors = pal2)

# Convertendo o objeto texto pata o formato matriz
tweettdm < TermDocumentMatrix(tweetCorpus)
tweettdm

# Encontrando as palavras que aparecem com mais frequencia
findFreqTerms(tweettdm, lowfreq = 11)

# Buscando associacoes
findAssocs(tweettdm, 'datascience', 0.60)

# Removendo termos esparsos (não utilizados frequentemente)
tweet2tdm <- removeSparseTerms(tweettdm, sparse = 0.9)

# Criando escala nos dados
tweet2tdmScale <- scale(tweet2tdm)

# Distance Matrix
tweetDist <- dist(tweet2tdmScale, method = "euclidean")

# Preparando o dendograma
tweetFit <- hclust(tweetDist)

# Criando o dendograma (Verificando como as palavras se agrupam)
plot(tweetFit)

# Verificando os grupos
cutree(tweetFit, k = 4)

# Visualizando os grupos de palavras no dendograma
rect.hclust(tweetFit, k = 3, border = "red")


## Etapa 5 - Analise de sentimento

# Criando uma funcao para avaliar o sentimento
install.packages("stringr")
install.packages("plyr")
library(stringr)
library(plyr)

sentimento.score = function(sentences, pos.words, neg.words, .progress = 'none'){
  
  # Criando um array de scores com laply
  scores = laply(sentences,
                 function(sentence, pos.words, neg.words){
                   sentence = gsub("[[:punct:]]", "", sentence)
                   sentence = gsub("[[:cntrl:]]", "", sentence)
                   sentence = gsub('\\d+', "", sentence)
                   tryTolower = function(x){
                     y = NA
                     try_error = tryCatch(tolower(x), error = function(e) e)
                     if (!inherits(try_error, "error"))
                       y = tolower(x)
                     return(y)
                   }
                   
                   sentence = sapply(sentence, tryTolower)
                   word.list = str_split(sentence, "\\s+")
                   words = unlist(word.list)
                   pos.matches = match(words, pos.words)
                   neg.matches = match(words, neg.words)
                   pos.matches = !is.na(pos.matches)
                   neg.matches = !is.na(neg.matches)
                   score = sum(pos.matches) - sum(neg.matches)
                   return(score)
                   
                 }, pos.words, neg.words, .progress = .progress)
  
  scores.df = data.frame(text = sentences, score = scores)
  return(scores.df)
}

# Mapeando as palavras positivas e negativas
pos = readline("palavras_positivas.txt")
neg = readline("palavras_negativas.txt")

# Criando massa de dados para teste
teste = c("Big Data is the future", "awesome experience",
          "analytics could not be bad", "learn to use big data")

# Testando a funcao em nossa massa de dados dummy
testeSentimento = sentimento.score(teste, pos, neg)
class(testeSentimento)


# Verificando o score
# 0 - expressão não possui palavra em nossas listas de palavras positivas e negativas ou
# encontrou uma palavra negativa e uma positiva na mesma sentença
# 1 - expressão possui palavra com conotação positiva 
# -1 - expressão possui palavra com conotação negativa
testeSentimento$score


## Etapa 6 - Gerando score da analise de sentimento

# Tweets por pais
catweets = searchTwitter("ca", n = 500, lang = "en")
usatweets = searchTwitter("usa", n = 500, lang = "en")

# Obtendo texto
catxt = sapply(catweets, function(x) x$getText())
usatxt = sapply(usaweets, function(x) x$getText())

# Vetor de tweets dos paises
paisTweer = x(length(catxt), length(usatxt))

# Juntando os textos
paises = c(catxt, usatxt)

# Aplicando funcao para calcular o score de sentimento
scores = sentimento.score(paises, pos, neg, .progress = "text")

# Calculando o score por pais
scores$paises = factor(rep(c("ca", "usa"), paisTweer))
scores$muito.pos = as.numeric(scores$score >= 1)
scores$muito.neg = as.numeric(scores$score >= -1)

# Calculando o total
numpos = sum(scores$muito.pos)
numneg = sum(scores$muito.neg)

# Score global
global_score = round(100 * numpos / (numpos + numneg))
head(scores)
boxplot(score ~ paises, data = scores)

# Gerando um histograma com o lattice
install.packages("lattice")
library(lattice)

histogram(data = scores, ~score|paises, main = "Analise de Sentimentos", xlab = "", sub = "Score")


## Usando Classificador Naive Bayes para analise de sentimento
# https://cran.r-project.org/src/contrib/Archive/Rstem/
# https://cran.r-project.org/src/contrib/Archive/sentiment/

install.packages("Rstem_0.4-1.tar.gz", sep = "", repos = NULL, type = "source")
install.packages("sentiment_0.2.tar.gz",sep = "", repos = NULL, type = "source")
install.packages("ggplot2")
library(Rstem)
library(sentiment)
library(ggplot2)

# Coletando os tweets
tweetpt = searchTwitter("bigdata", n = 1500, lang = "pt")

# Obtendo o texto
tweetpt = sapply(tweetpt, function(x) x$getText())

# Removendo caracteres especiais
tweetpt = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", tweetpt)

# Removendo @
tweetpt = gsub("@\\w+", "", tweetpt)

# Removendo pontuação
tweetpt = gsub("[[:punct:]]", "", tweetpt)

# Removendo digitos
tweetpt = gsub("[[:digit:]]", "", tweetpt)

# Removendo links html
tweetpt = gsub("http\\w+", "", tweetpt)

# Removendo espacos desnecessários
tweetpt = gsub("[ \t]{2,}", "", tweetpt)
tweetpt = gsub("^\\s+|\\s+$", "", tweetpt)

# Criando funcao para tolower
try.error = function(x){
  # Criando missing value
  y = NA
  try_error = tryCatch(tolower(x), error = function(e) e)
  if (!inherits(try_error, "error"))
    y = tolower(x)
  return(y)
}

# Lower case
tweetpt = sapply(tweetpt, try.error)

# Removendo os NAs
tweetpt = tweetpt[!is.na(tweetpt)]
names(tweetpt) = NULL

# Classificando emocao
class_emo = classify_emotion(tweetpt, algorithm = "bayes", prior = 1.0)
emotion = class_emo[,7]

# Substituindo NA's por "Neutro"
emotion[is.na(emotion)] = "Neutro"

# Classificando polaridade
class_pol = classify_polarity(tweetpt, algorithm = "bayes")
polarity = class_pol[,4]

# Gerando um dataframe com o resultado
sent_df = data.frame(text = tweetpt, emotion = emotion,
                     polarity = polarity, stringsAsFactors = FALSE)

# Ordenando o dataframe
sent_df = within(sent_df, emotion <- factor(emotion, levels = nomes(sort(table(emotion), decreasing = TRUE))))

# Emocoes encontradas
ggplot(sent_df, aes(x = emotion)) +
  geom_bar(aes(y = ..count.., fill = emotion)) +
  scale_fill_brewer(palette = "Dark2") +
  labs(x = "Categorias", y = "Numero de Tweets")

# Polaridade
ggplot(sent_df, aes(x = polarity)) + 
  geom_bar(aes(y = ..count.., fill = polarity)) +
  scale_fill_brewer(palette = "RdGy") +
  labs(x = "Categorias de Sentimentos", y = "Numero de Tweets")





























