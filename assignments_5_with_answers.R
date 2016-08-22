#
# Exercises
# 

####
# 1) Load the game performance data from file kr_gamewmc.txt
# Recalcualte the accuracy. 

game.wmc <- read.table("kr_gamewmc.txt", header=TRUE)
game.wmc$accuracy <- game.wmc$Phit + game.wmc$PcorrectRejection

##################
# 2) Investigate the gender difference on accuracy using t-test.
#
# a) Change the confidence level used to 99%

t.test(accuracy ~ gender, game.wmc, conf.level=0.99)

# b) Perform one-sided test.

t.test(accuracy ~ gender, game.wmc alternative="greater")

# c) By default, R does not assume equal variance. Therefore the results says it is Welch t-test. 
#    How can you change this?

t.test(accuracy ~ gender, game.wmc, conf.level=0.99, var.equal=T)

##################
# 4) Instead of t.test, try to use non-parametric alternative. Hint: ?wilcox.test

wilcox.test(accuracy ~ gender, data=game.wmc)

#################
# 5) Load the population data again (Population_in_Finland.csv) and divide the municipalities according to their size and
# population change (increasing, decreasing). 
#
# Hint: If you have completed the assignment, it is easy to use source to load it again. 
# Hint: Especially, if you have used good variables names which do not conflict with other
# variable names in the script.

source('assignments_4_with_answers.R') # check the path and file name so that they match

#################
# 6) Make boxplots which describe the available variables. 

boxplot(X31.12.2014.Total ~ increasing.pop, Finland)
boxplot(X31.12.2014.Males ~ increasing.pop, Finland)
boxplot(X31.12.2014.Females ~ increasing.pop, Finland)


#################
# 7) Make boxplots which describe the population changes for largish (>50 000) 
# and small municipalities. 

boxplot(Change.during.2014.Total ~ large, Finland)
boxplot(Change.during.2014.Females ~ large, Finland)
boxplot(Change.during.2014.Males ~ large, Finland)

#################
# 8) Test if the population change is different and statistically significant (p < .05) between large and not large municipalities. 
# Which test would you use?

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





