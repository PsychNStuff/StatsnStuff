###This will remind you of basic functions to use to read in a file, edit it, and export it
##This is written for a .tsv, but uses qualitative examples. You can replace these values or use a different file type.
library(tidyverse)

#First, read in a tsv or other tab deliminated file (use read.csv for csvs, refer to documentation)
mytsv <- read.table("/directory/file.tsv", header = TRUE)

## You will use a few steps to add a column
# This assigns string variables to your column
Column <- c("a", "b", "c")

#This attaches the phrase "in the alphabet" after the letters in Column with a space
Column2 <- paste(Column, "in the alphabet", sep=" ")

#This attaches the phrase before the letters in Column2 instead of afterward
Column3 <- paste("There are letters like", Column2, sep = ' ')

#Returns the first few characters
head(Column3)

#If your data is a pain, you probably need an id. Use sapply!
id <- sapply(str_split(Column2, " "), '[', 4)

#Example of columnbind
alphabet <- cbind(id, Column3)

#Examples of making a dataframe
df <- as.data.frame(alphabet)
df2 <- data.frame(phrase1 = Column, phrase2 = Column2, phrase3 = Column3)
df3 <- inner_join(df, df2, by = c('Column3' = 'phrase3'), sep = "\t")

#Keep the columns you want
finaldf <- df3[ -c(1,3:4) ]
final.df <- as.data.frame(finaldf)
write.table(final.df, quote = FALSE, row.names = FALSE, sep = "\t", '/directory/file.tsv')






























































































































































