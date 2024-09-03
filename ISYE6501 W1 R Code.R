###### Reading in files and basic summary statistics #####
# At the end of this lesson you should be able to:
# Type commands into a script file and launch them to the console
# Save a script file
# Create objects and perform simple mathematical operations
# Create vectors
# Use dedicated R functions to perform more nuanced calculations
# Get help on how to use specific functions

# Change font size -> Tools - Global Options - Appearance - Editor font size
# To change margin line (Can change to 0 to remove line) -> Tools - Global Options - Code - Display - Margin column
# Can use '?' to check the description of a function in R
# Ctrl + Shift + C -> for applying a comment to a block of code
# Alt + - -> to apply a "<-" assignment sign

# Lab summary
# At the end of this lab you should be able to:
# Type commands into a script file and launch them to the console
# Save a script file
# Create objects and perform simple mathematical operations
# Create vectors
# Use dedicated R functions to perform other calculations
# Get help on how to use specific functions

##### Data structures & syntax used in R #####
# Vectors contain elements of the same type, either numeric, logical or character
# Numeric vector: contains numbers 
x <- c(1, 2, 10)
y <- c(3, 7, 4)
x + y
x > y
y[1]
sum(x); mean(x); median(x)
sort(x, decreasing = TRUE) 
unique(x)
length(x)
rep(x, 3)
?rep
seq(from=1, to=10, 2)
c <- c(x, y); c
cbind(x,y)
rbind(x,y)
# Character vector: contains text strings
a <- c("apple", "banana", "cherry")
b <- c("kiwi", "watermelon","pomegranate")
c <- c(a, b); c
cbind(a,b)
rbind(a,b)
# logical vector: contains TRUE or FALSE values
logic <- c(TRUE, FALSE, FALSE) 
logic + 1
logic + 0

# Matrices - two dimensional data structure, each element has the same type, collection of vectors.
mat <- matrix(c(1,2,3,4,5,6), nrow =2, ncol = 3)
mat

# Arrays - similar to a matrix but can how more than 2 dimensions, 3d and 4d, must be of same type. Representing multi-dimensional data.
arr <- array(1:10, dim = c(2,3,2)) # recycles 1:10 to 'fill' all available cells in the array.
arr

# Data Frames - two dimensional structure like a matrix, but it may contain different types of data in each column.
# Each column is a vector which can contain different types of data. 
# Most commonly used data structure in R.
# Table of data
df <- data.frame(Name = c("Amy", "Brian"),
                 Age = c(30, 35),
                 Job = c("Accountant", "Consultant"),
                 IsMarried = c(TRUE, FALSE)
)
df

# Lists - flexible data structure which can contain elements of different types and structures including lists, vectors, matrices and data frames.
# Used for storing complex data. Not used often for initial analysis in R. 
# But can be used to work with outputs from statistical models or combine various types of data structures
l <- list(Name = "Amy", Age = 30, Job = "Accountant", IsMarried=TRUE, IsMarriedPredicted=FALSE); l

##### Previous TA's Code #####
# MSA Tutoring - R Intro class
# Primary Author: Mariana de Almeida Costa
# Some sections (code or comments) amended by Adrian Kukla

getwd()
# setwd("~/R Projects") # can use this to set directory. ~ means that the path will start from my local directory
rm(list=ls()) # clears the list of objects in the global environment where /data sets/variables are stored
#CRTL+ L = clears the console
#CRTL + Enter = run line of code one by one
?matrix #open help in matrix function page
help("matrix") #open help in matrix function page

