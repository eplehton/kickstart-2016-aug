#
# Exercises
# 

##############################
# 1) Load data from file titanic_colnames.txt to a data frame. Hint: Use function read.table

titanic <- read.table("titanic_colnames.txt", header = TRUE, sep=":") #NB: Working directory needs to be set correctly
titanic

#############################
# 2) Load data from file titanic_nocolnames.txt to another data frame.

titanic.nocolnames <- read.table("titanic_nocolnames.txt", header = FALSE, sep=";")
titanic.nocolnames

# Do you see any difference between the two data frames?
# - column names
# - row number column as data



#############################
# 3) The second data frame does not have meaningful columns names, because they were 
# missing from the file. For the sake of an exercise, please set the column names 
# but try to avoid writing the columns names by hand. Instead, try to copy the values from the
# first data frame. 

# Hint! Use function names to investigate the data frames. Pay attention to the details. 

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
# 4) Investigate the variables in another of the data frames. 
#
# Which variables are factors and which are not?

for (i in 1:length(names(titanic))) {print(class(titanic[[i]]))}

# [1] "factor"
# [1] "factor"
# [1] "factor"
# [1] "factor"
# [1] "integer"

# 
# Is there a function to check this? Hint: ?factor
#
# Is some of the factors ordered? Can you change some of them to ordered?

for (i in 1:length(names(titanic))) {print(is.ordered(titanic[[i]]))}

# None are ordered

head(titanic)

titanic$Class <- as.ordered(titanic$Class)

for (i in 1:length(names(titanic))) {print(is.ordered(titanic[[i]]))}

# That did the trick!

###############################
# 5) Load the academics data from academics_data.R. This is slightly modified 
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

academics1 <- write.table(academics,"academics1.txt", sep = " ")
academics2 <- write.table(academics,"academics2.txt", sep = ",")
academics3 <- write.table(academics,"academics3.txt", col.names = FALSE)

###############################
# 7) Read academics data back from the text files you just created in exercise 6. 

rm(academics)
academics <- read.table("academics1.txt", header=TRUE, sep = " ")
academics

####################################
# 8) In the assignments 1.1.1. you created coffee data frame. Recreate the data frame and write it 
# to a text file. This will be used later. 

coffee
write.table(coffee, "coffee.txt",row.names = FALSE)
