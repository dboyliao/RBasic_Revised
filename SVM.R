rm(list=ls())
if (!is.loaded('e1071')) library('e1071')
if (!is.loaded('MASS')) library('MASS')

data(iris)
X <- subset(iris, select = -Species)
y <- iris$Species

ind1 <- which(iris[, "Species"] == "setosa" | iris[, 'Species'] == "versicolor")
X1 <- X[ind1, ]
Intersect <- rep(1, dim(X1)[1])
X1 <- cbind(Intersect, X1)
y1 <- y[ind1]
y1 <- factor(y1, levels = c("setosa", 'versicolor'))
data1 <- cbind(X1, y1)

ind2 <- which(iris[, "Species"] == "setosa" | iris[, 'Species'] == "virginica")
X2 <- X[ind2, ]
#ones <- rep(1, dim(X2)[1])
#X2 <- cbind(ones, X2)
y2 <- y[ind2]
y2 <- factor(y2, levels = c("setosa", 'virginica'))
data2 <- cbind(X2, y2)

ind3 <- which(iris[, "Species"] == "versicolor" | iris[, 'Species'] == "virginica")
X3 <- X[ind3, ]
#ones <- rep(1, dim(X3)[1])
#X3 <- cbind(ones, X3)
y3 <- y[ind3]
y3 <- factor(y3, levels = c('versicolor', 'virginica'))
data3 <- cbind(X3, y3)

model0 <- svm(Species ~ ., data = iris, kernel = "radial", scale = F)
model1 <- svm(y1 ~ ., data = data1, kernel = 'linear', scale = F)
model2 <- svm(y2 ~ ., data = data2, kernel = 'linear', scale = F)
model3 <- svm(y3 ~ ., data = data3, kernel = 'linear', scale = F)

plot(model1, data1, Petal.Length ~ Petal.Width,
     slice = list(Sepal.Width = 3, Sepal.Length = -4),color.palette = terrain.colors)

plot(model2, data2, Petal.Width ~ Petal.Length,
     slice = list(Sepal.Width = 3, Sepal.Length = 4),color.palette = topo.colors)

plot(model3, data3, Petal.Width ~ Petal.Length,
     slice = list(Sepal.Width = 3, Sepal.Length = 4),color.palette = topo.colors)

predict0 <- predict(model0, subset(iris, select=-Species))
table(predict0, iris[, "Species"])

predict1 <- predict(model1, subset(data1, select = -y1))
table(predict1, y1)
coef1 <- matrix(model1$coefs, nrow = 1)
w1 <- rbind(-model1$rho, t(coef1 %*% model1$SV))
(test <- (cbind(1,as.matrix(X1)) %*% w1)[model1$index])

predict2 <- predict(model2, subset(data2, select = -y2))
table(predict2, y2)
coef2 <- matrix(model2$coefs, nrow = 1)
w2 <- t(coef2 %*% model2$SV)

predict3 <- predict(model3, subset(data3, select = -y3))
table(predict3, y3)
coef3 <- matrix(model3$coefs, nrow = 1)
w3 <- t(coef3 %*% model3$SV)
