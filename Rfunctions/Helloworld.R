say.Hello <- function(){
  print("Hello, world!")
  
}

#springf function Its
#first argument is a string with special input characters and subsequent arguments that will
#be substituted into the special input characters.

#One substitution 
sprintf("Hello %s", "Jared")

#two substitutions 
sprintf(" Hello %s, today is %s ", "Jared", "Sunday")


#Using the sprintf to build string best on the fuction arguments 
hello.person <- function(name)
{
  print(sprintf("Hello %s",name))
}
hello.person("Jared")

hello.person("Bob")

#FUNCTION WITH MORE THAN ONE ARGUMENT 
hello.person1 <- function(first, last)
{
  print(sprintf("Hello %s %s", first,last))
}

#By position 
#NOte that to use the argument ,you pass them as strings to the variable
hello.person1("Jared", "Lander")

#By name 
hello.person1(last="Lander", first="Jared")

#the other order 
hello.person1(first="Lander", last="Jared")

#specifying one name 
hello.person1("Jared", last="Lander")


#Creating a default Argument via the function Argument assignment 
hello.person2 <- function(first, last="Doe ")
{
  print(sprintf("Hello %s  %s", first,last))
}
#so if you don't specify the second name,the name in the argument will
#provided automatically 

#calling without specifying the last
hello.person2("Jared")

#calling with a different last
hello.person2("Jared","Lander")

#FOR EXTRA ARGUMENTS USE dot-dot-dot argument(...)
hello.person3 <- function(first, last="Doe",...)
{
  print(sprintf("Hello %s %s ",first,last))
}

#call Hello.person3 with an extra argument 
hello.person3("Jared", extra= "Goodbye")

#changing the default inbetween 
hello.person3("Jared", "Lander", "Goodbye")


#Returning Values
#The return command more explicitly specifies that a value should be returned 
#and the function should be exited.

# first build it without an explicit return
double.num <- function(x)
{
  x * 2
}

double.num(5)

#Nw building it with an explixcit return 
double.num <- function(x)
{
  return(x * 2)
}
double.num(5)

# build it again, this time with another argument after the explicit return
double.num <- function(x)
{
  return(x * 2)
  # below here is not executed because the function already exited
  print("Hello!")
  return(17)
}



#DO.CALL wont use it now 


#CONTROL STATEMENTS 
#The main control statements are if, else, ifelse
#and switch.

as.numeric <- (TRUE)

as.numeric(FALSE)

1 != 1


#Assigning 1 to a variable toCheck
toCheck <- 1 
# if toCheck is equal to 1, print hello

if(toCheck == 1)
{
  print("Hello")
}

# notice nothing was printed if it is not true 

#Using an Else statemnt 
# first create the function

check.bool <- function(x)
{
  if(x == 1)
  {
    # if the input is equal to 1, print hello
    print("Hello")
  } else #else must be here
  {
    #otherwise print Goodbye
    print("Goodbye")
  }
}
#now using the function 

check.bool(1)
check.bool(0)
check.bool("K")
check.bool(TRUE)


#ELSE IF
#Perhaps we want to successively test a few cases. 
#That is where we can use else if.
check.bool <- function(x)
{
    if(x == 1)
    {
      # if the input is equal to 1, print hello
      print("hello")
    }else if(x == 0)
    {
      # if the input is equal to 0, print goodbye
      print("goodbye")
    }else
    {
      # otherwise print confused
      print("confused")
    }
}

check.bool(1)
check.bool(0)
check.bool(2)
check.bool("k")


#SWITCH STATEMENT 
#If we have multiple cases to check, writing else if repeatedly can be cumbersome and
#inefficient. This is where switch is most useful. The first argument is the value we are
#testing. Subsequent arguments are a particular value and what should be the result. The last
#argument, if not given a value, is the default result.

use.switch <- function(x)
{
  switch(x,
         "a" = "first",
         "b" = "second",
         "z" = "last",
         "c" = "third",
         "other")
}
use.switch("a")
use.switch("b")
use.switch("c")
use.switch("d")
use.switch("e")
use.switch("z")


