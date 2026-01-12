#Using apply  its relatives such as tapply, lapply and
#mapply.


#Building a matrix to work with 
theMatrix <- matrix(1:9, nrow=3)

#sum of the rows 
apply(theMatrix,1,sum)#one menas work on rows


#sum the columns
apply(theMatrix,2, sum)#two is for working on columns 


#Using rowsums and colsums alternatively
colSums(theMatrix)
rowSums(theMatrix)


#Weh there are missing element.NA
#for normal methods,the answer will be NA,buy setting na.rm=TRUE
#helps us overcome making our final answer NA 

theMatrix[2,1] <- NA
apply(theMatrix,1,sum)

apply(theMatrix,1,sum, na.rm=TRUE)

rowSums(theMatrix)

rowSums(theMatrix, na.rm=TRUE)

#lapply pplies function to element of a list 
theList <- list(A=matrix(1:9,3), B=1:5, C=matrix(1:4,2), D=2)
lapply(theList, sum)

#THE RESULT doesnt look good, to make the result a vector, we use sapply
sapply(theList,sum)

#MAPPLY, MOST IMPORTANT member of the apply family
#applies a function  to each element of multiple lists 
#BUILD TWO LISTS 
firstList <- list(A=matrix(1:16, 4), B=matrix(1:16, 2), C=1:5)
secondList <- list(A=matrix(1:16, 4), B=matrix(1:16, 8), C=15:1)
mapply(identical,firstList,secondList)



#Build a simple function
#it adds the number of rows (or length) of each corresponding element
simpleFunc <- function(x,y)
{
  NROW(x) + NROW(y)
}
#apply the function to the two lists 
mapply(simpleFunc,firstList, secondList)


#aggragating or GROPYBY(IF SQL)
data(diamonds, package='ggplot2')
head(diamonds)
aggregate(price ~ cut , diamonds, mean )
#For the first argument we specified that price should be aggregated by cut.Notice
#that we only specified the columnn a meand did not have to identify the data because that
#is given in the second argument.After the third argument specifying the function,
#additional named arguments to that function can be passed,such as aggregate (price
#~cut, diamonds,mean,na.rm=TRUE).

#To group the data by more than one variable,add the additional variable to the right
#side of the formula separating it with a plus sign(+).

aggregate(price ~ cut + color , diamonds, mean)

#USING CBING TO AGGREGATE TWO VARIABLES 
aggregate(cbind(price,carat) ~ cut, diamonds,mean)

#all
aggregate(cbind(price,carat) ~cut + color,diamonds, mean)
#one function can be applied at a time 

#Unfortunately,aggregate can be quite slow.Fortunately, there are other options,such
#as plyr,dplyr and  data.table, that are considerably faster

#PLYR
#It epitomises the Split-Apply-Combine method of data manipulation 
#The core of plyr consists of functions such as ddply, llply and ldply,etc
#first lettter indicates input while thes second letter indicates output 

#USING DDPLY 
#To learn about ddply we look at the baseball
#data that come with plyr.
library(plyr)
head(baseball)

#subsetting with [ is better than using ifelse 
baseball$sf[baseball$year < 1954 ] <- 0

#check that it worked 
any(is.na(baseball$sf))

#only keeping players with atleast 50 at bat in a season 
baseball <- baseball[baseball$ab >= 50,]

#Calculating the OBP for a given player in a given year is easy enough with just
#vector operations.
# calculate OBP

baseball$OBP <- with(baseball, (h + bb + hbp)  / (ab + bb + sf))
tail(baseball)


