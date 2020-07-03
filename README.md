# State-Factors-and-Race-on-COVID-19-Deaths
This analysis is used to gain a better understanding of the factors affecting the spread of COVID-19. This project explores the effects of 7 explanatory variables on the number of COVID-19 deaths in the United States using multiple linear regression. These 7 variables were chosen as literature on the topic has tended to find that these, and similar variables, were often the most important factors in determining the risk of COVID-19 spread. Additionally, the number of deaths appears to be the most accurate predictor of COVID-19 spread in the United States. Finally, this analysis is also concerned with finding if there is a disproportionate amount of deaths by COVID-19 for minority groups in the United States.

# Background
With COVID-19 currently spreading across the United States, pandemics have taken on a new level of importance. Many countries, including the United States, were underprepared for this event. COVID-19 has not only taken away the lives of far too many individuals; but it has also deeply unsettled the world economy. COVID-19 is the biggest single issue the United States is currently confronting. Knowing how COVID-19 has spread across the United States is then an essential question that needs to be analyzed.

Reports are making it increasingly clear that COVID-19 has been disproportionately affecting minority groups. Minority groups are proportionally more often the ones continuing to work in essential jobs where they are likely to be infected. This paper seeks to look at COVID-19 spread in the United States in two ways. First, this paper seeks to look at what might be the most important factors in the spread of COVID-19. Secondly, this paper will also explore the question of if minority groups are being affected at a greater rate than non-minority groups. More specifically, this paper will be looking at the response variable of COVID-19 deaths as this has generally been deemed to be the most accurate variable in tracking the spread of COVID-19. This paper will explore the question of if COVID-19 deaths can be predicted using, population density, population age, population gender, income, race, politics, and education.

By understanding how these different variables affect the spread of COVID-19 deaths, the United States can take steps at slowing its spread and flattening the curve. Additionally, by gaining a better understanding of how COVID-19 is affecting minority groups more funding can be sent to people who may need greater assistance. The null hypothesis of this study is that there is no relationship between COVID-19 deaths and population density, population age, population gender, income, race, politics, and education. The alternative hypothesis is that there is a relationship between COVID-19 deaths and population density, population age, population gender, income, race, politics, and education.

