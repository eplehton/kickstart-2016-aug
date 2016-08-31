#
# Exercises in comparing two groups
# 

##################
# 1) Load the game performance data from file kr_gamewmc.txt
# Recalcualte the accuracy. 

game.wmc <- read.table("kr_gamewmc.txt", header=TRUE)
game.wmc$accuracy <- game.wmc$Phit + game.wmc$PcorrectRejection

##################
# 2) Find out whether there are differences in accuracy between genders using an appropriate statistical test.
#
# a) Use the confidence level of 99%

t.test(formula = accuracy ~ gender, data = game.wmc, conf.level=0.99)

# Note the function call above: I explicitly specified each argument by its name, i.e. "formula = "; 
# "data =" and "conf.level = ". These can be left out when there is no question of which argument the parameter value 
# belongs to (compare the above call to the t.test function with that below).

# b) Perform a one-sided test

t.test(accuracy ~ gender, game.wmc, alternative="greater")

# c) By default, R does not assume the variances of the dependent variable to be equal in the two groups, 
# i.e. the program computes the Welch t-test by default. 

#    How can you change this?

t.test(accuracy ~ gender, game.wmc, conf.level=0.99, var.equal=T)

##################
# 3) Instead of a t.test, try to use a non-parametric alternative. Hint: ?wilcox.test

wilcox.test(accuracy ~ gender, data=game.wmc)

#################
# 4) Load the population data again (Population_in_Finland.csv) and divide the municipalities according to their size 
# (e.g. largish > 50 000, smallish) and population change (increasing, decreasing). 
#
# Hint: If you have completed the previous assignment where you loaded the data, 
# it is easy to use the function "source" to reload it

source('assignments_4_with_answers.R') # check the path and file name so that they match

#################
# 5) Create boxplots which describe how cities with increasing population are different from
# cities with decreasing population. You can examine, say, the total population and the number males and females. 

boxplot(X31.12.2014.Total ~ increasing.pop, Finland)
boxplot(X31.12.2014.Males ~ increasing.pop, Finland)
boxplot(X31.12.2014.Females ~ increasing.pop, Finland)

# Do you see the problem with these boxplots? How would you address the problem?

# There is one outlying value in the municipalities with increasing population and choosing the
# scale of the y-variable so that the population of this municipality is shown will make the rest
# of the plot pretty much unreadable. The issue can be addressed by choosing a logarithmic scale 
# for the y-axis. Note that this is different from first performing a logarithmic transformation
# on the y-variable and then creating a boxplot. The logarithmic scale can be chosen by saying:

boxplot(X31.12.2014.Total ~ increasing.pop, Finland,log="y")


#################
# 6) Create boxplots which describe the population changes for largish (>50 000) 
# and small municipalities. 

boxplot(Change.during.2014.Total ~ large, Finland)
boxplot(Change.during.2014.Females ~ large, Finland)
boxplot(Change.during.2014.Males ~ large, Finland)

#################
# 7) Test if the population change is different and statistically significant (p < .05) 
# between large and not large municipalities. Which test would you use?

t.test(Change.during.2014.Total ~ large, Finland)

#Welch Two Sample t-test
#
#data:  Change.during.2014.Total by large
#t = -2.9201, df = 19.007, p-value = 0.00878
#alternative hypothesis: true difference in means is not equal to 0
#95 percent confidence interval:
# -2304.1692  -380.1587
#sample estimates:
#mean in group 0 mean in group 1 
#      -20.06397      1322.10000 
