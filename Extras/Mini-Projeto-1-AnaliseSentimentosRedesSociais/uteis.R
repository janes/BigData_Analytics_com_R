# Funcoes auxiliares

# Verificando o diretorio
getwd()

# Funcao para limpeza dos dados dos tweets
limpaTweets <- function(tweet){
  # Remove http links
  tweet = gsub("(f|ht)(tp)(s?)(://)(.*)[.|/](.*)", " ", tweet)
  tweet = gsub("http\\w+", "", tweet)
  # Remove retweets
  tweet = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", " ", tweet)
  # Remove �#Hashtag�
  tweet = gsub("#\\w+", " ", tweet)
  # Remove nomes de usuarios �@people�
  tweet = gsub("@\\w+", " ", tweet)
  # Remove pontuac�o
  tweet = gsub("[[:punct:]]", " ", tweet)
  # Remove os n�meros
  tweet = gsub("[[:digit:]]", " ", tweet)
  # Remove espacos desnecess�rios
  tweet = gsub("[ \t]{2,}", " ", tweet)
  tweet = gsub("^\\s+|\\s+$", "", tweet)
  # Convertendo encoding de caracteres e convertendo para letra min�scula
  tweet <- stringi::stri_trans_general(tweet, "latin-ascii")
  tweet <- tryTolower(tweet)
  tweet <- iconv(tweet, from = "UTF-8", to = "ASCII")
}

# Funcao para limpeza de corpus
limpaCorpus <- function(myCorpus){
  library(tm)
  myCorpus <- tm_map(myCorpus, tolower)
  # Remove pontua��o
  myCorpus <- tm_map(myCorpus, removePunctuation)
  # Remove n�meros
  myCorpus <- tm_map(myCorpus, removeNumbers)
}

# Converte para min�sculo
tryTolower = function(x)
{
  # Cria um dado missing (NA)
  y = NA
  # faz o tratamento do erro
  try_error = tryCatch(tolower(x), error=function(e) e)
  # se n�o der erro, transforma em min�sculo
  if (!inherits(try_error, "error"))
    y = tolower(x)
  # Retorna o resultado
  return(y)
}


















