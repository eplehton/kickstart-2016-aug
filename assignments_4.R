#
# Exercises in comparing two groups
# 

##################
# 1) Load the game performance data from file kr_gamewmc.txt
# Recalcualte the accuracy. 

##################
# 2) Find out whether there are differences in accuracy between genders using an appropriate statistical test.
#
# a) Use the confidence level of 99%

# b) Perform a one-sided test

# c) By default, R does not assume the variances of the dependent variable to be equal in the two groups, 
# i.e. the program computes the Welch t-test by default. 

#    How can you change this?

##################
# 3) Instead of a t.test, try to use a non-parametric alternative. Hint: ?wilcox.test


##################

# 4) Load the population data again (Population_in_Finland.csv) and divide the municipalities according to their size 
# (e.g. largish > 50 000, smallish) and population change (increasing, decreasing). 
#
# Hint: If you have completed the previous assignment where you loaded the data, 
# it is easy to use the function "source" to reload it



##################

# 5) Create boxplots which describe how cities with increasing population are different from
# cities with decreasing population. You can examine, say, the total population and the number males and females. 

# Do you see the problem with these boxplots? How would you address the problem?


#################
# 6) Create boxplots which describe the population changes for largish (>50 000) 
# and small municipalities. 



#################
# 7) Test if the population change is different and statistically significant (p < .05) 
# between large and not large municipalities. Which test would you use?


