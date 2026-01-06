#Reading Data in R using read.table, read.csv
#Using readdata 
theUrl <- "http://www.jaredlander.com/data/TomatoFirst.csv"
tomato <- read.table(file = theUrl, header=TRUE, sep=",")
#we use , as a delimeter
#using head 
# quote andcolClasses, respectively, specifying the character used for enclosing cells and the data
#type for each column.
head(tomato)

#to readdata robustly , can use 
# read_delim from the readr package by Hadley Wickham and fread
#from the data.table package by Matt Dowle, 
#respectively. Both are very fast, and neither converts character data to
#factors automatically



