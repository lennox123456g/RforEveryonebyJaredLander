#Reading Data in R using read.table, read.csv
#Using readdata 
theUrl <- "http://www.jaredlander.com/data/TomatoFirst.csv"
tomato <- read.table(file = theUrl, header=TRUE, sep=",")
#we use , as a delimeter
#using head 
head(tomato)

# Notice how we explicitly used the argument names file, header and sep.
#The second argument, header, indicates that the first row of data holds the column
#names. The third argument, sep, gives the delimiter separating data cells. Changing this
#to other values such as “\t” (tab delimited) or “;” (semicolon delimited) enables it to
#read other types of files.

#stringsAsFactors prevents character columns from being converted
#to factor columns, keeps columns with univalies as characters and saves computational time 

