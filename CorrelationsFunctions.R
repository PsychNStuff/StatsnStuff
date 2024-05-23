library(corrplot)
library("Hmisc")
library(tidyverse)

#Run .csv file and assign name; check file, and make sure length is high enough to display all variables
datafromcsv <- read.csv("C:\\Users\\Name\\Desktop\\.csv", header = TRUE, sep = ",")
length(datafromcsv)
class(datafromcsv$X)
options(max.print = 1000000000)
datafromcsv

#create variable to hold missing variables; average these (they can be replaced with the mean or run with exclusion of these variables)
##currently I don't do this at all, just exclude at the next step with complete.obs or pairwise.complete.obs
list_na <- colnames(datafromcsv)[ apply(datafromcsv, 2, anyNA) ]
list_na
average_missing <- apply(datafromcsv[,colnames(datafromcsv) %in% list_na], 2, mean, na.rm =  TRUE)
average_missing

#Run a correlation. Round it to 2 decimal points.
total_cor <- cor(datafromcsv, method = c("pearson"), use = "complete.obs") #sometimes pairwise.complete.obs may be better, also, pearson vs other options
total_cor
round(total_cor, digits = 2)
total_cor

#print results to csv files
write.table(total_cor, quote = FALSE, row.names = FALSE, sep = ",", '/path/to/directory.csv')

#Plot a correlation between two variables that are specified
library(ggplot2)
ggplot(datafromcsv) + aes(x = ERQ_T7, y = CESD_T7) + geom_point(colour = "#0c4c8a") + theme_minimal()

#Plot a matrix of correlations; I find that only three variables fit well for visualization.
pairs(datafromcsv [, c(3, 5, 10)])

##graph correlation table!
#function found online, just makes results more readable:
# ++++++++++++++++++++++++++++
# flattenCorrMatrix
# ++++++++++++++++++++++++++++
# cormat : matrix of the correlation coefficients
# pmat : matrix of the correlation p-values
flattenCorrMatrix <- function(cormat, pmat) {
  ut <- upper.tri(cormat)
  data.frame(
    row = rownames(cormat)[row(cormat)[ut]],
    column = rownames(cormat)[col(cormat)[ut]],
    cor  =(cormat)[ut],
    p = pmat[ut]
  )
}

#plot, export - must use png for corrplot package
png("/path/to/directory.png", units="in", width=10, height=10, res = 600)
corrplot(total_cor, addCoef.col = 'black', method = "color",
         cl.pos = 'b', col=colorRampPalette(c('#30899f', '#6bd8f2', "white", '#f7a3b9', '#E01A4F'))(200), order = "hclust", 
         tl.pos='l', number.cex = 3) #replace with the colors you want

dev.off()
