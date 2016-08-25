#
# Exercises in using latent variable models
#

###############
# In these excercises, we'll work the bfi dataset included in the psych package. 
# It is about personality measurements based on the big five instrument. 

###############
# 1) Perform a parallel analysis on the data. What is the correct number of factors according to this analysis?

# To avoid silly mistakes, let's first create a version of the data with only the questionnaire items:

bfi.items <- bfi[,1:25]

fa.parallel(bfi.items)

# This indicates that 6 factors are needed

# 2) Perform an EFA using the psych package. Choose an estimation method and a rotation method and justify your choices.
# Looking at the communality / uniqueness and complexity values, 
# which items seem not to measure a single underlying construct in this data set?

# I'll perform a minres factor analysis (minimum residual analysis) for the following reasons:
# minres analysis doesn't require distributional assumptions on the items' part
# Presently, parameter estimates are of most interest rather than standard errors and test statistics;
# therefore, a robust estimation method such as minres is a good choice

# The first choice concerning rotations is that between orthogonal and oblique rotations. Let's at least begin by carrying
# out an oblique rotation to see if our factors are correlated. If not, or if the correlations are low, it would be an easy
# choice to opt for an orthogonal rotation. 
# It is also good to keep in mind the reason for rotating the factor solution: we'd like to end up with 
# as simple a factor structure as possible, i.e. one with many loadings close to one or zero. 
# 
# The Geomin rotation has been recommended (http://jpa.sagepub.com/content/29/4/304.full.pdf+html)
# for well-developed instruments for which it is likely that a simple factor structure will be obtained. 
# Big Five certainly has been researched a lot, so let's heed to this advice. To do this, we'll need the "GPArotation" package

install.packages("GPArotation")

# Of course, it's good to examine the variables first in different ways.

describe(bfi.items)
hist(bfi.items[,1]) # histograms for the different items are useful

# even though the parallel analysis suggested six factors to be extracted, I'll see how close to the
# expected five factor structure we'll end up 

bfi.fa <- fa(bfi.items,nfactors = 5, fm = "minres", rotate = "geominQ") 

print(bfi.fa, sort=TRUE) # sort = TRUE sorts factor loadings in a descending order

# Non-trivial factor correlations emerge, so we'll stick to the oblique rotation

?fa

# The basic five-factor structure seems to be mostly correct. Still, significant cross-loadings do occur:

# Items E3, E5, O4, N4 and N5 especially load on multiple factors and it isn't clear which factor they best measure.
# This can be seen looking at the com-column in the solution

# On the other hand, other items have only little variance in common with the rest of the items. For instance,
# items A1, O5, O2 and O4 have a rather high uniqueness value, indicating that the five-factor structure fails
# to account for a large portion of their variance.


# 3) Carry out a five-factor CFA using the lavaan package. Does the model fit the data according to the various fit indices? 

library(lavaan)

names(bfi)

bigfive.model <- 
  'Agreeableness =~ A1 + A2 + A3 + A4 + A5
Conscientiousness =~ C1 + C2 + C3 + C4 + C5
Extroversion =~ E1 + E2 + E3 + E4 + E5
Neuroticism =~ N1 + N2 + N3 + N4 + N5
Openness =~ O1 + O2 + O3 + O4 + O5'

bigfive.fit <- cfa(data = bfi, model = bigfive.model, estimator = "MLR")

summary(bigfive.fit, fit.measures = TRUE, rsquare=TRUE, standardized = TRUE)

#Estimator                                         ML      Robust
#Minimum Function Test Statistic             4165.467    3612.178
#Degrees of freedom                               265         265
#P-value (Chi-square)                           0.000       0.000
#Scaling correction factor                                  1.153
#for the Yuan-Bentler correction

#User model versus baseline model:

#Comparative Fit Index (CFI)                    0.782       0.777
#Tucker-Lewis Index (TLI)                       0.754       0.747

############ CFI and TLI show extremely bad model fit

#Root Mean Square Error of Approximation:

#RMSEA                                          0.078       0.072
#90 Percent Confidence Interval          0.076  0.080       0.070  0.074
#P-value RMSEA <= 0.05                          0.000       0.000

########### RMSEA value is high, indicating bad model fit




#Standardized Root Mean Square Residual:

#     SRMR                                           0.073       0.073



#### Detour: reverse-coding variables using the convenience functions in the psych-package ####

# Let's first create a list indicating which items are to be reverse coded. They are preceded by 
# a minus sign:

keys.list <-
  list(agree=c("-A1","A2","A3","A4","A5"),conscientious=c("C1","C2","C3","-C4","-C5"),
       extraversion=c("-E1","-E2","E3","E4","E5"),neuroticism=c("N1","N2","N3","N4","N5"),
       openness = c("O1","-O2","O3","O4","-O5")) 

# Then, let's feed the list to another convenience function which creates a matrix of ones and zeroes
# out of these: 

bfi.keys <- make.keys(bfi,keys.list)

# The reverse-coding function requires a *vector* of ones and zeroes (instead of a matrix). Let's 
# create one by subsetting the matrix:

bfi.rev.keys <- (c(bfi.keys[1:5,1], bfi.keys[6:10,2], bfi.keys[11:15,3], 
                   bfi.keys[16:20,4], bfi.keys[21:25,5]))

# Then, let's extract the bfi items and leave out the demographic variables:

bfi.items <- bfi[,1:25]

# And then finally reverse code the items:

bfi.rev <- reverse.code(bfi.rev.keys,bfi.items)
bfi.rev <- as.data.frame(bfi.rev)

names(bfi.rev) # minus signs in names. That might be useful to remember which items 
# have been reversed. For now, I'll still replace them with the original names:
names(bfi.rev) <- names(bfi)[1:25]

# Model fit for the model with reverse-coded items is (obviously) as good or bad as with the items
# in the original metric:

bigfive.rev.fit <- cfa(data = bfi.rev, model = bigfive.model, estimator = "MLR")
summary(bigfive.rev.fit, fit.measures = TRUE, rsquare=TRUE, standardized = TRUE)


#4) Examine the lack of model fit by producing plots of residual correlations using the qgraph package. 

library(qgraph)
res.bfi <- residuals(bigfive.fit,type="cor")$cor
qgraph(res.bfi,layout="circle", graph="default")

# There are lots of items here. Let's fine-tune the graph a bit:

# You can, for instance, try drawing the graph based on different values of the 
# "minimum" argument. This produces only the most salient connections:
qgraph(res.bfi,layout="circle", graph="default", vsize=4, minimum=.2)

# Or, to show some more connections, you can say:
qgraph(res.bfi,layout="circle", graph="default", vsize=4, minimum=.1,cut=.15)

# Neuroticism item N4 has extremely high residual correlations with many of the items supposedly
# measuring different latent variables. 
# It is of interest to examine the content of the questions. Short descriptions can be found in:
?bfi

# Item N4 is about often feeling blue. It has a high residual correlation with, among others,
# item O4, spend time reflecting on things and C5, feeling like one is wasting one's time.
# These connections seem sensible, and one could perhaps even argue that they are causal in nature. 
# Similar conceptual / common-sense analysis could be applied to the other items that have high
# residual correlations. You can also compare the items with high residual correlations with items 
# that had high complexity values above in the EFA. They are likely to be the same items. 



