#
# Exercises
# 

##############################
# 1) There are some variables:

availableCoffee <- 1000  # in grams
neededForEspresso <- 7    

# Using the variables, calculate how much coffee you need for a 6 espressos?


# How many espressos you get from the available coffee? 


##############################
# 2) There is some data about a fictional research group:
#

month <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
coffeeConsumption <- c(8, 6, 4, 5, 7, 9, 7, 7, 10, 6, 7, 7) # in kilograms
articlesSubmitted <- c(2, 0, 0, 0, 1, 0, 1, 4, 1, 0, 0, 2)

# Check that all the vectors are of equal length. Use function length. 

# Learn to use function mean:
# What are the average coffee consumption and the average number of articles submitted?


# Learn to use function sum:
# Calculate the average coffee consumption without the function mean, using only 
# functions sum and length, and the variable coffeeConsumption. 


# What happens if you try to give the vector month to the function mean?



###############################
# 3) Create a data frame of the vectors above and assing it to a variable named "coffee"



# View the data frame you created.


###############################
# 4) Calculate a new variable "espressos" to the data frame, which describes how may espressos the 
# research group consumed per month. Please use the previously defined variable 
# neededForEspresso. 




###############################
# 5) Load package psych. Install it if needed. Use command install.packages("psych)


# Use its function describe to show some describe statistics about the data frame coffee.


# What was the skew and kurtosis of the variable "espressos"?

#############################
# 6) Learn to use function cor for calculation correlations. 
 
# What is Pearson's correlation of articles submitted and coffee consumption?


# What is Spearman's correlation of articles submitted and coffee consumption?



#############################
# 7) Make the exercise 6 using with. If you already completed the exercise 6 using with,
# you can make this exercise without with. :)



##############################
# 8) Make a copy of the data frame coffee to another variable, and change the names of the variables.
# You are free to invent you own names.



#############################
# 9) Create missing values with function fix. Enter command fix(coffee).

# Fix can be useful if have small datasets and you need to make some small changes to the data
# interactively. However, remember that the changes are stored only to the data frame in your computer's
# memory. If you have loaded the data from file, the changes are not automatically saved, fortunately.
# I say fortunately, because editing with your data interactively is potentially a great error. 
# How to keep track of the changes you made? 

# Create a couple of missing values to variable coffeeConsumption. The cell should display NA. Then close the 
# editing window. 

# Try to calculate mean of the coffee consumption using function mean. What happens?


# How you can use parameter na.rm to ignore the missing values? 












