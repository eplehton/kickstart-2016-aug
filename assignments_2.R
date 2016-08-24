#
# Exercises
# 

##############################
# 1) Load data from file titanic_colnames.txt to a data frame. Hint: Use function read.table



#############################
# 2) Load data from file titanic_nocolnames.txt to another data frame.



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
names(titanic2)
names(titanic2)[2:6]

# Do you see what's happening?


#############################
# 4) Investigate the variables in another of the data frames. 
#
# Which variables are factors and which are not?
# 
# Is there a function to check this? Hint: ?factor
#
# Is some of the factors ordered? Can you change some of them to ordered?




###############################
# 5) Load the academics data from academics_data.R. This is slightly modified 
# version of the data displayed during the lecture. 
# Hint: ?source 



###############################
# 6) Write academics data to three text files using different settings.   
#
# a) Using empty space as a separator
# b) Using comma (,) as a separator
# c) Without column names


###############################
# 7) Read academics data back from the text files you just created in exercise 6. 


####################################
# 8) In the assignments 1.1.1. you created coffee data frame. Recreate the data frame and write it 
# to a text file. This will be used later. 



