#########################################################################################
# Author: Albert Frantz
# Date: May 8, 2020
#
# Questions: Can COVID-19 deaths be accurately modeled in the United States?
#            Are minority groups disproportionately being affected by COVID-19?
# 
# Purpose: The purpose of this analysis is to study the factors of COVID-19 spread
#          in the United States. In doing so we can begin to see where to focus
#          resources in helping communities likely to be affected most greatly
#          by the pandemic. 
#
# Method: I Will be using a multiple linear regression analysis to assess how 7
#         explanatory variables effect the number of COVID-19 deaths in the US.
#
# Data: COVID data comes from the COVID Tracking Project and all explanatory variables
#       come from US census data. Data obtained on May 1, 2020.
# 
# Data file: 
#       https://drive.google.com/file/d/1nm08RLcGfUQCrWCBrbgSNI8zRwAZBo0m/view?usp=sharing
##########################################################################################

#############################
#importing libraries and data
#############################

library(stargazer)
covid = read.csv(file.choose())
head(covid)
options(scipen=5) #getting rid of scientific notation 


###################
#exploring the data
###################

#################################################################
#Density plots that require log transforms (deaths and popDensity)
#################################################################

#deaths
lattice::densityplot(~deaths, data=covid)
#log transofmed density plot
lattice::densityplot(~log(deaths), data=covid)
#creating a new log transformed variable of deaths
covid = transform(covid, logDeaths = log(deaths,base = 10))

#popPerSqMi
lattice::densityplot(~popPerSqMi, data=covid)
#log transformed density plot
lattice::densityplot(~log(popPerSqMi), data=covid)
#creating a new log transformed variable of population density
covid = transform(covid, logDensity = log(popPerSqMi,base = 10))

########################################
#Density plots that were already normal
########################################

#Density plot of percent over 65
lattice::densityplot(~percOver65, data=covid)
#Density plot of percent female
lattice::densityplot(~percFemale, data=covid)
#Density plot of percent white
lattice::densityplot(~percWhite, data=covid)
#Density plot of people per household
lattice::densityplot(~personsHousehold, data=covid)
#Density plot of percent of people with bach degree or higher
lattice::densityplot(~bachDegreeHigherPerc, data=covid)
#Denstiy plot of median household income
lattice::densityplot(~medianHouseInc, data=covid)


####################################################################
#Creating a new dataset and visualizing it with a scatterplot matrix
#####################################################################

#subsetting data to include new log transformed variables and variables to be used
covidSubsetForTable = subset(covid, select = c(ï..state, 
                                                deaths, 
                                                popPerSqMi, 
                                                percOver65, 
                                                percFemale, 
                                                percWhite, 
                                                personsHousehold, 
                                                bachDegreeHigherPerc, 
                                                medianHouseInc,
                                                gov))
head(covidSubsetForTable) #checking the new dataset

covidSubset = subset(covid, select = c(logDeaths, 
                                       logDensity, 
                                       percOver65, 
                                       percFemale, 
                                       percWhite, 
                                       personsHousehold, 
                                       bachDegreeHigherPerc, 
                                       medianHouseInc,
                                       gov))
head(covidSubset)

#created a scatterplot matrix
lattice::splom(covidSubset)

####################
#model creation
####################

#model 1 looking at deaths to percentage white
covidModel1 = lm(logDeaths~percWhite, covid)
summary(covidModel1)

#model 2 all variables but persons per house and bach degree
covidModel2 = lm(logDeaths~logDensity+
                 +percOver65
                 +percWhite
                 +percFemale
                 +medianHouseInc
                 +gov, covid)
summary(covidModel2)
car::vif(covidModel2) #checking multicollinearity

#model 3 including all variables
covidModel3 = lm(logDeaths~logDensity
                 +percOver65
                 +percFemale
                 +percWhite
                 +personsHousehold
                 +bachDegreeHigherPerc
                 +medianHouseInc
                 +gov, covid)
summary(covidModel3)
car::vif(covidModel3) #checking multicollinearity

#model 4: all variables except percent female
covidModel4 = lm(logDeaths~logDensity
                 +percOver65
                 +percWhite
                 +personsHousehold
                 +bachDegreeHigherPerc
                 +medianHouseInc+gov, covid)
summary(covidModel4)
car::vif(covidModel4) #checking multicollinearity

########################
#Choosing the best model
########################

#comparing all four covid models using AIC score
AIC(covidModel1, covidModel2, covidModel3, covidModel4)

##########################
#Checking SVAs of model 4
##########################

#quantile-quantile plot
car::qqPlot(rstandard(covidModel4))
#fitted versus residuals plot
lattice::xyplot(rstandard(covidModel4)~fitted(covidModel4))
#model passes all SVAs

############################################
#Predicing an imaginary state using model 4
############################################

predict(covidModel4, newdata = data.frame(logDensity=log(80,base = 10),
                                          percOver65 = 17,
                                          percWhite = 70, 
                                          personsHousehold = 2.5, 
                                          bachDegreeHigherPerc = 40, 
                                          medianHouseInc= 50000, 
                                          gov="rep"))

