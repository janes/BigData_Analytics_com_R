# mapeando ocorrencias do virus Zika

# Verificando o diretorio
getwd()

# http://combateaedes.saude.gov.br/pt/situacao-epidemiologica

# Carregando os pacotes
devtools::install_github("wch/webshot")
library(dplyr)
library(ggplot2)

# Listando os arquivos e gerando uma lista com os respectivos nomes
temp_files <- list.files(pattern = ".csv")
temp_files

# Carregando todos os arquivos em um unico objeto
myFiles <- lapply(temp_files, read.csv, stringsAsFactors = FALSE)

# Resumindo os arquivos
str(myFiles, 1)
lapply(myFiles, names)[1]
lapply(myFiles, head, 2)[1:2]

# Organizando o shape dos dados
brazil <- do.call(rbind, myFiles)
View(brazil)
brazil <- brazil %>% mutate(report_data = as.Date(report_data))

# Visualizando o dataset
glimpse(brazil)

# Transformando o dataframe em uma tabela dplyr e removendo as colunas 5 a 7
brazil <- brazil %>% select(-(6:7))

# Visualizando as primeiras 20 linhas
brazil %>% slice(1:20)

# Para cada reporting_date nos temos 5 regioes
brazil %>% filter(location_type == "region")

brazil %>% filter(location_type == "region") %>% 
  ggplot(aes(x = report_date, y = value, group = location, color = location)) +
  geom_line() +
  geom_point() +
  ggtitle("Casos de Zika por região do Brasil")

# Separando as regioes e visualizando os dados
region <- brazil %>% filter(location_type == "region")

region %>% ggplot(aes(x = location, y = value)) + geom_bar(stat = "identity") +
  ylab("Numero de casos reportados") + xlab("Region") + 
  ggtitle("Casos de Zika por região do Brasil")
  
region %>% 
  slice(1: length(unique(region$location))) %>%
  arrange(desc(value)) %>% 
  mutate(location = factor(location, levels = location, ordered = TRUE)) %>%
  ggplot(aes(x = location, y = value)) + geom_bar(stat = "identity") +
  ylab("Numero de casos reportador") + xlab("Region") +
  ggtitle("Casos de Zika reportados no Brasil")

# Obtendo localidades unicas
region %>% slice(1: length(unique(region$location)))

# Organizando as localidades unicas por numero de casos reportados
region %>% 
  slice(1: length(unique(region$location))) %>%
  arrange(desc(value))

# Criando variaveis do tipo fator
region %>% 
  slice(1: length(unique(region$location))) %>%
  arrange(desc(value)) %>%
  mutate(location = factor(location, levels = location, ordered = TRUE)) %>%
  glimpse()

# Agrupando o sumarizando
brazil_totals <- brazil %>% filter(location == "Brazil")
region_totals <- brazil %>% filter(location == "region") %>%
  group_by(report_date, location) %>%
  summarise(tot = sum(value))

# Padronizar os dados e remover as sumarizações
regvec <- vector()
length(regvec) <- nrow(brazil)
for (ii in 1:nrow(brazil)) {
  if (brazil[ii,]$location_type != "region"){
    regvec[ii] <- newlab
  }else{
    newlab <- brazil[ii,]$location
    regvec[ii] <- newlab
  }
}

# Agregando o vetor de regioes ao data frame brasil
statedf <- cbind(brazil, regvec)

# Eliminar o sumario de linhas por região e pais
statedf <- statedf %>% filter(location != "Brazil")
statedf <- statedf %>% filter(location_type != "region")

# Gerando o total por regioes a partir dos dados transformados
statedf %>% group_by(report_date, regvec) %>% summarize(tot = sum(value)) -> totals

# Gerando os mapas de cada estado do Brasil
install.packages("ggmap")
library(ggmap)
longlat <- geocode(unique(statedf$location)) %>%
  mutate(loc = unique(statedf$location))

# Salvando os geocodes do datafram statedf e salvando em um novo dataframe chamado formapping
statedf %>% filter(as.character(report_data) == "2016-06-11") %>% 
  group_by(location) %>% summarize(cases = sum(value)) %>%
  inner_join(longlat, by = c("location" = "loc")) %>%
  mutate(LatLon = paste(lat, lon, sep = ":")) -> formapping

# Visualizando os dados
head(formapping)

# Formatando a saida e gerando um novo dataframe chamado long_formapping
num_of_times_repeat <- formapping$cases
long_formapping <- formapping[rep(seq_len(nrow(formapping)), num_of_times_repeat),]

# Visualizando os dados
head(long_formapping)

# Instalando o pacote leaflet
install.packages("leaflet")
library(leaflet)

# Gerando o mapa com o dataframe - Aplique o zoom
leaflet(long_formapping) %>% addTiles() %>%
  addMarkers(clusterOptions = markerClusterOptions())