#Hereweusedanewfunction,with.Thisallowsustospecifythecolumnsofa
#data.framewithouthavingtospecifythedata.framenameeachtime.
#TocalculatetheOBPforaplayer’sentirecareerwecannot justaveragehisindividual
#seasonOBPs;weneedtocalculateandsumthenumerator,andthendividebythesumof
#thedenominator.Thisrequirestheuseofddply.
#Firstwemakeafunctiontodothatcalculation; thenwewilluseddplytorunthat
#calculationforeachplayer.


 
#this function assumes that the columnnames for the data are as below
obp<-function(data)
{
  c(OBP=with(data, sum(h+ bb+hbp)/ sum(ab+ bb+ hbp+sf)))
}
#used dply to calculate career OBP for each player
careerOBP<-ddply(baseball,.variables="id",.fun=obp)
#sort theresults by OBP
careerOBP<-careerOBP[order(careerOBP$OBP,decreasing=TRUE),]
#see the results
head(careerOBP,10)


#USING llply  to sum elements of a list 
theList <- list(A=matrix(1:9, 3), B=1:5, C=matrix(1:4, 2), D=2)
lapply(theList,sum)

#using llply
llply(theList,sum)

#applying identical to it 
identical(lapply(theList, sum), llply(theList, sum))

#sapply to get a vector
sapply(theList, sum)

laply(theList, sum)


#PLYR HALPER FUNCTIONS 
#It has function like each,which lets us supply multiple functions
#to a function like aggregate
aggregate(price ~ cut, diamonds, each(mean, median))

#Another great function is idata.frame, which creates a reference to a data.frame so
#that subsetting is much faster and more memory efficient.
system.time(dlply(baseball,"id",nrow))

iBaseball <- idata.frame(baseball)
system.time(dlply(iBaseball, "id",nrow))

#in most situations where speed is a concern dplyr should be used over plyr and idata.frame

#data.TABLE PACKAGE 
library(data.table)
#create a regular dataframe 
theDF <-  data.frame(A= 1:10,
                     B= letters[1:10],
                     C=LETTERS[11:20],
                     D=rep(c("One", "Two", "Three"), length.out=10))

#create a datatable 
theDT <- data.table(
  A=1:10,
  B=letters[1:10],
  C=LETTERS[11:20],
  D=rep(c("One", "Two", "Three"), length.out=10)
)

#printing them to compare 
theDF
theDT

#checking 
class(theDF$B)
class(theDT$B)

#Creating a datatble for diamonds 
diamondsDT<-data.table(diamonds)
diamondsDT


#Accessing individual columns must be done a little differently than accessing columns in
#data.frames
theDT [,list(A,C)]

# just one column
theDT[, B]

#with=FALSE
theDT[, "B", with=FALSE]

theDT[, c("A", "C"), with=FALSE]

theCols <- c("A", "C")
theDT[, theCols, with=FALSE]


#seeing the tables 
tables()

#The key is used to index the data.table and will provide
#the extra speed. we use The key is used to index the data.table and will provide
#the extra speed. 


#set the key
#We start by adding a key to theDT. We will use the D column to index the
#data.table

setkey(theDT, D)

#show the data.table again
theDT


#SUbsettig use the key
theDT["One", ]

theDT[c("One", "Two"), ]


#SETTING MORE THAN ONE COLUMN AS A KEY 
# set the key
setkey(diamondsDT, cut, color)

#To access rows according to both keys, there is a special function named J. It takes
#multiple arguments, each of which is a vector of values to select.


#Access some rows 
diamondsDT[J("Ideal", "E")]

diamondsDT[J("Ideal", c("E", "D")),]

#AGGREGATING WITH DATATABLES
diamondsDT[, mean(price), by=cut]


#Theonlydifferencebetweenthisandthepreviousresult isthatthecolumnshave
#differentnames.Tospecifythenameoftheresultingcolumn,passtheaggregation
#functionasanamedlist

diamondsDT[, list(price=mean(price)), by=cut]

#To aggregate on multiple columns,specify them as alist().
diamondsDT[, mean(price), by=list(cut,color)]


diamondsDT[, list(price=mean(price), carat=mean(carat),
caratSum=sum(carat)), by=cut]


diamondsDT[, list(price=mean(price), carat=mean(carat)),
by=list(cut, color)]