#### Part 1 - Quick review on matrices
matrix1 <- matrix(c(2, 4, 3, 1, 5, 7), nrow=3, ncol=2)  # create and STORE matrix as matrix1
matrix1 #display matrix1 (see console)
matrix2 <- matrix(0, nrow=3, ncol=2) # create and STORE matrix as matrix2
matrix2 #display matrix2 (see console)
matrix3 <- matrix(seq(from=1, to=9, by=1), nrow=3, ncol=3) # create and STORE matrix as matrix3
matrix3 #display matrix2 (see console)
matrix(1,3,2) #display a matrix... arguments can be omitted, but order must be respected
y <- c(2,3,4) 
str(y) # displays strcture of an R object
y <- as.vector(y, mode="numeric")
x1 <- c(1,2,3)
x2 <- c(6,7,8)
x <- rbind(x1,x2) # merge by row = horizontally
x
x <- cbind(x1,x2) # merge by column = vertically
x
y%*%x # notice that %*% is used for matrix multiplication and * for element-wise
?t #get help on function t... could also write help("t")
y%*%t(x) #cannot multiply = error: non-conformable arguments because y is 3x1 and x^T is 2x3
y*t(x) #element wise multiplication
t(x)*y # (2x3) by (1x3)
x*y 
matrix4 = diag(1/3,nrow=3,ncol=3) # 3x3 identity matrix (could have used eye function too)
matrix4
solve(matrix4) # solves for the inverse of the matrix

#selecting cells/rows/columns in matrices based on indexes
matrix3[1,1] #select cell on row 1, column 1
matrix3[1,] #select row 1, all columns
matrix3[,1] #select all rows, column 1
matrix3[2:3,1:3] #select rows 2 to 3, columns 1 to 3
matrix3[c(1,3),c(1,3)] #select all cells in rows 1 and 3 and columns 1 and 3
matrix3[-c(1,3),-c(1,3)] #select the complement to the above
matrix3[-1,] #select all rows except for the first one



#### Part 2 - SVM application example
rm(list=ls()) #clear the environment
#CRTL+ L = clears the console

# The dataset Iris is available in R, so you might just call it using the function data as below
data("iris")
# alternatively, you can download the dataset at https://archive.ics.uci.edu/ml/datasets/iris
# enter Download: source of data, then right click at iris.data (Save link as...)
# and proceed with the command to read the file... remember that you must save in your wd
# iris<-read.table("iris.data",header = FALSE, sep=",")
# if the above command did not work, it's probably because
# the dataset was not saved in your Working Directory
# you can manually browse it by adding the function file.choose() as below
# iris<-read.table(file.choose(),header = FALSE, sep=",") 

#let's proceed using data function
iris 
# install.packages("e1071") #you just need to run this once.. that's how you install packages in R
library(e1071) #after installing, that's how you load you package... must do this everytime you restart R

# some useful commands when your dataset is too big
head(iris) #see first 6 rows
tail(iris) #see last 6 rows
colnames(iris) 
data <- iris #create a copy... let's work on that and leave iris as a backup file
data[!complete.cases(data),] #list rows of data that have missing values, "!" indicates a logical notation NOT
# no missing values in this case
summary(data)  # get basic descriptive statistics
# package DoBy has the function summaryBy()
# install.packages("doBy")
library(doBy)
# You can write new functions in R using the function method.
# This function calculates summary statistics of the one argument 'x' in parantheses and manipulations done within curly brackets.
myfun <- function(x){c(mean=mean(x), var=var(x), sd=sd(x), min=min(x), max=max(x), 
                       length=length(x))} #name the statistics you want to get
# summaryBy function calculates summary statistics for the variable 'Petal.Length' for different levels of the 'Species' categorical variable.
# FUN is an argument which specifies the list of functions to be applied.
summaryBy(Petal.Length ~ Species , data = data, FUN = myfun)

#when you just want to apply known functions you don't need to create a function like myfun above.
summaryBy(Petal.Length ~ Species , data = data,FUN= mean) 
colnames(data)[5] <- "Class" #rename Species to Class
colnames(data)
dev.new() # (use this function if you want to plot in a new window, if now, it's gonna appear in Plots right on the side)
par(mfrow=c(2,2)) # separate the window in 4 squares for plotting purposes
# dev.off()

