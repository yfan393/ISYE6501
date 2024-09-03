# Load the mtcars dataset
data(mtcars)

# Consider the 'mpg' (miles per gallon) as a random variable
random_variable <- mtcars$mpg
random_variable
# Expected value (mean) of the random variable 'mpg'
# The expected value is the mean of a random variable, representing its average outcome over many trials.
expected_value <- mean(random_variable)
expected_value
# Here, mpg is a random variable representing the miles per gallon of cars in the dataset. 
# The expected value is the average miles per gallon across all cars in the dataset.

# Variance of the random variable 'mpg'
variance <- var(random_variable)
variance
# The variance tells us how much the mpg values differ from the average mpg in the dataset.

# 95% Confidence interval for the mean of 'mpg'
# A confidence interval provides a range of values within which we expect the true population parameter (e.g., the mean)
# to lie with a certain level of confidence (e.g., 95%).
confidence_interval <- t.test(random_variable)$conf.int
confidence_interval
# This code calculates a 95% confidence interval for the mean mpg. The true mean mpg of the population is expected to fall
# within this interval 95% of the time.

# Hypothesis test: Is the mean mpg equal to 20?
# A hypothesis test evaluates a claim about a population parameter. The p-value indicates the probability of obtaining
# the observed data, or something more extreme, assuming the null hypothesis is true.
t_test <- t.test(random_variable, mu = 20)
t_test
# This code tests the null hypothesis that the mean mpg is 20. The p-value tells us how likely it is to observe the data
# if the true mean is indeed 20.

##### Six Nations Data Set - Hypothesis Testing and Confidence Intervals #####
# At the end of this lesson you should be able to:
#   Input data from a CSV file in R
#   Access the columns of a data set
#   Use conditional indexing for selection of specific subsets of the data
#   Use t.test() function for testing hypothesis and construct confidence intervals

# Set the file path, can also read in the data set using "Import Dataset" functionality
sixnations <- read.csv("C:/Users/adria/OneDrive/Desktop/MSA/FirstSem/Intro to Analytics Modelling - ISYE6501/GTA ISYE6501/datasets/sixnations.csv",header=TRUE)
str(sixnations)
#Hypothesis Testing
bmi_irel <- sixnations$BMI[sixnations$Team == "England"]
m <- mean(bmi_irel)
s <- sd(bmi_irel)
se <- s/sqrt(length(bmi_irel))
t.test(bmi_irel, alternative = "greater", mu = 28.5, conf.level = 0.95)
t <- (m - 28.5)/se
round(t,4)
p_value <- pt(t, length(bmi_irel)-1, lower.tail = FALSE)
round(p_value,5)
quantile <- qt(0.95,length(bmi_irel)-1,lower.tail = FALSE)
conf_inf <- se*quantile+m
conf_inf
m

t.test(bmi_irel, alternative = "two.sided", mu = 28.5, conf.level = 0.95)
round(t,4)
p_value <- 2* pt(t, length(bmi_irel)-1, lower.tail = FALSE)
round(p_value,5)
quantile <- qt(0.025,length(bmi_irel)-1,lower.tail = TRUE)
conf_inf_lower <- se*quantile+m
conf_inf_lower
quantile <- qt(0.975,length(bmi_irel)-1,lower.tail = TRUE)
conf_inf_upper <- se*quantile+m
conf_inf_upper
m

# In the output we have the value of the test statistic t, the degrees of freedom df and the
# corresponding p-value. The sample mean is reported under mean of x. By default the
# function also computes a 95% confidence interval, but the upper bound has infinite value, because we only computed a one-tailed test
# When we perform a two-tailed test, R returns both limits of the confidence interval.
# Notice that R didn't return the critical value. Therefore, the decision to either reject or not the null hypothesis is based on the p-value for a
# pre-specified significance level.
# Note that t.test function can also be used for z tests, for larger sample sizes the two tests tend to coincide
# T tests used when sample size is small (less than 30), or when the population variance is unknown.
# Both tests assume a normal distribution

# Setting a BMI object
bmi_irel <- sixnations$BMI[sixnations$Team == "Ireland"]
bmi_ita <- sixnations$BMI[sixnations$Team == "Italy"]

# Performing a t test on two samples to check whether the BMI of Irish players is greater than the mean BMI of italian players.
# We set variance to TRUE which means that we assume that the two population variances are equal.
# H_0: mu_irel - mu_ita = 0 / H_A: mu_irel - mu_ita > 0
t.test(bmi_irel, bmi_ita, alternative = "greater", mu = 0, var.equal = TRUE, conf.level = 0.95)
#Confidence intervals are constructed as before, by performing a two-tailed test and specifying the confidence level.
# H_0: mu_irel - mu_ita = 0 / H_A: mu_irel - mu_ita != 0
t.test(bmi_irel, bmi_ita, alternative = "two.sided", mu = 0, var.equal = TRUE, conf.level = 0.95)
