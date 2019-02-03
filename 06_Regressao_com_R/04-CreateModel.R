# Cria um modelo preditivo usando randomForest
# ... cont do script 03

require(randomForest)

modelo <- randomForest(cnt ~ xformWorkHr + dteday + temp + hum,
                       data = bikes, 
                       ntree = 40, 
                       nodesize = 5)

print(modelo)







