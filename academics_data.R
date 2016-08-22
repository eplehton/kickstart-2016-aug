thesisWorker <- 0
researchAssistant <- 1700
doctoralStudent <- 2200
postdoc <- 3200
professor <- 5500
rector <- 25000

salaryBeforeTaxes <- c(thesisWorker, 
                       researchAssistant,
                       doctoralStudent,
                       postdoc,
                       professor,
                       rector)

 

employerCosts <- salaryBeforeTaxes * 1.56 


position <- c("Thesis worker", 
              "Research assistant",
              "Doctoral student",
              "Postdoc", 
              "Professor", 
              "Rector")

workingYears <- c(0, 1, 3, 8, 20, 30)

citations <- c(0, 
               1,
               8,
               30,
               7784,
               2021)
academics <- data.frame(position, salaryBeforeTaxes, citations, workingYears)

# add gender
academics$gender <- c("M","M","F","M","F","M")


bachelor <- c(1,3,4,4,5,5)
master <- c(1,2,4,5,5,5)
doctor <- c(1,1,1,3,5,5)
noeasy <- c(5,5,3,2,1,5)

thesis.questionnaire <- data.frame(bachelor,master,doctor,noeasy)
thesis.questionnaire$position <- position
thesis.questionnaire

thesis.questionnaire.explanation <- list()
thesis.questionnaire.explanation$bachelor <- "Writing a bachelor's thesis is easy"
thesis.questionnaire.explanation$master <- "Writing a master's thesis is easy"
thesis.questionnaire.explanation$doctor <- "Writing a doctoral thesis is easy"
thesis.questionnaire.explanation$noeasy <- "Writing any academic thesis is difficult"
thesis.questionnaire.explanation$scale <- "1 = Disagree completely, 2 = Disagree somewhat, 3 = Neither disagree or agree, 4 = Agree somewhat, 5 = Agree completely"
thesis.questionnaire.explanation

# AHA! Rector's lying! His answers to the questionnaire instrument are not congruent

academics2 <- cbind(academics,thesis.questionnaire[,1:4])
academics2

