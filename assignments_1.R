#
# Exercises: Creating vectors and data frames and assigning them to variables.
# Using operators in calculations. Using built-in functions in the calculations. 
#

##############################
# 1) There are some variables:

availableCoffee <- 1000  # in grams
neededForEspresso <- 7    

# Using the variables, calculate how much coffee you need for 6 espressos?


# How many espressos do you get from the available coffee? 


##############################
# 2) There is some data about a fictional research group:
#

month <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
coffeeConsumption <- c(8, 6, 4, 5, 7, 9, 7, 7, 10, 6, 7, 7) # in kilograms
articlesSubmitted <- c(2, 0, 0, 0, 1, 0, 1, 4, 1, 0, 0, 2)

# Check that all the vectors are of equal length. Use the function "length". 

# Learn to use the function "mean":
# What are the group's average coffee consumption and the average number of articles submitted?


# Learn to use the function "sum":
# Calculate the average coffee consumption without using the function "mean", using only the
# functions "sum" and "length", and the variable coffeeConsumption. 


# What happens if you try to give the vector month to the function mean?



###############################
# 3) Create a data frame of the vectors above and assign it to a variable named "coffee"



# View the data frame you created.


###############################
# 4) Calculate a new variable "espressos", which describes how may espressos the 
# research group consumed per month. Include the variable in the data frame you created 
# in problem 3. In solving this problem, please use the previously defined variable 
# "neededForEspresso". 




###############################
# 5) Load the package "psych". Install it if needed. Use the command install.packages("psych"),
# followed by library(psych)


# Use the function "describe" to show some statistics about the data frame "coffee".


# What was the skew and kurtosis of the variable "espressos"? Interpret the skew and kurtosis
# statistics. 

#############################
# 6) Learn to use the function "cor" for calculating correlations. 
 
# What is Pearson's correlation for articles submitted and coffee consumption?


# What is Spearman's correlation for articles submitted and coffee consumption?



#############################
# 7) Accessing variables in a data frame.
#

# This code creates a new data frame which describes tea consumption (in kg) and its relationship to grant applications submitted:

tea <- data.frame( month = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"),
                   teaConsumption = c(2, 2, 4, 5, 2, 1, 2, 8, 11, 4, 2, 1), 
                   grantApplicationsSubmitted = c(0, 1, 2, 3, 2, 0, 0, 0, 5, 0, 1, 0))

# Calculate the correlation of teaConsumption and submitted grant applications. 
# Use $-notation, like tea$teaConsumption to access the variables in the data frame.



##############################
# 8) Accessing variables in a data frame using the functino "with". 
# Instead of $-notation, write the call to the "cor" function like this: cor(teaConsumption, grantApplicationsSubmitted)
# This should not work, because variables with these names aren't to be found in the environment. Use "with" to define the context. 



#############################

# 9) Create a copy of the data frame "coffee" into a new variable, and change the names 
# of the variables. You can choose any names you feel like.


# How can you use the parameter "na.rm" of the function "mean" to ignore the missing values? 

#############################
# 10) Create missing values with the function "fix". Enter the command "fix(coffee)".

# Fix can be useful if have small datasets and you need to make some small changes to the data
# interactively. However, remember that the changes are stored only to the data frame in your 
# computer's memory. If you have loaded the data from file, the changes are not automatically 
# saved, fortunately. I say fortunately, because editing your data interactively makes it 
# impossible to keep track of the changes you've made. Also: Compare with the usual workflow
# in a GUI-based program such as SPSS or Excel. 


# Create a couple of missing values in the variable coffeeConsumption. The cell should display NA. 
# Then close the editing window. 

# Try to calculate mean of the coffee consumption using the function "mean", i.e. by running the command

mean(coffee$coffeeConsumption)

# What happens?


# How can you use the parameter "na.rm" of the function "mean" to ignore the missing values? 
