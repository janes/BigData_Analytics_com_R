### Coletando e Transformando

# Configurando o diretorio
setwd("C:/Projetos/Git_Projetos/BD_Analytics_com_R/06_Regressao_com_R")
getwd()

source("tools/Tools.R")
bikes <- read.csv("data/bikes.csv", sep = ",", header = TRUE, stringsAsFactors = FALSE)
  
# Selecionar as variaveis que serao usadas
cols <- c("dteday", "mnth", "hr", "holiday",
          "workingday", "weathersit", "temp",
          "hum", "windspeed", "cnt")
  
# Criando um subset dos dados
bikes <- bikes[,cols]
  
## Transformar o objeto de data
# esta linha gera dois valores NA
bikes$dteday <- char.toPOSIXct(bikes)
# esta linha corrige
bikes <- na.omit(bikes)
  
# Normalizar as variaveis preditoras numericas
cols <- c("temp", "hum", "windspeed")
bikes[,cols] <- scale(bikes[,cols])

?scale
str(bikes)
View(bikes)

# Criar uma nova variavel para indicar dia da semana (workday)
bikes$isWorking <- ifelse(bikes$workingday & !bikes$holiday, 1, 0)

# Adicionar uma coluna com a quantidade de meses, o que vai ajudar a criar o modelo
bikes <- month.count(bikes)

# Criar um fator ordenado para o dia da semana, comecando por segunda
# Neste fator eh convertido para ordenado numerico para ser compativel com os tipod de dados do Azure ML
bikes$dayWeek <- as.factor(weekdays(bikes$dteday))

# Analise o dataframe bikes
# Se os nomes dos dias da semana estiverem em portugues na coluna bikes$dayWeek
# execute o bloco 1, caso contrario, execute o bloco2 com os nomes em ingles
# Execute apenas o bloco correto
str(bikes$dayWeek)

# Bloco1
# Se o seu SO estiver em portugues, execute este comando
bikes$dayWeek <- as.numeric(ordered(bikes$dayWeek, 
                                    levels = c("segunda-feira", 
                                               "terça-feira", 
                                               "quarta-feira", 
                                               "quinta-feira", 
                                               "sexta-feira", 
                                               "sábado", 
                                               "domingo")))

# Bloco2
# Se o seu SO estiver em ingles, execute este comando
bikes$dayWeek <- as.numeric(ordered(bikes$dayWeek, 
                                    levels = c("Monday", 
                                               "Tuesday", 
                                               "Wednesday", 
                                               "Thursday", 
                                               "Friday", 
                                               "Saturday", 
                                               "Sunday")))

# Agora os dias da semana devem estar como valores numericos
# Se estiverem como valores NA, volte e verifique se vc seguiu as instrucoes acima
str(bikes$dayWeek)
str(bikes)

# Adiciona uma variavel com valores unicos para o horario do dia para dias da semana e dias de fim de semana
# Com isso diferenciamos as horas dos dias da semana, das horas em dias de fim de semana
bikes$workTime <- ifelse(bikes$isWorking, bikes$hr, bikes$hr + 24)

# Transforma os valores de hora na madrugada, quando a demanda por bicicletas eh praticamente nula
bikes$xforHr <- ifelse(bikes$hr > 4, bikes$hr -5, bikes$hr + 19)

# Adicionando uma variavel com valores unicos para o horario do dia para dias da semana e dias de fim de semana
bikes$xformWorkHr <- ifelse(bikes$isWorking, bikes$xforHr, bikes$xforHr + 24)

str(bikes)



