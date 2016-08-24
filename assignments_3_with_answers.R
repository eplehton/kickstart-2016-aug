##############################
# 1) Load data the academics data from the file academics_data.R or from one of the
# text files you created during the previous assignments. 

academics <- read.table("academics1.txt", header=TRUE, sep = " ")
academics

##############################
# 2) How could we ask for the summary of all variables for females?
# 
# Hint: Learn to solve the problems by dividing it to smaller steps. 
# Solve first the problem of subsetting the females out of the data frame. 
# Then solve the problem of describing them.

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
# 4) Load data frame from file Population_in_Finland.csv.
#
# Hint: The file contain the title and some meta information in the beginning.
# Use parameter skip with read.table to ignore them. 
# You may also need to set header=TRUE explicitly.  

Finland <- read.csv("Population_in_Finland.csv", header=TRUE, skip=5)

head(Finland) # Seems OK

#############################
# 5) Divide the population data by the population change (decreasing, increasing). 

decreasing <- Finland[Finland$Change.during.2014.Total < 0,]
increasing <- Finland[Finland$Change.during.2014.Total > 0,]

# Before you find out the right answers to the following questions based on the data, 
# try create a hypothesis:
#
# Are there more municipalities with increasing population than with decreasing population? 

    # decreasing I believe

# Are municipalities with increasing population larger than those with decreasing population?

  # No, I think there are many small municipalities with decreasing population


dim(Finland)
dim(increasing) # 96
dim(decreasing) # 221
# More municipalities with decreasing population

dim(decreasing)[1] + dim(increasing)[1] # So no municipalities with the exact same population in consecutive years



############################
# 6) What is the correlation of the population change of males and females?

cor(Finland$Change.during.2014.Males,Finland$Change.during.2014.Females)
# Almost perfect correlation, 0.993

############################
# 7) Is there municipalities which attract more females than males and vice versa?
# Updated: The question is actually a bit complicated. You can just look for example
# are there municipalities which has females moving in and males moving out.

head(Finland,20)

# Females in, Males out:
Fem.in_Males.out <- Finland[(Finland$Change.during.2014.Males < 0 & Finland$Change.during.2014.Females > 0), ]

# Males in, Females out:
Males.in_Fem.out <- Finland[(Finland$Change.during.2014.Females < 0 & Finland$Change.during.2014.Males > 0), ]

#with(Finland,if(Change.during.2014.Males < Change.during.2014.Females)

attach(Finland)  

Finland$attract.women <- ifelse((Change.during.2014.Females > Change.during.2014.Males), 1,0)
describe(Finland)
table(Finland$attract.women) # 149 municipalities with more women moving in than men OR less women moving out; 168 
# municipalities with the opposite pattern


