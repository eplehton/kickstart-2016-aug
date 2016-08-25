#
# Exercises in plotting data and using ggplot2
#

#####
# 1) Load the dataset "sleep" from the R dataset repository using the command "data(sleep)".
#    Get acquainted with the data. 

data(sleep)

describe(sleep) # descriptive statistics
?sleep # R help contains information on the built-in datasets
str(sleep) # which types of variables?
class(sleep$extra)
class(sleep$group)
class(sleep$ID)
?typeof # an additional command for investigating the structure of variables
typeof(sleep$extra)
typeof(sleep$group)
typeof(sleep$ID)


#####
# 2) Create different kinds of plots, using both boxplot and ggplot2, to describe the
# differences between the two drugs. 

boxplot(extra~group,sleep) # basic boxplot
plot(sleep$extra,sleep$group) # basic scatterplot

library(ggplot2)

ggplot(data = sleep, aes(x = group, y = extra)) + geom_boxplot() # boxplot
ggplot(data = sleep, aes(x = group, y = extra)) + geom_point() # scatterplot
ggplot(data = sleep, aes(x = group, y = extra)) + geom_boxplot() + geom_point() # boxplot and scatterplot

# I'll construct two histograms to compare the drugs, but I'll do it in a piecemeal fashion
# First the basic histogram
ggplot(data = sleep, aes(extra)) + geom_histogram()
# Adjust appearance a bit:
ggplot(data = sleep, aes(extra)) + geom_histogram(binwidth=.8)
# Make it look nicer:
ggplot(data = sleep, aes(extra)) + geom_histogram(binwidth=.8,color="black", fill="white")
# Compare groups:
ggplot(data = sleep, aes(x=extra,fill=group)) + geom_histogram(binwidth=2,alpha=.3, position="identity")
# This looks a bit silly because there are so few observations. 
# The idea of plotting overlaid histograms is nice, though.


######
# 3) Do the two drugs have different effects on extra hours of sleep? Carry out 
# Student's paired t-test to investigate.

# What was the syntax again..?
?t.test

# How similar are the variances?
ddply(sleep,.(group), summarize, SD = sd(extra)) # Pretty much so

t.test(sleep$extra~sleep$group, paired=TRUE, var.equal = TRUE)

########## 
# 4) The data is in the long format. Reshape the data into the wide format 
# so that the two observations from the same participant (denoted with variable group)
# are contained in their own variables. 

library(reshape2)

widesleep <- dcast(sleep,ID~group,value.var="extra") # Don't forget the quotes!
widesleep


########## 
# 5) Create a scatter plot where the extra hours of sleep for drug 1 are on the x-axis, and
# the extra hours for drug 2 are on the y-axis. 

# I need to rename the columns of the new dataset first:
names(widesleep)[2:3] <- paste("drug",sep="",1:2)
names(widesleep)

# Then I can produce the basic scatterplot
ggplot(widesleep, aes(x=drug1,y=drug2)) + geom_point()

# Or fine-tune it a bit, fooling around with colors for instance:
ggplot(widesleep, aes(x=drug1,y=drug2)) + geom_point(color="#FF33FF",size=3) + theme_light()

# Or see who is where based on subject ID:
ggplot(widesleep, aes(x=drug1,y=drug2, label=ID)) + geom_text(size=5)

# Or fit a regression line to the plot:
ggplot(widesleep, aes(x=drug1,y=drug2)) + geom_point() + geom_smooth(method=lm,se=FALSE)


####
# 6) Load the game data from file kr_gameraw.txt. 

gameraw <- read.table("kr_gameraw.txt",header=TRUE)
head(gameraw)

# Calculate the accuracy of responses for each participant. See the lecture notes (Repeated measures ANOVA) 
# for instructions on how to calculate it. 
library(plyr)
accuracy <- ddply(gameraw, .(player_id), summarize, 
                  Phit = mean(hit),
                  Pcorrej = mean(correctRejection),
                  accuracy = Phit + Pcorrej)
                  
head(accuracy)

####
# 7) Create a plot which describes the level of accuracy by age group and gender. 
# Run a 2 x 2 ANOVA to investigate if there are differences in accuracy as a function of age group or gender, 
# and whether there is an interaction effect for these two variables.

head(gameraw)

# Let's produce another data set with the accuracy, age group and gender variables

gameacc <- ddply(gameraw, .(player_id, age_grp, gender), summarize, 
                 Phit = mean(hit),
                 Pcorrej = mean(correctRejection),
                 accuracy = Phit + Pcorrej)

head(gameacc)

# Let's produce a barplot:
library(ggplot2)

ggplot(gameacc, aes(x=age_grp,y=accuracy,fill=gender)) + 
  geom_bar(position=position_dodge(), stat="identity") +
  scale_x_discrete(labels=c("Adult", "Child")) + 
  xlab("Age group") + 
  guides(fill=guide_legend(title=NULL))

