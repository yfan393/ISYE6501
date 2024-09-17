# Load in data set and perform initial exploratory analysis
fifa = read.csv("C:/Users/adria/OneDrive/Desktop/MSA/FirstSem/Intro to Analytics Modelling - ISYE6501/GTA ISYE6501/datasets/fifa.csv",header=TRUE)
ncol(fifa)
colnames(fifa)
summary(fifa)
table(fifa$position)
table(fifa$intl_rep)
prop.table(table(fifa$intl_rep))*100
prop.table(table(fifa$pref_foot))*100
prop.table(table(fifa$position))*100
#Plot boxplots for all variables and analyze
fifa2=data.frame(fifa$overall,fifa$age,fifa$height,fifa$weight,fifa$pace,fifa$dribbling,fifa$shooting,fifa$passing,fifa$defending,fifa$physicality)
round(cor(fifa2),2)

par(mfrow=c(1, 1))
plot(x=fifa$age, fifa$overall)
hist(fifa$overall, freq=FALSE)
lines(density(fifa$physicality), lwd=2, col="blue")
boxplot(fifa$overall, main="P")
#Q
table(fifa$position)
table(fifa$pref_foot)
table(fifa$intl_rep)
boxplot(fifa$overall~fifa$position)


par(mfrow=c(1, 1))
plot(x=fifa$height, fifa$overall)
hist(fifa$overall, freq=FALSE)
lines(density(fifa$overall))
boxplot(fifa$age, main="Age")
boxplot(fifa$overall~fifa$intl_rep)


plot(density(fifa$height), main="Density Plot: Height")
polygon(density(fifa$height), col="red")

plot(density(fifa$weight), main="Density Plot: Weight")
polygon(density(fifa$weight), col="red")

plot(density(fifa$pace), main="Density Plot: Pace")
polygon(density(fifa$pace), col="red")

plot(density(fifa$age), main="Density Plot: Age")
polygon(density(fifa$age), col="red")

#Check whether residuals are approximately normally distributed.
reg <- lm(overall ~ height, data = fifa)
summary(reg)
plot(x = fifa$height, y = fifa$overall)
abline(reg, col = "red")
par(mfrow=c(1, 1))
boxplot(residuals(reg), main="Residuals")
plot(density(residuals(reg)),
     main="Density Plot: Residuals")
polygon(density(residuals(reg)), col="red")
plot(x=residuals(reg), y= fifa$height) #<-residual plot

#Need to do F and t tests for all variables!
#in order to do that; I need the errors to be
#approximately normally distributed

reg2 <- lm(overall ~ age, data = fifa)
summary(reg2)
plot(x = fifa$age, y = fifa$overall)
abline(reg2, col = "red")
par(mfrow=c(1, 1))
boxplot(residuals(reg2), main="Residuals")
plot(density(residuals(reg2)),
     main="Density Plot: Residuals")
polygon(density(residuals(reg2)), col="red")
plot(x=residuals(reg2), y= fifa$age)

reg3 <- lm(overall ~ weight, data = fifa)
summary(reg3)
plot(x = fifa$weight, y = fifa$overall)
abline(reg3, col = "red")
par(mfrow=c(1, 1))
boxplot(residuals(reg3), main="Residuals")
plot(density(residuals(reg3)),
     main="Density Plot: Residuals")
polygon(density(residuals(reg3)), col="red")
plot(x=residuals(reg3), y= fifa$weight)


#Model Building
#p=12 predictor variables
#(2^p)-1=2^12-1 regression models
2^12-1 # (excluding the empty model) - possible regression models

#Forward stepwise regression
library("olsrr")
model = lm(overall~ age + position + height + weight + intl_rep +pace+dribbling+shooting+passing+pref_foot+defending + physicality ,data=fifa)
# ols_step_all_possible(model)

fifa3 <- fifa
fitnull <- lm(overall~ 1 ,data=fifa3)
fitfull <- lm(overall~ age + position + height + weight + intl_rep +pace+dribbling+shooting+passing+pref_foot+defending + physicality ,data=fifa3)
reg10 = step(fitnull, scope=list(lower=fitnull, upper=fitfull), direction="forward")

#All possible regressions
library(leaps)
leaps<-regsubsets( overall~age + position + height + weight + intl_rep +pace+dribbling+shooting+passing+pref_foot+defending + physicality,data=fifa,nbest=10)
summary(leaps)

which.max(summary(leaps)$adjr2)
which.min(summary(leaps)$cp)
which.min(summary(leaps)$bic)

summary(leaps)$which[71,]
#Setting variables to categorical in the dataset
is.factor(fifa3$intl_rep)
fifa3$intl_rep=as.factor(fifa3$intl_rep)

#Qs6
#Interactions
library(car)
reg16=lm(overall~physicality*intl_rep,data=fifa3)
summary(reg16)
reg16=lm(overall~height*intl_rep,data=fifa3)
summary(reg16)


reg12=lm(overall~intl_rep+passing+position+
           dribbling+shooting+physicality+pace
         +age+defending+weight+height+
           intl_rep*height ,data=fifa3)

summary(reg12)

#Multicollinearity can affect standard errors and so hypothesis tests.
library(car)
reg10 = step(fitnull, scope=list(lower=fitnull, upper=fitfull), direction="forward")
summary(reg10)
vif(reg10)

cor.test(fifa3$passing,fifa3$dribbling)


reg14=lm(overall~intl_rep+passing+position
         +physicality
         +pace+shooting+defending
         ,data=fifa3)
vif(reg14)
summary(reg14)

reg15=lm(overall~intl_rep+passing+position
         +physicality
         +pace+shooting
         ,data=fifa3)
vif(reg15)
summary(reg15)

reg16=lm(overall~intl_rep+passing+position
         +physicality
         +pace
         ,data=fifa3)
summary(reg16)
vif(reg16)


plot(reg16)
par(mfrow=c(1,1))
lev = hat(model.matrix(reg16))

plot(lev)
which(lev>0.03)
points(836,lev[836],col='red')
points(837,lev[837],col='green')
points(838,lev[838],col='pink')
points(839,lev[839],col='blue')

cook = cooks.distance(reg16)
which(cook>0.004)
plot(cook,ylab="Cooks distances")
points(1226,cook[1226],col='red')
points(1234,cook[1234],col='blue')
points(1714,cook[1714],col='green')

influencePlot(reg16, main = "Influence Plot", 
              sub = "Leverage vs. Standardized Residuals with Cook's Distance")