# attach(data)  #if it works, you don't need to include data$, you can just call the variable
# plot(Sepal.Length, Sepal.Width, col=Class)
# detach(data)
str(data)  # to check how the variables are stored (numeric, integer, factor, etc.)
#plots
plot(data$Sepal.Length, data$Sepal.Width, col=data$Class) 
plot(data$Petal.Length, data$Petal.Width, col=data$Class) 
plot(data$Sepal.Length, data$Petal.Length, col=data$Class) 
plot(data$Sepal.Width, data$Petal.Width, col=data$Class)
par(mfrow=c(1,1))
levels(data$Class)  #check the possibilities for the Class variable (3 species in this case)
#creating new subset (we just want to run SVM in the 3 variables below)
Class <- as.factor(data$Class)
Petal.Width <- as.vector(data$Petal.Width)
Petal.Length <- as.vector(data$Petal.Length)
newdata <- data.frame(Class,Petal.Length,Petal.Width) #SVM will only work with dataframes
str(newdata) #SVM requires one variable as factor
plot(data$Petal.Length, data$Petal.Width, col=data$Class, pch=19)
legend("topleft", legend=levels(data$Class), col=1:3, pch=19)

# the plot is very simple... let's say we want more sophisticated ones
# install.packages("ggplot2") # widely used package in R for plotting graphs from the tidyverse library created by Wickham and Grolemund
library(ggplot2)
ggplot(newdata,aes(x=Petal.Width, y = Petal.Length)) + 
  geom_point(aes(colour = Class)) + 
  ggtitle("Scatterplot by Species")
# ggplot() initializes the ggplot object
# aes assigns the aesthetic mappings used to construct the graphs, but to plot the points require geom_point()
# geom_point adds a scatter plot layer to the ggplot object by plotting individual data points on a graph
# ggplot is very flexible, please Google: ggplot cheat sheet to explore more options.

ggplot(newdata,aes(x=Petal.Width, y = Petal.Length, colour = Class)) + 
  geom_point() + 
  ggtitle("Scatterplot by Species")

?ggplot

# Here we are using the e1071 package instead of the kernlab package that is required for the homeworks.
# The kernlab package is specifically created for kernel based machine learning methods which focuses on functions using kernels.
# Kernels provide a way to handle non-linear decision boundaries using the kernel trick.
# Kernel trick allows the user to perform operations like the dot product to high dimensional data sets so that one can map
# the original data set in a high dimensional space where a linear separation is possible.
# Here we get an understanding of what an SVM does by using the more straightforward package e1071.
# Applying SVM to the full model
# The point after ~ indicates that all other variables are gonna be included.
# Class is the y variable (response), Petal.Length and Petal.Width are the x variables (covariates, factors, independent variables)
svm_full <- svm(Class ~ ., data=newdata, kernel="linear", cost=1, scale=TRUE) # we scale the data as Joel mentioned in his videos.
print(svm_full)
# The linear kernel is the starting point to use before moving onto more sophisticated kernel types.
# Cost parameter balances the trade-off between a larger margin and fewer misclassifications. A cost of 1 is typical starting point.
# Which applies a balanced/moderate constraint penalty between maximizing the margin and minimizing the classification error.
# A margin is the distance between the decision boundary (another name for a hyperplane)
# and the closest data points (support vectors) from either class.
# C-classification means that the SVM is a classification machine. Can also be a regression machine or used for novelty detection
# Number of support vectors means that 31 data points were used as support vectors which are most influential in finding the decision boundary.
par(mfrow=c(1,1))
plot(svm_full, newdata) # the plot function is versatile in R and it accomodates to whatever type of model or data we use as parameters.

plot(Petal.Width, Petal.Length, col = Class, 
     pch = c("o","+")[1:150 %in% svm_full$index + 1], cex = 1, 
     xlab = "Petal Length", ylab = "Petal Width") # the + are support vectors
legend("topleft",legend=levels(Class), col=c("black","red","green"),
       lty=c(1,1,1),cex = 0.75)

