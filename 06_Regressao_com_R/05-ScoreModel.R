# Score do modelo preditivo com randomForest
# ... cont do script 04

require(randomForest)

scores <- data.frame(actual = bikes$cnt,
                     prediction = predict(modelo,
                                          newdata = bikes))

scores