#Aggregating data is a very important step in the analysis process.Sometimes it is the end
#goal, and other times it is in preparation for applying more advanced methods.No matter
#the reason for aggregation, there are plenty of functions to make it possible.These include
#aggregate,apply and lapply in base;ddply, llplyandtherest in plyr;and the groupby
#functionality in data.table

#FASTER GROUP MANIPULATION WITH DPLYR

#THE DOUBLE COLON USE CASE 
#When working with both dplyr and plyr it is important to load plyr first and then
#dplyr, because they have a number of functions with the same names, and in R, functions
#from the last package loaded take precedence. This sometimes creates a need to explicitly
#specify both the package and function using the double colon operator (::), such as
#plyr::summarize or dplyr::summarize.

#PIPING THE RESULT OF ONE FUNCTION IN ANOTHER FUNCTION 
#USING THE pipe (%>%) operator. weus use the magritrr library 

#Here we pipe the diamonds data into the head function and that into the
#dim function.
library(magrittr)
data(diamonds, package='ggplot2')
dim(head(diamonds,n=4))

#piped ONe
diamonds %>% head(4) %>% dim


#dplyr brought us tbl objects which are also an extension of data.frames.
class(diamonds)

diamonds
#Using the select funtion on  dataframes 
library(dplyr)
select(diamonds, carat, price)

diamonds %>% select(carat,price)


#IF COLUMN NAMES are stored in the variable,they should passed
#to the .dots argument 
theCols <- c('carat', 'price')
diamonds %>% select_(.dots=theCols) #deprecated 


#USING INDICES TO SPECIFY COLUMNS

select(diamonds, 1, 7)
diamonds %>% select(1,7)


#SEARCHING FOR A PARTIAL MATCH USING 
#start_with, ends_with and contains
diamonds %>% select(starts_with('c'))

#Endswith 
diamonds %>% select(ends_with('e'))


diamonds %>% select(contains('l'))


#REGULAR EXPRESSION SEARCHES DONE WITH MATCHES 
diamonds %>% select(matches('r.+t'))
#r - the name starts with the letter "r"
#.+ - followed by one or more of any character
#t - and ends with the letter "t"


#INCASE YOU DONT WANTA COLUMN TO BE SELECTED , PRECEDE IT WITH A MINUS 
diamonds %>% select(-carat, -price)

diamonds %>% select(-c(carat, price))

diamonds %>% select(-1,-7)

diamonds %>% select(-c(1, 7))
#Combines the column numbers into a vector using c() and then removes them

#But they do the same thing


#Specifyingcolumnsnottoselectusingquotednamesrequiresputtingtheminussign
#insidethequotessurroundingthenamesofundesiredcolumnsthataregiventothe
#.dotsargument.
diamonds %>% select_(.dots=c('-carat', '-price'))

diamonds %>% select(-one_of('carat', 'price'))



#USING FILTER 
diamonds %>% filter(cut == 'Ideal')

#using square brackets 
diamonds[diamonds$cut == 'Ideal',]


#using %in% for multiple 
diamonds %>% filter(cut %in% c('Ideal', 'Good'))

#using other equaity operators with filter 
diamonds%>% filter(price>=1000)
diamonds%>% filter(price!=1000)

#compound filtering using a comma or an ampersand
diamonds %>% filter(carat > 2 & price <14000)
diamonds %>% filter(carat > 2,price< 14000)

#A logical or statement is expressed with a vertical pipe(|).
diamonds%>% filter(carat<1 |carat> 5)

#QUOTED EXPRESSIONS (ONE WITH A TILD )
#filter_ is used 
diamonds  %>% filter_("cut == 'Ideal'")


#with quoted expresion 
diamonds %>%  filter_(~cut == 'Ideal')


#STore the Value as a variable first 
theCut <- 'Ideal'
diamonds %>% filter_(~cut == theCut)

#USING SPRINTF
theCol <- 'cut'
theCut<- 'Ideal'
diamonds %>% filter_(sprintf("%s == '%s'", theCol, theCut))


