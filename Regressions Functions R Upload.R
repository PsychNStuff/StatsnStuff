library(ggplot2)
library(dplyr)
library(broom)
library(ggpubr)

#Run .csv file and assign name; check file, and make sure length is high enough to display all variables
datafromcsv <- read.csv("C:\\Users\\Name\\Desktop\\.csv", header = TRUE, sep = ",")
length(datafromcsv)
class(datafromcsv$X)
options(max.print = 1000000000)
datafromcsv

#create variable to hold missing variables; average these (they can be replaced with the mean or run with exclusion of these variables)
#For purposes of this dataset, variable 1 is the dependent variable, and variables 2 and 3 are the independent variables I am testing
list_na <- colnames(datafromcsv)[ apply(datafromcsv, 2, anyNA) ]
list_na
average_missing <- apply(datafromcsv[,colnames(datafromcsv) %in% list_na], 2, mean, na.rm =  TRUE)
average_missing

#histogram test normality of dependent variable
hist(datafromcsv$variable1)

#use a scatterplot to test for linearity
plot(variable1 ~ variable2, data = datafromcsv)

#plot each independent variable in relation to the dependent variable separately for a multiple regression
plot(variable3 ~ variable2, data = datafromcsv)

#use independence of observations for multiple regressions
cor(datafromcsv$variable3, datafromcsv$variable1, use = "complete.obs")

#create a linear regression
linearregression.lm <- lm(variable1 ~ variable2, data = datafromcsv)
summary(linearregression.lm)

#create a multiple regression
multipleregression.lm<-lm(variable1 ~ variable2 + variable3, data = datafromcsv)
summary(multipleregression.lm)

#Test for homoscedascity
par(mfrow=c(1,1))
plot(multipleregression.lm)

#plot simple regression (you can play with graphs)
simpleregression_graph<-ggplot(datafromcsv, aes(x=variable2, y=variable1))+geom_point()
simpleregression_graph

#plot multiple regression