# Data Sources and Structure
The data set used in this analysis is based on statewide data in the United States. It was compiled between two sources. The first source was The [COVID-19 Tracking Project](https://covidtracking.com/data) and provided COVID-19 deaths in each state. The COVID-19 Tracking Project compiles COVID-19 related data for each state. Because COVID-19 deaths in each state continue to change every day it is important to note that the data used in this analysis was gathered on April 28, 2020. The second source of data was the [United States Census](https://www.census.gov/quickfacts/fact/table/US/INC110218) which provided all the explanatory variables used in this analysis. One potential issue with this data is that the census data was collected between the years 2018 and 2019, so it is not quite up to date. This should be taken into consideration, although it is highly unlikely drastic demographic shifts have taken place in states within this one to two-year difference. Because the data were sampled from April 28, 2020 inference cannot be extended beyond this date as COVID-19 death data is changing daily. The District of Columbia was also removed as an observation given that it was an outlier in nearly every measurement.  The structure of the data can be found in table 1.

Table 1. Data Orginization

State | Deaths | PopDensity | Over65 | Female | White | PersonsHouseHold | BachDegHigher | MedianHouseInc | Gov  
----- | ------ | ---------- | ---------- | ---------- | --------- | ---------------- | ------------- | -------------- | ---
AL | 245 | 94.4 | 16.9% | 51.6% | 65.4% | 2.55 | 24.2% | $48,486 | Rep
AK | 9 | 1.2 | 11.8% | 47.9% | 60.3% | 2.81 | 29.2% | $76,715 | Rep
AZ | 304 | 56.3 | 17.5% | 50.3% | 54.4% | 2.69 | 28.9% | $56,213 | Rep

* State is the state the data was taken from.
* Deaths is the number of deaths attributed to COVID-19.
* PopDensity is the average population of people per square mile. 
* Over65 is the percentage of the population over the age of 65.
* White is the percentage of people who are white, excluding the Hispanic population. 
* PersonsHouseHold is the average number of people that live in a home. 
* BachDegHigher is the percentage of the population who holds a bachelor’s degree or higher.
* MedianHouseInc is the median household income. 
* Gov is a categorical variable that is rep if the governor of the state is republican and dem if the governor of the state is a democrat. 

# Data Exploration
In using multiple linear regression analysis, I first needed to check the normality of the variables used. The standard density plots of each numerical variable used in this analysis can be found below in figure 1. 

Figure 1. Density plots of all numerical variables to be used in this analysis. 
![Density Plots](https://github.com/albertfrantz/State-Factors-and-Race-on-COVID-19-Deaths/blob/master/densityplots1.JPG)

Looking at the density plots found in figure 1 we see that most variables are normally distributed. Both deaths and population density are right-skewed. Not only should these variables be log-transformed based on their density plots but because they also make more sense as multiplicative differences. The density plots of deaths and density after a log transformation had been complete can be found in figure 2. 

Figure 2. Log transformed deaths and PopDensity
![Log-Transformed Density Plots](https://github.com/albertfrantz/State-Factors-and-Race-on-COVID-19-Deaths/blob/master/densityplots2.JPG)

After assessing the normality of my data, I next generated a scatterplot matrix of my response and explanatory variables. In generating this scatterplot matrix, I looked for which explanatory variables may be the best predictors for COVID-19 deaths and if there are any issues of multicollinearity. The scatterplot matrix can be found in figure 3.   

Figure 3. Scatterplot Matrix of Death to all explanatory variables
![SPLOM](https://github.com/albertfrantz/State-Factors-and-Race-on-COVID-19-Deaths/blob/master/splom.JPG)

Looking at the scatterplot matrix, we can see that population density is likely the best predictor of COVID-19 deaths. There also appears to be reasonably strong relationships between COVID-19 deaths and percent female and percent white. Looking for potential multicollinearity between variables the scatterplot matrix brings attention to two potential cases. The first case is between percent white and persons per household. Additionally, bachelor’s degree or higher and median household income also appear to have some multicollinearity present. These variables need to be explored further when creating models. This potential multicollinearity should be considered as we move forward with analysis. 

# Models 
Next, I fit four different models. The models can be found below.

* Model 1: LogDeaths~perWhite
  * Model 1 is a linear regression assessing the relationship between COVID-19 deaths and the percentage of the population in a state that is white. 
  
* Model 2: LogDeaths~LogDensity+percOver65+percWhite+percFemale+ +medianHouseInc +gov 
  * Model 2 is a multiple linear regression that includes all explanatory variables besides the persons per household and bachelor’s degree or higher percentage due to potential multicollinearity between those variables and percentage white and percentage of median household income. 

* Model 3: LogDeaths~LogDensity+percOver65+percFemale+percWhite+personsHousehold+bachDegreeHigherPerc+medianHouseInc+gov 
  * Model 3 is a multiple linear regression that includes all explanatory variables available. 

* Model 4: LogDeaths~LogDensity+percOver65 
+percWhite+personsHousehold+bachDegreeHigherPerc+medianHouseInc+gov 
  * Model 4 is a multiple linear regression that includes all explanatory variables besides the percentage of the population that is female. 
  
To determine the best model to continue with I calculated the AIC scores for each, those values can be found in table 2. After calculating AIC scores, I found that model 4 had the lowest AIC score. For this reason, analysis will continue with model 4. 

Table 2. AIC scores
Model | df | AIC
------------ | ------------- | ----
Model 1 | 3 | 115.95
Model 2 | 8 | 71.49
Model 3 | 10 | 60.61
Model 4 | 9 | 60.25

# Checking Model 4

I next checked model 4’s VIF to determine if multicollinearity was an issue with model 4. I was especially concerned with multicollinearity between the percentage of the population that is white and persons per household and between bachelor’s degree or higher percentage and median household income. In checking the VIF of model 4, I found that all scores were below 3.5 and so there was no issue of multicollinearity present in the model.

Because the model did not have significant multicollinearity I checked if model 4 passes the SVA’s of using multiple linear regression analysis. I first checked the normality of the residuals using a quantile-quantile plot of the model’s residuals. This plot can be found in figure 4. I found that most of the residuals fall within the 95% lines, so it is fair to say that the model has a normal distribution of residuals. 

Figure 4. Quantile-quantile plot of the residuals of model 4. 
![SPLOM](https://github.com/albertfrantz/State-Factors-and-Race-on-COVID-19-Deaths/blob/master/Residuals.JPG)

To check that the model passes the other SVAs, I continued by using a residual versus fitted plot. I checked for both equal variance and a mean equal to zero. This plot can be found in figure 5. Looking at figure 5 we can see that there is consistent variance in each divided section of data, so model 4 passes the equal variance SVA. Model 4 also passes the mean equal to zero SVA with a few exceptions. Both on the lower ends of the plot and the upper ends of the plot there seems to be some deviation away from a mean equal to zero. That being said, most slices of data seem to have a mean equal to zero.  For these reasons, model 4 passes all the SVAs of using multiple linear regression.

Figure 5. Residuals vs. fitted plot

![Residuals vs Fitted](https://github.com/albertfrantz/State-Factors-and-Race-on-COVID-19-Deaths/blob/master/residualsvsfitted.JPG)

# Fitting Model 4
Now that model 4 has passed the SVAs, I fitted model 4 to a multiple linear regression. The fitted model and the associated values can be found below:

**μ [LogDeaths | LogDensity, Over65, White, personsHousehold, bachDegreeHigher, medianHouseInc, gov] = 8.070 + .971*LogDensity -.186*Over65 -.012*White + .048*bachDegreeHigher-1.197*personsHousehold-.0000325*medianHouseInc-.194*I[gov=rep]**

Overall, the model is significant at the 5% level, meaning that we have statistically significant evidence against the null hypothesis that all coefficients are zero (f: 20.22, df: 42, p: 1.417e-11). There is evidence that at least one coefficient is not zero. Additionally, according to the t-tests, all variables except persons per household and governor are significant at the 5% level. Most significant was population density which found that for a 1% increase in population density COVID-19 deaths increase by .971%.  (p: 9.25e -11). The percent over 65 was also highly significant in this model and found that for every additional percent increase in population over 65 COVID-19 deaths decreased by .65 (p: 3.96e-05). Median household income was significant at the .01 level and found that for each additional one thousand dollars in median household income COVID-19 deaths decreased by .0325% (p: .00236). Finally, the percent of the population who is white was also found to be significant at the .05 level. This explanatory variable found that for each additional percentage that a population is white, COVID-19 deaths decrease by .973 (p: .0478). Although persons per household did not fall within the 5% significance range it was close and should not altogether be ignored in the model (p: .0644). Finally, the type of governor a state has was not found to be significant at the 10% level (p: .129). 

# Results
Table 3. Results
Variable | Estimate | Std. Error | t value | p value 
-- | -- | -- | -- | --
Intercept | 8.070 | 2.275 | 3.547 | .0009
logPopDensity | .971 | .113 | 8.565 | 9.25e-11 
over65 | -.186 | .041 | -4.592 | 3.96e-05
White | -.012 | .006 | -2.041 | .048
personsHousehold | -1.197 | .630 | -1.899 | .064
bachDegreeHigher | .048 | .018 | 2.641 | .011
medianHouseInc | -.00003 | .00001 | -3.238 | .002
govRep | -.194 | .125 | -1.55 | .129

# Model Prediction
Going forward with the COVID-19 pandemic, this model was used to predict the number of COVID-19 deaths in a hypothetical state. We gave this hypothetical state a population density of 80 people per square mile, with a population of 17% over the age of 65, 70% being white, and 40% holding a bachelor degree or higher, with 2.5 people per household, and median household income of $50,000. According to this model, the predicted COVID-19 death count for this imaginary state is 1041 on April 28, 202. This appears to be a plausible death count for a state with these listed qualities. Being able to predict a state’s COVID-19 death count is especially important to pandemic response as it can be used to predict where resources should increasingly be sent as the number of cases and deaths expand. 

# Conclusion
I found that there is statistically significant evidence to reject the null hypothesis that all coefficients are zero at the 5% level (f: 20.22, df: 42, p: 1.417e-11). The model found all variables, but persons per household and governor political affiliation to be significant at the 5% level. An especially concerning result of this study found that minority groups are more affected by COVID-19 than white people. The model found that for each additional percentage that a population is white, COVID-19 deaths decrease by .973 (p: .0478). This result lines up with current literature that has found that minority groups are disproportionately being affected by COVID-19. 

Minority groups being disproportionately affected by COVID-19 requires a greater government response. There needs to be a greater urgency in protecting essential workers and that may help reduce the inequality found in COVID-19 deaths.

Because it is not race alone that causes for the disparities in death and is instead factors related to race, this model does not prove causation across all variables. It is possible to determine that population density has a causative relationship to COVID-19 deaths, but other variables like race and governor may only show a correlation to death. 

Looking at the model in a broader view, the R^2 was found to be .77. This means that the model explains 77% of the variability in mean COVID-19 deaths. This is a relatively strong relationship. Given that predicting COVID-19 accurately would require an almost infinite list of variables, it seems that these 7 explanatory variables provided a relatively strong prediction of COVID-19 deaths. 

# Limitations
One major drawback of this model is that inference cannot be extended into the future. Data was collected on April 28, 2020, and as new data is collected on COVID-19 deaths the model will likely dramatically change in the future. Ideally, I believe this model should be repeated each day of the COVID-19 outbreak with the new COVID-19 death numbers. Repeating this model each day as the COVID-19 outbreak progresses could help researchers get a better idea of how the outbreak is changing over time and how these 7 explanatory variables are shifting as time continues. Although it may not be possible to extend inference into the future, this model does two things. First, it provides some initial information on who is being most affected by COVID-19. Second, this model can provide the framework for future research into the COVID-19 pandemic. This pandemic is far from over and hopefully this paper provided information on how to best continue in dealing with the pandemic. 
