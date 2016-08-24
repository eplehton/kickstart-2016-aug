##############################
# 1) Load data the academics data from the file academics_data.R or from one of the
# text files you created during the previous assignments. 

academics <- read.table("academics1.txt", header=TRUE, sep = " ")
academics

##############################
# 2) How could we ask for the summary of all variables for females?
# 
# Hint: Learn to solve the problems by dividing them into smaller subproblems:
# go step by step. First, solve the problem of subsetting the data frame so that 
# you'll have a new data frame consisting only of females. Then solve the problem 
# of describing the new data frame.

women <- subset(academics,gender=="F")
summary(women)
describe(women)
summary(academics)
describe(academics)

##############################
# 3) Are the salaries of the females and males in this sample of academics equal?

men <- subset(academics, gender=="M")

mean(men$salaryBeforeTaxes)
mean(women$salaryBeforeTaxes)

# No, 7475 for men; 3850 for women

##############################
# 4) Load data from the file "Population_in_Finland.csv" into a new data frame.
#
# Hint: The file contains a title and some metadata in the beginning of the file.
# Use the parameter "skip" with "read.table" to ignore this extra information. 
# You may also need to set "header=TRUE" explicitly.  

Finland <- read.csv("Population_in_Finland.csv", header=TRUE, skip=5)

head(Finland) # Seems OK

#############################
# 5) Divide the population data by the population change (decreasing, increasing). 


decreasing <- Finland[Finland$Change.during.2014.Total < 0,]
increasing <- Finland[Finland$Change.during.2014.Total > 0,]

# Before you find out the right answers to the following questions by examining the data, 
# create a hypothesis: what do you think the answers will be?
#
# Are there more municipalities with increasing population than with decreasing population? 

    # decreasing I believe

# Are municipalities with increasing population larger than those with decreasing population?

  # Yes, I think there are many small municipalities with decreasing population,
  # whereas the big cities are attracting population


dim(Finland)
dim(increasing) # 96 7
dim(decreasing) # 221 7
# There are more municipalities with decreasing population

dim(decreasing)[1] + dim(increasing)[1] # So no municipalities with the exact same population in consecutive years

# Are municipalities with increasing population larger than those with decreasing population?

describe(increasing$X31.12.2014.Total)
describe(decreasing$X31.12.2014.Total)

# The mean number of inhabitants is greater in the municipalities with increasing population.
# Still, it's good to note the difference between the mean and the median in both data sets.
# It looks like there are some outlying big values in the data. 
# Looking at the skewness and kurtosis values indicates the same thing: 
# the data is skewed to the right and has a peaked distribution.

hist(increasing$X31.12.2014.Total)
hist(decreasing$X31.12.2014.Total)


############################
# 6) What is the correlation of the population change of males and females?

cor(Finland$Change.during.2014.Males,Finland$Change.during.2014.Females)

# Almost perfect correlation, 0.993

############################
# 7) Are there municipalities into which women are moving and from which men are moving out? What about the opposite,
# are there municipalities into which men are moving and from which women are moving out?

# Females in, Males out:
Fem.in_Males.out <- Finland[(Finland$Change.during.2014.Males < 0 & Finland$Change.during.2014.Females > 0), ]
dim(Fem.in_Males.out)

# Males in, Females out:
Males.in_Fem.out <- Finland[(Finland$Change.during.2014.Females < 0 & Finland$Change.during.2014.Males > 0), ]
dim(Males.in_Fem.out)

# It may also be of interest to know whether the change in the number of females and the change in the number
# of males are different. This can be done by using the following commands:

attach(Finland)  

Finland$attract.women <- ifelse((Change.during.2014.Females > Change.during.2014.Males), 1,0)

detach(Finland)

describe(Finland)
table(Finland$attract.women) # 149 municipalities with more women moving in than men OR less women moving out; 
                             # 168 municipalities with the opposite pattern