#USING INTERP FROM THE LAZYEVAL PACKAGE  TO CONSTRUCT A FORMULA OUT OF VARIABLES
#used before the o.60 dplyr version 
library(lazyeval)
#build a formula expression using variables 
interp(~ a == b, a =as.name(theCol), b=theCut)
~cut == "Ideal"

#use that as an argument to filter_


#SLICE FOR SPECIFYING ROWS BASED ON ROW NUMBER 
diamonds %>% slice(1:5)

diamonds %>% slice(c(1:5,8,15:20))

#c(1:5, 8, 15:20) creates a vector of row numbers
#1:5 gives rows 1 through 5
#8 adds row 8
#15:20 adds rows 15 through 20
#slice() then extracts those specific rows


#- is put before the rows to exclude 
diamonds %>% slice(-1)


#CREATING NEW COLUMS AND MODIFYIG EXISTING COLUMNS USING MUTATE 
#creating a new colum which is a ration of the two below

diamonds %>% mutate(price/carat)


#Depending on the size of the terminal,not all columns will be printed to the screen.To
#ensure this new column can fit on the screen,we select a few columns of interest using
#select and then pipe that result into mutate.

diamonds %>% select(carat,price) %>% mutate(price/carat)


#we can name the resulting column Ratio 
diamonds %>% select(carat, price) %>% mutate(Ratio=price/carat)


#Newly created columns made with  utate can be use immediately 
diamonds %>% select(carat, price) %>% mutate(Ratio=price/carat, Double = Ratio * 2)

#ASSIGNMENT PIPE %<>% of the magirittr package
#to be continued 

#SUMMARIZE function 
diamonds %>% summarize(mean(price))

diamonds %>% summarize(AvgPrice=mean(price),MedianPrice=median(price),AvgCarat=mean(carat))


#Summarise works so well with GROUPBY
diamonds %>% group_by(cut) %>% summarize(AvgPrice = mean(price))


#THis is a faster way and better way to ggregate data than the aggregate function 
#and enables multiple calculations an gruping variables 

diamonds %>% group_by(cut) %>% summarize(AvgPrice=mean(price), SumCarat=sum(carat))


diamonds %>% group_by(cut,color) %>% summarize(AvgPrice=mean(price), SumCarat=sum(carat))


#ARRANGE FUNCTION 
diamonds %>% group_by(cut) %>% summarize(AvgPrice=mean(price), SumCarat=sum(carat)) %>% arrange(AvgPrice)
#That AvgPrice column  was arrannged in Ascending order

#Descending order
diamonds %>% group_by(cut) %>% summarize(AvgPrice=mean(price), SumCarat=sum(carat)) %>% arrange(desc(AvgPrice))


#Do to be looked at in the future 


#DPLYR WITH DATABASES
##As of writing, dplyr works with
#PostgreSQL, MySQL, SQLite, MonetDB, Google Big Query and Spark DataFrames.
#For more standard computations, the R code is translated into equivalent SQL code. For
#arbitrary R code that cannot be easily translated into SQL, dplyr (experimentally) chunks
#the data into memory and runs the computations independently. This enables data
#munging and analysis on data that would otherwise not fit in memory

#eXAMPLE USING SQLITE DATABASE file 

#WE FIRST DOWLOAD THE FIle 
download.file("http://www.jaredlander.com/data/diamonds.db",destfile="data/diamonds.db", mode='wb')

#step1  create connection to the database
diaDBSource <- src_sqlite("data/dabase.crdownload")
diaDBSource

#Now that we have the database connection , let point to a specific table
#In this example, the database has two data tables called diamonds and DiamondColors and
#a metadata table called sqlite_stat1. Each table in the database needs to be pointed to
#individually. For our purposes we are only concerned with the diamonds table

diaTab <- tbl(diaDBSource,"diamonds")
diaTab


#This looks like a regular data.frame but is actually a table in the database,and just
#the first few rows are queried and displayed.Most calculations on this tbl are actually
#performedbythedatabaseitself.

diaTab %>% group_by(cut) %>% dplyr::summarize(Price=mean(price))
