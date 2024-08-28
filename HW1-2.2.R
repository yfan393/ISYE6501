# Assignment: HM1 
# Students (name, GT id):
#          Yuanting Fan, 904047984
#          Wenjia Hu, 904057780
#          Sen Yang, 904025995


# install and read the kernlab
install.packages("kernlab")
library(kernlab)

#import data
#credit_card_data <- read.delim("E:/OneDrive/Courses/ISYE 6501/HW1/credit_card_data.txt", header=FALSE)
attach(credit_card_data)
data <- as.data.frame(credit_card_data)

# ------------------------------------QUESTION 1 -----------------------------------------
# Question 1: core coding
# define the range of C

knn_pred <- matrix()

# we need an empty data to store the various K values, and corresponding accuracy ratio for the plot

accuracy_svm<- data.frame(
  Column1 = numeric(),
  Column2 = numeric(),
  stringsAsFactors = FALSE
)

j=0

C_values <- c(0.001,0.01,0.1,1,50,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800,850,900,950,1000)

# loop for test the best C that has best performance
for (i in seq_along(C_values)) {
  C_value=C_values[i]
 
  # call ksvm.  Vanilladot is a simple linear kernel.
  model <- ksvm(as.matrix(data[, 1:10]), as.factor(data[, 11]), 
                type = "C-svc", kernel = "vanilladot", 
                C = C_value, scaled = TRUE)
  
  # see what the model predicts
  pred <- predict(model, data[, 1:10])
  
  j=j+1
  
  accuracy_svm[j,"Column1"] <- C_value
  accuracy_svm[j,"Column2"] <- sum(pred == data[, 11]) / nrow(data)

}

# data visualization
plot(accuracy_svm$Column1, accuracy_svm$Column2, main = "Plot of C value vs prediction accuracy", xlab = "C value", ylab = "prediction accuracy")

max_cvalue <- accuracy_svm[which.max(accuracy_svm$Column2),]

# calculate a1…am

model <- ksvm(as.matrix(data[, 1:10]), as.factor(data[, 11]), 
              type = "C-svc", kernel = "vanilladot", 
              C = max_cvalue, scaled = TRUE)

a <- colSums(model@xmatrix[[1]] * model@coef[[1]])

# calculate a0
a0 <- -model@b

#------------------------------------------------------------------------------------------------------------------
# Question 1-extra: reducing variables

data <- as.data.frame(credit_card_data)

accuracy_svm_reduced<- data.frame(
  Column1 = numeric(),
  Column2 = numeric(),
  stringsAsFactors = FALSE
)

C_values <- c(0.001,0.01,0.1,1,50,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800,850,900,950,1000)

df <- data.frame(column1 = data[,5], column2 = data[,10])

# loop for test the best C that has best performance
accuracy_svm_reduced <- accuracy_svm_reduced[0, ]

j=0

for (i in seq_along(C_values)) {
  C_value=C_values[i]

  # call ksvm.  Vanilladot is a simple linear kernel.
  model_reduced <- ksvm(as.matrix(df[,1:2]), as.factor(data[, 11]), 
                type = "C-svc", kernel = "vanilladot", 
                C = C_value, scaled = TRUE)
  
  # see what the model predicts
  pred <- predict(model_reduced, df[,1:2])
  
  j=j+1
  
  accuracy_svm_reduced[j,"Column1"] <- C_value
  accuracy_svm_reduced[j,"Column2"] <- sum(pred == data[, 11]) / nrow(data)
  
}

# data visualization
plot(accuracy_svm_reduced$Column1, accuracy_svm_reduced$Column2, main = "Plot of C value vs prediction accuracy after reducing dimensions", xlab = "C value", ylab = "prediction accuracy")

max_accuracy <- max(accuracy_svm_reduced$Column2)
max_cvalue_reduced <- accuracy_svm_reduced[which.max(accuracy_svm_reduced$Column2),]




# ------------------------------------QUESTION 2 -----------------------------------------
# define the range of C

accuracy_svm_nonlinear<- data.frame(
  Column1 = numeric(),
  Column2 = numeric(),
  stringsAsFactors = FALSE
)

C_values <- c(0.001,0.01,0.1,1,50,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800,850,900,950,1000)


# loop for test the best C that has best performance

j=0
for (i in seq_along(C_values)) {
  C_value=C_values[i]
  
  # call ksvm.  Vanilladot is a simple linear kernel.
  model_nonlinear <- ksvm(as.matrix(data[, 1:10]), as.factor(data[, 11]), 
                type = "C-svc", kernel="polydot",
                kpar = list(degree = 3), 
                C = C_value, scaled = TRUE)
  
  # see what the model predicts
  pred <- predict(model_nonlinear, data[, 1:10])
  
  j=j+1
  accuracy_svm_nonlinear[j,"Column1"] <- C_value
  accuracy_svm_nonlinear[j,"Column2"] <- sum(pred == data[, 11]) / nrow(data)
  
}

# data visualization
plot(accuracy_svm_nonlinear$Column1, accuracy_svm_nonlinear$Column2, main = "Plot of C value vs prediction accuracy using non linear SVM", xlab = "C value", ylab = "prediction accuracy")

max_cvalue <- accuracy_svm_nonlinear[which.max(accuracy_svm_nonlinear$Column2),]

# calculate a1…am

model_nonlinear <- ksvm(as.matrix(data[, 1:10]), as.factor(data[, 11]), 
                        type = "C-svc", kernel="polydot",
                        kpar = list(degree = 3), 
                        C = max_cvalue, scaled = TRUE)

a <- colSums(model_nonlinear@xmatrix[[1]] * model_nonlinear@coef[[1]])
a
# calculate a0
a0 <- -model_nonlinear@b
a0


# ------------------------------------QUESTION 3 -----------------------------------------

# install the packages and load the library
install.packages("kknn")
library(kknn)

data <- as.data.frame(credit_card_data)

knn_pred <- matrix()

# we need an empty data to store the various K values, and corresponding accuracy ratio for the plot

accuracy_knn<- data.frame(
  Column1 = numeric(),
  Column2 = numeric(),
  stringsAsFactors = FALSE
)

# we run two loops, the outer loop runs for different K values, and the inner loop runs for the each data point

for (k_value in 1:100){
  
  for (i in 1:nrow(data)){
    
    # use response for all but the ith data point as target response, predictors for all but the ith data point as training data, and ith data point as test data.
    
    knn_model=kknn(data[-i,11]~.,train=data[-i,1:10],test=data[i,1:10],
                   k=k_value, distance=2, scale = TRUE)
    
    knn_pred[i] <- round(fitted(knn_model))== data[i,11]
  }
  
  accuracy_knn[k_value,"Column1"] <- k_value
  accuracy_knn[k_value,"Column2"] <- sum(knn_pred) / nrow(data)
}

plot(accuracy_knn$Column1, accuracy_knn$Column2, main = "Plot of K value vs prediction accuracy", xlab = "K value", ylab = "prediction accuracy")

# find the maximum accuracy ratio and corresponding K values.

max_kvalue <- accuracy_knn[which.max(accuracy_knn$Column2),]

