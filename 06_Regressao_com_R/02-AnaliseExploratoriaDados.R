### Analise Exploratória dos dados
# ... cont do script 01

str(bikes)

# Verificando a correlacao entre as variaveis preditoras
bikes$count <- bikes$cnt - predict(lm(cnt ~ dteday, data = bikes), newdata = bikes)

cols <- c("mnth", "hr", "holiday", "workingday",
          "weathersit", "temp", "hum", "windspeed",
          "isWorking", "monthCount", "dayWeek", 
          "workTime", "xforHr", "count")

# Metodos de carrelacao
# Pearson - coeficiente usado para medir o grau de relacionamento entre duas variaveis com relacao linear
# Spearman - eh um teste nao parametrico, para medir o grau de relacionamento entre duas variaveis
# Kendall - eh um teste nao parametrico, para medir a forca de dependencia entre duas variaveis
metodos <- c("pearson", "spearman")

cors <- lapply(metodos, function(method)(cor(bikes[, cols], method = method)))


head(cors)

require(lattice)
plot.cors <- function(x, labs) {
  diag(x) <- 0.0
  plot(levelplot(x, main = paste("Plot de correlacao usando Metodo", labs),
                 scales = list(x = list(rot = 90), cex = 1.0)))
}

Map(plot.cors, cors, metodos)




# Avaliando a demanda por aluguel de bikes ao longo do tempo
# Construindo um time series plot para alguns determinados horarios em dias uteis e dias de fim de semana
times <- c(7, 9, 12, 15, 18, 20, 22)

tms.plot <- function(times) {
  ggplot(bikes[bikes$workTime == times, ],
         aes(x = dteday, y = cnt)) + 
    geom_line() +
    ylab("Numero de Bikes") +
    labs(title = paste("Demanda de Bikes as ", as.character(times), ":00", sep = "")) +
    theme(text = element_text(size = 20))
}

require(ggplot2)
lapply(times, tms.plot)




# Convertendo a variavel dayWeek para fator ordenado e plotando em ordem de tempo
bikes$dayWeek <- fact.conv(bikes$dayWeek)

# Demanda de bikes X potenciais variaveis preditoras
labels <- list("Boxplots - Demanda de Bikes por Hora",
               "Boxplots - Demanda de Bikes por Estação",
               "Boxplots - Demanda de Bikes por Dia Útil",
               "Boxplots - Demanda de Bikes por Dia da Semana")

xAxis <- list("hr", "weathersit", "isWorking", "dayWeek")

plot.boxes <- function(X, label) {
  ggplot(bikes, aes_string(x = X, y = "cnt", group = X)) +
    geom_boxplot() +
    ggtitle(label) + 
    theme(text = element_text(size = 18))
}

Map(plot.boxes, xAxis, labels)





# visualizando o relacionamento entre as variaveis preditoras e demanda por bikes
labels <- c("Demanda de Bikes vs Temperatura",
            "Demanda de Bikes vs Humidade",
            "Demanda de Bikes vs Velocidade do Vento",
            "Demanda de Bikes vs Hora")

xAxis <- c("temp", "hum", "windspeed", "hr")

plot.scatter <- function(X, label) {
  ggplot(bikes, aes_string(x = X, y = "cnt")) +
    geom_point(aes_string(colour = "cnt"), alpha = 0.1) +
    scale_color_gradient(low = "green", high = "blue") + 
    geom_smooth(method = "loess") +
    ggtitle(label) +
    theme(text = element_text(size = 20))
}

Map(plot.scatter, xAxis, labels)

# Explorando a interacao entre tempo e dia da semana e fins de semana
labels <- list("Box plots - Demanda por Bikes as 09:00 para \n dias da semana e fins de semana",
               "Box plots - Demanda por Bikes as 18:00  para \n dias da semana e fins de semana")

Times <- list(9,19)

plot.box2 <- function(time, label) {
  ggplot(bikes[bikes$hr == time, ], aes(x = isWorking, y = cnt, group = isWorking)) +
    geom_boxplot() + ggtitle(label) +
    theme(text = element_text(size = 18))
}

Map(plot.box2, Times, labels)


