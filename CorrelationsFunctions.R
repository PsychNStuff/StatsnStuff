#Run .csv file and assign name; check file, and make sure length is high enough to display all variables
datafromcsv <- read.csv("C:\\Users\\Name\\Desktop\\.csv", header = TRUE, sep = ",")
length(datafromcsv)
class(datafromcsv$X)
options(max.print = 1000000000)
datafromcsv

#create variable to hold missing variables; average these (they can be replaced with the mean or run with exclusion of these variables)
list_na <- colnames(datafromcsv)[ apply(datafromcsv, 2, anyNA) ]
list_na
average_missing <- apply(datafromcsv[,colnames(datafromcsv) %in% list_na], 2, mean, na.rm =  TRUE)
average_missing

#Run a correlation. Round it to 2 decimal points.
total_cor <- cor(datafromcsv, method = c("pearson"), use = "complete.obs")
total_cor
round(total_cor, digits = 2)
total_cor

#Plot a correlation between two variables that are specified
library(ggplot2)
ggplot(datafromcsv) + aes(x = ERQ_T7, y = CESD_T7) + geom_point(colour = "#0c4c8a") + theme_minimal()

#Plot a matrix of correlations; I find that only three variables fit well for visualization.
pairs(datafromcsv [, c(3, 5, 10)])