# The y-axis scale isn't all that useful, but setting ylim(.5,.9) won't work: if in bargraphs the lower bound isn't
# zero, the bar won't be drawn at all!

# And a boxplot:

ggplot(gameacc, aes(x=age_grp,y=accuracy,fill=gender)) + 
  geom_boxplot() +
  scale_x_discrete(labels=c("Adult", "Child")) + xlab("Age group") + 
  guides(fill=guide_legend(title=NULL))

# Let's calculate the ANOVA using the car package, and remember to set the contrasts correctly!

library(car)

options("contrasts")
options(contrasts=c('contr.sum','contr.poly'))

model.acc <- lm(accuracy ~ age_grp*gender, data=gameacc)

Anova(model.acc, type=3)

# This is also another way to calculate type III Sums of Squares without using car package:
drop1(model.acc,~.,test="F") 

# There are only differences between the two age groups, no interaction and no effect of gender

##############################################################################
# Here's a bit more advanced stuff that you will find useful 
# it you are going to use R for publications

# In case you would like to have least squares estimates for the effects and pairwise comparisons
library(lsmeans)
lsm <- lsmeans(model.acc, pairwise ~ age_grp)
# here, first you get estimates and then comparison, which is not very interesting with two-level factors
summary(lsm)

# the interaction was not significant, so there is no much point to make more complex pairwise 
# comparisons, but I show here how to do them
lsm <- lsmeans(model.acc, pairwise ~ age_grp*gender)
# remember to ask for the correct adjustment for pairwise comparisons' p-values
summary(lsm, adjust="bonferroni") 

# Based on lsm you could also produce plots of the effects
# We grab the estimates from the object and convert it to a data frame with the function summary
lsmeans.df <- summary(lsm$lsmeans)

pd = position_dodge(width=0.6)
ggplot(lsmeans.df, aes(x=age_grp, colour=gender, y=lsmean, ymin=lower.CL, ymax=upper.CL)) +
  geom_point(position=pd, size=4) +
  geom_errorbar(position=pd, width=0.2)

# or more SPSS style ...
ggplot(lsmeans.df, aes(x=age_grp, colour=gender, y=lsmean, group=gender)) +
  geom_line()

# partial eta squared effects sizes 
library(heplots)
etasq(model.acc)

############
# 8) In the lecture notes the game was divided into three sets, and we investigated learning effects 
# over the course of the game. Perform a repeates measures ANOVA to investigate whether gender has 
# an effect on learning. This means that you need to investigate the interaction of the set and gender. 

gameraw$set <- recode(gameraw$video_id,"0:9=1; 10:19=2; 20:29=3")
gameraw$set <- ordered(gameraw$set)

aggredata <- ddply(gameraw, .(age_grp, player_id, set,gender), summarize,
                Phit = mean(hit),
                PcorrectRejection = mean(correctRejection),
                accuracy = Phit + PcorrectRejection)
head(aggredata)

library(ez) # We use ezANOVA for rm-ANOVA, because it is a bit easier

rep.model <- ezANOVA(aggredata, 
                     dv=accuracy, 
                     wid=player_id, 
                     within = .(set),
                     between = .(gender),
                     type=3)

rep.model
# Only the effect of set is statistically significant: 
#$ANOVA
#Effect DFn DFd            F           p p<.05          ges
#2     gender   1  34 0.0002757957 0.986847135       4.232211e-06
#3        set   2  68 4.9335941732 0.009982751     * 6.489369e-02
#4 gender:set   2  68 1.1883119307 0.310982859       1.644028e-02

# The result remains the same also after the sphericity corrections:

#$`Sphericity Corrections`
#Effect       GGe      p[GG] p[GG]<.05       HFe      p[HF] p[HF]<.05
#3        set 0.9400385 0.01151991         * 0.9931951 0.01014617         *
#  4 gender:set 0.9400385 0.30929880           0.9931951 0.31080472          


####
# 9) Refresh your memories from previous statistics courses. 
# Is everything all right with the repeated measures ANOVA you just performed? 
# Are we breaking any assumptions?

# Perhaps it would be good to check the variance-covariance matrix of the three conditions to see 
# how we're doing with the sphericity assumption:

# Create a wide version of the data with the variable accuracy:
temp <- dcast(aggredata, player_id ~ set, value.var = "accuracy")

# give the variables better names:
names(temp) <- c("player_id", paste("set", sep="", 1:3))

# get rid of the unnecessary id-variable:
temp$player_id <- NULL

# calculate the variance-covariance matrix:
cov(temp)

# Using the correlation metric shows that the three conditions are indeed correlated:

cor(temp)
