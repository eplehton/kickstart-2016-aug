#
# Exercises in aggregating and subsetting data
# 

#############
# 1) Let's continue working with the population data. Read the population data into a data frame.

Finland <- read.csv("Population_in_Finland.csv", header=TRUE, skip=5)


#############
# 2) Create two variables which indicate municipalities
#
# a) with a largish population (> 50 000) vs. those with a small population
# b) with an increasing population vs. a decreasing population.
#
# In the previous exercise you might have already made subsets of the data,
# but now you need to create variables into the data which denotes if the city is largish or smallish, 
# or decreasing or increasing in population.

head(Finland)
Finland$large <- ifelse(Finland$X31.12.2014.Total > 50000,1,0)
table(Finland$large) # How many large and small municipalities are there?
# There are only 20 municipalities with more than 50 000 inhabitants and 297 with less.

Finland$increasing.pop <- ifelse(Finland$Change.during.2014.Total > 0, 1, 0)
table(Finland$increasing.pop) # How many municipalities are there with increasing population?
# 96 municipalities with increasing population.

############
# 3) Using ddply, calculate some descriptive statistics like mean, standard deviation and frequency
# for:
#
# a) large and small cities

library(plyr)

ddply(Finland, .(large), summarize, M = mean(X31.12.2014.Total), SD = sd(X31.12.2014.Total), freq = length(large))

# b) those with increasing and descreasing population

ddply(Finland, .(increasing.pop), summarize, M = mean(X31.12.2014.Total), SD = sd(X31.12.2014.Total), freq = length(large))

# c) for all four categories, large with increasing pop, large with decreasing pop etc.

ddply(Finland, .(large,increasing.pop), summarize, M = mean(X31.12.2014.Total), SD = sd(X31.12.2014.Total), freq = length(large))

###################################
# 4) Find out the equation for the standard error of mean (SEM). Then 
# modify the ddply-calls above to include it. 

ddply(Finland, .(large), summarize, 
      M = mean(X31.12.2014.Total), 
      SD = sd(X31.12.2014.Total), 
      freq = length(large), 
      SEM = SD/sqrt(freq))

ddply(Finland, .(increasing.pop), summarize, 
      M = mean(X31.12.2014.Total), 
      SD = sd(X31.12.2014.Total), 
      freq = length(large),
      SEM = SD/sqrt(freq))

ddply(Finland, .(large,increasing.pop), summarize, 
      M = mean(X31.12.2014.Total), 
      SD = sd(X31.12.2014.Total), 
      freq = length(large),
      SEM = SD/sqrt(freq))

