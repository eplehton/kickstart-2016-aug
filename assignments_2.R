#
# Exercises
# 

##############################
# 1) Load data from file "titanic_colnames.txt" to a data frame. 
# Hint: Use the function "read.table"


#############################
# 2) Load data from file titanic_nocolnames.txt to another data frame.



# Do you see any difference between the two data frames?














#############################
# 3) The second data frame does not have meaningful column names, because there were
# none in the text file. For the sake of an exercise, please set the column names 
# but try to avoid writing the columns names by hand. Instead, try to copy the values from the
# first data frame. 

# Hint! Use the function "names" to investigate the data frames. Pay attention to the details. 
# What happens if we run this command?

titanic2 <- read.table("titanic_nocolnames.txt", sep=';', header=TRUE)
names(titanic2)
names(titanic2)[2:6]

# Do you see what's happening?




#############################
# 4) Investigate the variables in one of the data frames. 
#
# Which variables are of type "factor" and which are not?

# Is there a function to check this? Hint: ?factor
#
# Is any of the factors ordered? Can you change one of them to be ordered? For which variable does
# this make sense?



###############################
# 5) Load the academics data from academics_data.R. This is a slightly modified 
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
# 8) In In assignment 1,  you created a data frame called "coffee". 
# Recreate the data frame and write it to a text file. This file will be used later. 