#If the first argument is numeric, it is matched positionally to the following arguments,
#regardless of the names of the subsequent arguments. If the numeric argument is greater
#than the number of subsequent arguments, NULL is returned.
use.switch(1)
use.switch(2)
use.switch(3)
use.switch(4)
use.switch(5)
use.switch(6)# nothing is returned
is.null(use.switch(6))  #returns TRUE


#IFELSE
#The first argument is the condition to be tested (much like in a
#traditional if statement), the second argument is the return value if the test is TRUE and
#the third argument is the return value if the test if FALSE. The beauty here—unlike
#with the traditional if—is that this works with vectorized arguments. As is often the case
#in R, using vectorization avoids for loops and speeds up our code


# see if 1 == 1
ifelse(1 == 1, "Yes", "No")

# see if 1 == 0
ifelse(1 == 0, "Yes", "No")

#COMPOUND TESTS 
#The statement being tested with if, ifelse and switch can be any argument that results in
#a logical TRUE or FALSE. This can be an equality check or even the result of
#is.numeric or is.na. Sometimes we want to test more than one relationship at a time.
#This is done using logical and and or operators. These are & and && for and and |
#  and || for or. The differences are subtle but can impact our code’s speed.
#The double form (&& or ||) is best used in if and the single form (& or |) is necessary
#for ifelse. The double form compares only one element from each side, while the
#single form compares each element of each side.

a <- c(1, 1, 0, 1)
b <- c(2, 1, 0, 1)

# this checks each element of a and each element of b
ifelse(a == 1 & b == 1, "Yes", "No")

# this only checks the first element of a and the first element of b
# it only returns one result
ifelse(a == 1 && b == 1, "Yes", "No")



#Another difference between the double and single forms is how they are processed.
#When using the single form, both sides of the operator are always checked. With the
#double form, sometimes only the left side needs to be checked. For instance, if testing
#1 == 0 && 2 == 2,theleftside fails, so there is no reason to check the right hand side.
#Similarly, when testing 3 == 3 || 0 == 0, the left side passes, so there is no need to
##check the right side. This can be particularly helpful when the right side would throw an
#error if the left side had failed.
#There can be more than just two conditions tested. Many conditions can be strung
#together using multiple and or or operators. The different clauses can be grouped by
#parentheses just like mathematical operations. Without parentheses, the order of operations
#is similar to PEMDAS, seen in Section 4.1, where and is equivalent to multiplication and
#or is equivalent to addition, so and takes precedence over or.



#For LOOP
for (i in 1:10)
{
  print(i)
}
print(1:10)

#Sure, it does not look exactly the same, but that is just cosmetic.
#The vector in for loops does not have to be sequential, it can be any vector.

# build a vector holding fruit names
fruit <- c("apple","banana","pomengrenate")
#make a variable to hold their lengths ,with all NA to start 
fruitLength <- rep(NA, length(fruit))
# show it, all NAs
#show it, all NAs
fruitLength

# give it names
names(fruitLength) <- fruit
# show it again, still NAs
fruitLength

for(a in fruit)
{
  fruitLength[a] <- nchar(a)
}
# show the lengths
fruitLength

#Again, R’s built-in vectorization could have made all of this much easier.
# simply call nchar
fruitLength2 <- nchar(fruit)
# give it names
names(fruitLength2) <- fruit
fruitLength2


#This, as expected, provides identical results, as seen next.
identical(fruitLength, fruitLength2)


#WHILE LOOP
x <- 1
while(x <= 5)
{
  print(x)
  x <- x + 1
}


#BREAK AND NEXT FOR CONTROLLING LOOPS 
for(i in 1:10)
{
  if(i == 3)
  {
    next
  }
  print(i)
}
#Notice that the number 3 did not get printed.

for (i in 1:10){
  if(i == 4)
  {
    break
  }
  print(i)
}

##Here, even though we told R to iterate over the first ten integers, it stopped after 3
#because we broke the loop at 4.

#NOTE 
#The two primary loops are for, which iterates over a fixed sequence of elements, and
#while which continues a loop as long as some condition holds true. As stated earlier, if a
#solution can be done without loops, via vectorization or matrix algebra, then avoid the
#loop. It is particularly important to avoid nested loops. Loops inside other loops are
#extremely slow in R.