# Explanation of plot code:
# The x %in% y operator checks whether an element in x is contained in y and returns a logical operator TRUE or FALSE
# "1:150 %in% svm_full$index" - returns the indices of your support vectors 
# i.e., (the positions of them in the 150 length vector)
# pch will assign the symbol '+ ' to the indexes with number 2 (support vectors)  and 'o'
# to the indexes with number 1. Since we have 150 observations, we need to use 1:150 so that
# the code will add 1 to the indices revealed by svm_full$index,
# making then equal to 2 and receiving a different symbol ('+').

plot(Petal.Length, Petal.Width, col = Class,
     xlab = "Petal Length", ylab = "Petal Width", cex = 1)
legend("topleft",legend=levels(Class), col=c("black","red","green"),
       lty=c(1,1,1), cex = 0.75)

#prediction for full model
p_fullmodel <- predict(svm_full, newdata) # predict function fits the model to a data set to predict the response variable 'Class'
p_fullmodel
table(p_fullmodel, newdata[,1]) # plot the table of labels, where rows are the predicted values and columns are the actual.
round(mean(p_fullmodel==newdata[,1]),2) # prediction accuracy - number between 0 and 1, closer to 1 means better prediction.
# If the models predicts correctly the equation above returns TRUE, which R code treats as a 1, and FALSE as a 0.

# what's wrong with the above prediction?
# it's biased: we used the same data to construct the model and to predict
# how to overcome this ? We might want to partition the dataset into training/testing data
# please have in mind that this is only an introduction, for ISYE6501
# you will learn more effective ways of partitioning and doing cross-validation as well.

set.seed(1) # Set Random Number Generator to get reproducible results, it sets the starting point for sequence of random numbers.
# There is a video on Khan Academy type on pseudo random number generators. Note that this only ensures reproducibility for same R session but
# behavior may differ across different versions of R or different systems.
s = sample(1:150,135) #taking a 'pseudo - random' sample of 135 numbers from 1:150 without replacement
# what this does is to randomly select 135 rows (from the 150 in dataset) to be training data
col <- c("Petal.Length", "Petal.Width","Class") #we create the set with the names of the columns of the training set
training_set <- newdata[s,col] #training set has 135 observations coming from random sample
str(training_set) #just to make sure nothing has changed
reduced_svm <- svm(Class ~., data=training_set, kernel="linear", cost=1, scale=TRUE)
print(reduced_svm) # notice that the number of support vectors varies according to the sample. Changed from 31 to 29.
plot(reduced_svm, training_set)
test_set <- newdata[-s,col] #test set has 150-135 = 15 observations
# the - sign in front of s means, that we are taking the complement of rows of set s
str(test_set)
#prediction: use training set to build the model and test set to predict
p_reducedmodel <- predict(reduced_svm, test_set)
table(p_reducedmodel,test_set[,3])
round(mean(p_reducedmodel==test_set[,3]),2)

# the package also offers a function to tune best cost parameter through Cross-validation
# this is usually done first (before prediction), we're only seeing afterwards for learning purposes
tune_linear <- tune(svm,Class ~ ., data=training_set, kernel="linear", 
                    ranges=list(cost=c(0.001, 0.01, .1, 1, 10, 100)))
options(scipen = 999)
summary(tune_linear)
options(scipen = 0)
bestmodel <- tune_linear$best.model
summary(bestmodel)
tune_linear$best.parameters  #returns cost
#analyzing again with best cost parameter
new_reduced_svm <- svm(Class ~., data=training_set, kernel="linear", 
                       cost=tune_linear$best.parameters, scale=TRUE)
round(tune_linear$best.performance,2) #returns error
plot(tune_linear, main="SVM - Crossvalidation - C parameter")
plot(new_reduced_svm, training_set)
#prediction again with best cost parameter
new_p_reducedmodel=predict(new_reduced_svm, test_set, type="class") 
table(new_p_reducedmodel, test_set[,3]) 
round(mean(new_p_reducedmodel==test_set[,3]),2)
# In this particular scenario because the data is 'well behaved', the choice of the cost parameter is not material
# With more complex data sets to model with higher number of dimensions, the choice of cost parameter won't be trivial.