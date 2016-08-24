#
# Exercises
# 

##############################
# 1) There are some variables:

availableCoffee <- 1000  # in grams
neededForEspresso <- 7    

# Using the variables, calculate how much coffee you need for 6 espressos?

coffee6espressos <- 6*7
coffee6espressos

# How many espressos do you get from the available coffee? 

howmanycoffees <- 1000 / 7
howmanycoffees


##############################
# 2) There is some data about a fictional research group:
#

month <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
coffeeConsumption <- c(8, 6, 4, 5, 7, 9, 7, 7, 10, 6, 7, 7) # in kilograms
articlesSubmitted <- c(2, 0, 0, 0, 1, 0, 1, 4, 1, 0, 0, 2)

# Check that all the vectors are of equal length. Use the function "length". 

length(month)
length(coffeeConsumption)
length(articlesSubmitted)
# you can also get acquainted with the function "identical" in this context:

identical(length(month),
          length(coffeeConsumption),
          length(articlesSubmitted))


# Learn to use the function "mean":
# What are the group's average coffee consumption and the average number of articles submitted?

mean(coffeeConsumption) # On average, the group consumes 6.9 kilograms of coffee / month
mean(articlesSubmitted) # On average, the group submits 0.9 articles / month

# Learn to use the function "sum":
# Calculate the average coffee consumption without using the function "mean", using only the
# functions "sum" and "length", and the variable coffeeConsumption. 

sum(coffeeConsumption) / length(coffeeConsumption)

# Does this produce results that are identical to those obtained using the function "mean"?

identical(mean(coffeeConsumption),(sum(coffeeConsumption) / length(coffeeConsumption)))

# What happens if you try to give the vector month to the function mean?

mean(month) # Does not work on character vectors

typeof(month)

#################################### Please note! ########################################################################
# Above, when calculating sum(coffeeConsumption) / length(coffeeConsumption) the 
# calculation worked because the vectors were of equal lengths. But what if they aren't? Let's try:

v1 <- c(1,2,3,4)
v2 <- c(6,7)
v1*v2
#[1]  6 14 18 28
v3 <- c(8,9,10)
v1*v3
#[1]  8 18 30 32
#Warning message:
#  In v1 * v3 :
#  longer object length is not a multiple of shorter object length

# So we see that in the case of vectorized computation, R implicitly recycles the shorter vector, in some cases 
# without notifying the user of this!!!



###############################
# 3) Create a data frame of the vectors above and assign it to a variable named "coffee"

coffee <- data.frame(month, coffeeConsumption, articlesSubmitted)


# View the data frame you created.

coffee
View(coffee)

###############################
# 4) Calculate a new variable "espressos", which describes how may espressos the 
# research group consumed per month. Include the variable in the data frame you created 
# in problem 3. In solving this problem, please use the previously defined variable 
# "neededForEspresso". 

##### This method of solving the problem works but should be avoided. I will explain below why this is so.

coffee$espressos <- (coffeeConsumption * 1000) / neededForEspresso
coffee

# This method should be avoided because it's error-prone. Now the dataframe and our 
# environment (think desktop) both contain the variables "month", "coffeeConsumption" 
# and "articlesSubmitted" and above, I'm creating a new variable into the dataframe 
# based on the variables in the environment. It would be better to do the calculations 
# based on the variables already in the dataframe. To be sure, let's remove the variables
# from the environment (we can always re-create them easily if needed): 

rm(month, coffeeConsumption, articlesSubmitted)

# You can now see the above command doesn't work anymore:

(coffeeConsumption * 1000) / neededForEspresso

# So let's do the same operation based on the variables in the dataframe:

coffee$espressos <- (coffee$coffeeConsumption * 1000) / neededForEspresso


###############################
# 5) Load the package "psych". Install it if needed. Use the command install.packages("psych"),
# followed by library(psych)

install.packages("psych")
library(psych)

# Use the function "describe" to show some statistics about the data frame "coffee".

describe(coffee)

# What was the skew and kurtosis of the variable "espressos"? Interpret the skew and kurtosis
# statistics. 

# skew: 0.12, i.e. right tail is slightly longer than the left; kurtosis: -0.61, 
# i.e. slightly light-tailed distribution

hist(coffee$espressos) #well... It's good to always plot the data in addition to interpreting
# the numbers!


#############################
# 6) Learn to use the function "cor" for calculating correlations. 
 
# What is Pearson's correlation for articles submitted and coffee consumption?

cor(coffee$articlesSubmitted, coffee$coffeeConsumption)

# What is Spearman's correlation for articles submitted and coffee consumption?

cor(coffee$articlesSubmitted, coffee$coffeeConsumption, method="spearman")

# Hmmm, why the big difference?

plot(coffee$articlesSubmitted,coffee$coffeeConsumption)

#############################
# 7) Accessing variables in a data frame.
#

# This code creates a new data frame which describes tea consumption (in kg) and its relationship to grant applications submitted:

tea <- data.frame( month = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"),
                   teaConsumption = c(2, 2, 4, 5, 2, 1, 2, 8, 11, 4, 2, 1), 
                   grantApplicationsSubmitted = c(0, 1, 2, 3, 2, 0, 0, 0, 5, 0, 1, 0))

# Calculate the correlation of teaConsumption and submitted grant applications. 
# Use $-notation, like tea$teaConsumption to access the variables in the data frame.

cor(tea$teaConsumption,tea$grantApplicationsSubmitted)

################
# 8) Accessing variables in a data frame using the functino "with". 
# Instead of $-notation, write the call to the "cor" function like this: cor(teaConsumption, grantApplicationsSubmitted)
# This should not work, because variables with these names aren't to be found in the environment. Use "with" to define the context. 

with(tea, cor(teaConsumption, grantApplicationsSubmitted))

################
# 9) Create a copy of the data frame "coffee" into a new variable, and change the names 
# of the variables. You can choose any names you feel like.

coffee2 <- coffee
names(coffee2) <- c("Petra", "Olli", "painii", "Riossa")
coffee2


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

# NA is returned


# How can you use the parameter "na.rm" of the function "mean" to ignore the missing values? 

mean(coffee$coffeeConsumption,na.rm = TRUE)
