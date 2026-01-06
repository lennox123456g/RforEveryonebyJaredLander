library(readr)
theUrl <- "http://www.jaredlander.com/data/TomatoFirst.csv"
tomato2 <- read_delim(file=theUrl, delim=',')
View(tomato2)      # Opens data in viewer
head(tomato2)      # Shows first 6 rows
str(tomato2)       # Shows structure
summary(tomato2)   # Shows summary statistics

#The col_names argument is
#set to TRUE by default to specify that the first row of the file holds the column names.
##A tibble is a modern, improved version of R's traditional data frame.
#It's part of the tidyverse package ecosystem 
#(specifically from the tibble package).
#Doesn't flood your console with huge outputs
#tibbles also intelligently only print as many rows and columns as will
#fit on the screen.


#Reading Data using FREAD
#This is also faster than read.table
#has stringsAsFactorsargumentt set to false bydefault 
library(data.table)
theUrl <- "http://www.jaredlander.com/data/TomatoFirst.csv"
tomato3 <- fread(input=theUrl, sep=',', header=TRUE)
tomato3

#NOEW THE DECISION IS YOURS TO EITHER USE THE deplyr package or the 
#data.tablepackage 