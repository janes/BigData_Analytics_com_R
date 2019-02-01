# Web Scraping

# Pacotes R para Web Scraping
# RCurl
# httr
# XML
# rvest

# Pacote rvest - útil para quem não conhece HTML e CSS
install.packages("rvest")
library(rvest)

# Coletando a url do filme: 13 Horas - Os Soldados Ocultos de Benghazi
?read_html
filme <- read_html("http://www.imdb.com/title/tt4172430/")
class(filme)
head(filme)

# Coletando a classificação do filme
?html_node
?html_text

filme %>%
  html_node("strong span") %>%
  html_text() %>%
  as.numeric()

# Coletando o elenco do filme
filme %>% 
  html_nodes("#titleCast tr td a ") %>%
# html_nodes("#titleCast .itemprop span") %>%
  html_text()


# aqui estava o número 3, mas o objeto filme é uma lista de dois
# Gravando em formato tabela
filme %>%
  html_nodes("table") %>%
  .[[2]] %>%
  html_table()


### Coletando a previsão metereologica
pagina  <- read_html("http://forecast.weather.gov/MapClick.php?lat=42.31674913306716&lon=-71.42487878862437&site=all&smap=1#.VRsEpZPF84I")
previsao <- html_nodes(pagina, "#detailed-forecast-body b, .forecast-text")
texto <- html_text(previsao)
paste(texto, collapse = " ")

# Exemplo completo
### Formatando os dados de uma pagina web
library(rvest)
library(stringr)
library(tidyr)

# Extraindo a pagina web
url <- 'http://espn.go.com/nfl/superbowl/history/winners'
pagina <- read_html(url)

# Extraindo a tag "table" do codigo HTML e convertendo para dataframe
tabela <- html_nodes(pagina, 'table')
class(tabela)
tab <- html_table(tabela)[[1]]
class(tab)
head(tab)

# Removendo as duas primeiras linhas e adicionando nomes as colunas
# tem apenas titulo e informações que não fazem sentido
tab2 <- tab[-(1:2), ]
head(tab2)
names(tab2) <- c("number", "data", "site", "result")
head(tab2)

# Convertendo de algarismos romanos para números inteiros
tab2$number <- 1:52
tab2$data <- as.Date(tab2$data, "%B. %d, %Y")
head(tab2)

# dividindo as colunas em 4 colunas
tab3 <- separate(tab2, result, c('winner', 'loser'), sep = ', ', remove = TRUE)
head(tab3)

pattern <- " \\d+$"
tab3$winnerScore <- as.numeric(str_extract(tab3$winner, pattern))
tab3$loserScore <- as.numeric(str_extract(tab3$loser, pattern))
tab3$winner <- gsub(pattern, "", tab3$winner)
tab3$loser <- gsub(pattern, "", tab3$loser)
head(tab3)

# Grava o resultado no arquivo csv
write.csv(tab, 'data/superbowl.csv', row.names = F)
dir()



# https://www.import.io
# http://scrapinghub.com


