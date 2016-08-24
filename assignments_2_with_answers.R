#
# Exercises
# 

##############################
# 1) Load data from file "titanic_colnames.txt" to a data frame. 
# Hint: Use the function "read.table"

titanic <- read.table("titanic_colnames.txt", header = TRUE, sep=":") 

#NB: Working directory needs to be set correctly

titanic

#############################
# 2) Load data from file titanic_nocolnames.txt to another data frame.

titanic.nocolnames <- read.table("titanic_nocolnames.txt", header = FALSE, sep=";")
titanic.nocolnames

# Do you see any difference between the two data frames?

head(titanic)
head(titanic.nocolnames)

# - column names: the first data frame has meaningful column names (variable names)
# - row number column as data: the second data frame has row numbers both in the usual
# row.names variable and the V1 variable

#############################
# 3) The second data frame does not have meaningful column names, because there were
# none in the text file. For the sake of an exercise, please set the column names 
# but try to avoid writing the columns names by hand. Instead, try to copy the values from the
# first data frame. 

# Hint! Use the function "names" to investigate the data frames. Pay attention to the details. 
# What happens if we run this command?

titanic2 <- read.table("titanic_nocolnames.txt", sep=';', header=TRUE)

# Doing this takes the variable names from the first line of data, which is incorrect in this case
names(titanic2)
names(titanic2)[2:6]
names(titanic)

# Do you see what's happening?

# The mistake can be noted by comparing the two datasets:
names(titanic2)
names(titanic.nocolnames)
head(titanic2)
head(titanic.nocolnames)
names(titanic2)[2:6] <- names(titanic.nocolnames)[2:6] <- names(titanic)
head(titanic2)
head(titanic.nocolnames)

#############################
# 4) Investigate the variables in one of the data frames. 
#
# Which variables are of type "factor" and which are not?

# I'm using a simple for-loop below to answer the question. The syntax is surely intelligible
# for those who have any programming experience, but for those without, a brief explanation
# may be useful. For-loops (and other loops) repeat command a certain number of times, each
# time changing something in the code automatically. In this case, the index "i" starts from
# 1 and goes through the consecutive vaues until the end of the vector "names(titanic)". This
# basic logic is declared inside the first pair of brackets. Then, inside the curly brackets
# I'm telling the computer what I'd want it to do: in this case, I'd like it to just print out
# the class attribute of each variable in the "titanic" data frame. 

for (i in 1:length(names(titanic))) {
  print(class(titanic[[i]]))
}

# [1] "factor"
# [1] "factor"
# [1] "factor"
# [1] "factor"
# [1] "integer"

# 
# Is there a function to check this? Hint: ?factor

?factor

# The help file tells us that there is indeed a function called "is.factor()" that we can use 
# to check whether something is a factor. The function returns "TRUE" or "FALSE". 
#
# Is any of the factors ordered? Can you change one of them to be ordered? For which variable does
# this make sense?

for (i in 1:length(names(titanic))) {
  print(is.ordered(titanic[[i]]))
}

# None are ordered

head(titanic)

titanic$Class <- as.ordered(titanic$Class)

for (i in 1:length(names(titanic))) {print(is.ordered(titanic[[i]]))}

# That did the trick!

###############################
# 5) Load the academics data from "academics_data.R". This is a slightly modified 
# version of the data displayed during the lecture. 
# Hint: ?source 

source("academics_data.R")
academics

###############################
# 6) Write academics data to three text files using different settings.   
#
# a) Using empty space as a separator
# b) Using comma (,) as a separator
# c) Without column names

write.table(academics, "academics1.txt", sep = " ")
write.table(academics, "academics2.txt", sep = ",")
write.table(academics, "academics3.txt", col.names = FALSE)

###############################
# 7) Read academics data back from the text files you just created in exercise 6. 

rm(academics)
academics <- read.table("academics1.txt", header=TRUE, sep = " ")
academics

####################################
# 8) In assignment 1 you created a data frame called "coffee". 
# Recreate the data frame and write it to a text file. This file will be used later. 

coffee
write.table(coffee, "coffee.txt",row.names = FALSE)
