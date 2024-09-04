# Assignment: HM2
# Students (name, GT id):
#          Yuanting Fan, 904047984
#          Wenjia Hu, 904057780
#          Sen Yang, 904025995


#import library
install.packages("dplyr")
library(dplyr)
install.packages("kernlab")
library(kernlab)
install.packages("kknn")
library(kknn)
install.packages("caret")
library(caret)


# ------------------------------------QUESTION 3.1(a) -----------------------------------------

#read data
credit_dataset <- credit_card_data.headers
credit_predictors = as.matrix(credit_dataset[,1:10]) 
credit_response = as.factor(credit_dataset[,11])


#1st, we use knn to do 10-folds cross-validation 
#Step1: set the range of k value(from 1 to 50)
correct_rate_list_byknn = rep(0,50) 
#Step2: loop k to run every knn model's cross-validation(with a generally used folds as 10)
for (k_values in 1:50){
  result_byknn <- rep(0,(nrow(credit_dataset)))
  model_knn = cv.kknn(R1~., credit_dataset, kcv = 10, k = k_values, scale = TRUE)
  result_byknn = round(data.frame(model_knn)[,2])
  correct_rate_list_byknn[k_values] = sum(result_byknn == credit_response) / nrow(credit_dataset)
}
best_correct_rate = max(correct_rate_list_byknn)

plot(correct_rate_list_byknn, xlab = 'K value',ylab = 'predication accuracy',
     main = 'KNN with different k values using 10-folds cross validation')

print(best_correct_rate) 
print(which.max(correct_rate_list_byknn))

#2nd, we use svm to do 10-folds cross-validation
# Step 1: generate random ID for each data point in order to divide them into 10 subsets afterwards.
set.seed(123)
credit_dataset$ID <- runif(nrow(credit_dataset),min=0,max=1)
accuracy_svm <- data.frame(c_value = numeric(), vali_accuracy = numeric()) # Initialize

k=0
for (j in seq(0.5,30,5)) {
  accuracy=0
  for (i in 1:10) {
    vali_data <-subset(credit_dataset, ID > 0.1*(i-1) & ID <= 0.1*i)
    train_data <- anti_join(credit_dataset, vali_data)
    
    model <- ksvm(as.matrix(train_data[, 1:10]), as.factor(train_data[, 11]), 
                  type = "C-svc", kernel = "vanilladot",
                  C = j, scaled = TRUE)
    pred <- predict(model, vali_data[, 1:10])
    accuracy=accuracy+sum(pred == vali_data[, 11]) / nrow(vali_data)
  }
  k=k+1
  avg_accuracy=accuracy/10
  accuracy_svm[k,"c_value"] <- j
  accuracy_svm[k,"vali_accuracy"] <- avg_accuracy
}

best_mean_correct_rate = max(accuracy_svm$vali_accuracy)
plot(accuracy_svm, xlab = 'c value',ylab = 'predication accuracy',
     main = 'SVM with different C using 10-fold cross validation')

print(best_mean_correct_rate)
print(which.max(accuracy_svm$vali_accuracy))

#___________________________________Question3.1(b)____________________________________

#1st, we split the data into training(70%), validation(15%), and test(15%) data sets, and use knn to find a good classifier

#Step1: split the datasets
accuracy_knn <- data.frame(k_value = numeric(), vali_accuracy = numeric()) # Initialize
train_data_knn <- subset(credit_dataset,  ID <= 0.7)
vali_data_knn <-subset(credit_dataset, ID > 0.7 & ID <= 0.85)
test_data_knn <-subset(credit_dataset, ID > 0.85)

#Step2: we use trainning set to fix the model and use validation set to choose the best model(k_value) 

for (k_value in 1:50){
  knn_model  <- kknn(train_data_knn[,11]~.,train_data_knn[,1:10],vali_data_knn[,1:10],
                     k=k_value, distance=2, scale = TRUE)
  
  pred <- round(fitted(knn_model))== vali_data_knn[,11]
  accuracy=sum(pred == vali_data_knn[, 11]) / nrow(vali_data_knn)

accuracy_knn[k_value,"k_value"] <- k_value
accuracy_knn[k_value,"vali_accuracy"] <- accuracy
}

plot(accuracy_knn, xlab = 'k value',ylab = 'predication accuracy',
     main = 'KNN with different K using 70% training data, 15% validation data')

print(max(accuracy_knn$vali_accuracy))
print(which.max(accuracy_knn$vali_accuracy))

#Step3: we use test set to test the performance of the chosen model
model_knn_test <- kknn(train_data_knn[,11]~.,train_data_knn[,1:10],test_data_knn[,1:10],
                       k=13, distance=2, scale = TRUE)

pred <- round(fitted(model_knn_test))== test_data_knn[,11]
test_accuracy <- sum(pred == test_data_knn[, 11]) / nrow(test_data_knn)
print(test_accuracy)

#2nd, we use the same three data sets to run SVM models.
accuracy_svm <- data.frame(c_value = numeric(), vali_accuracy = numeric()) # Initialize
train_data_svm <- subset(credit_dataset,  ID <= 0.7)
vali_data_svm <-subset(credit_dataset, ID > 0.7 & ID <= 0.85)
test_data_svm <-subset(credit_dataset, ID > 0.85)

k=0
for (j in seq(0.5,30,5)) {
  accuracy=0
    model <- ksvm(as.matrix(train_data_svm[, 1:10]), as.factor(train_data_svm[, 11]), 
                  type = "C-svc", kernel = "vanilladot",
                  C = j, scaled = TRUE)
    pred <- predict(model, vali_data_svm[, 1:10])
    accuracy=sum(pred == vali_data_svm[, 11]) / nrow(vali_data_svm)
  k=k+1
  accuracy_svm[k,"c_value"] <- j
  accuracy_svm[k,"vali_accuracy"] <- accuracy
}


plot(accuracy_svm, xlab = 'c value',ylab = 'predication accuracy',
     main = 'SVM with different C using 70% training data, 15% validation data')

print(max(accuracy_svm$vali_accuracy))
print(which.max(accuracy_svm$vali_accuracy))

#Step3: we use test set to test the performance of the chosen model
model <- ksvm(as.matrix(test_data_svm[, 1:10]), as.factor(test_data_svm[, 11]), 
              type = "C-svc", kernel = "vanilladot",
              C = 0.5, scaled = TRUE)

pred <- predict(model, test_data_svm[, 1:10])
test_accuracy <- sum(pred == test_data_svm[, 11]) / nrow(test_data_svm)
print(test_accuracy)

# --------------------------------------------Extra--------------------------------------------
# split data to 80% for cross-validation (K=10) and 20% for test
data <- as.data.frame(credit_card_data)
set.seed(123)
data$ID <- runif(nrow(data),min=0,max=1)
test_data <-subset(data, ID > 0 & ID <= 0.2)
temp_data <- anti_join(data, test_data)

accuracy_svm<- data.frame(
  Column1 = numeric(),
  Column2 = numeric(),
  Column3 = numeric(),
  stringsAsFactors = FALSE
)

colnames(accuracy_svm) <- c("c_value", "vali_accuracy","test_accuracy")

# run simple linear svm models with C=50,250,400
C_values <- c(50,250,400)
for (j in seq_along(C_values)) {
  C_value=C_values[j]
  accuracy=0
  for (i in 1:10) {
    vali_data <-subset(data, ID > 0.2+0.08*(i-1) & ID <= 0.2+0.08*i)
    train_data <- anti_join(temp_data, vali_data)
    
    model <- ksvm(as.matrix(train_data[, 1:10]), as.factor(train_data[, 11]), 
                  type = "C-svc", kernel = "vanilladot", 
                  C = C_value, scaled = TRUE)
    pred <- predict(model, vali_data[, 1:10])
    accuracy=accuracy+sum(pred == vali_data[, 11]) / nrow(vali_data)
  }
  
  avg_accuracy=accuracy/10
  
  accuracy_svm[j,"c_value"] <- C_value
  accuracy_svm[j,"vali_accuracy"] <- avg_accuracy
  
  model_svm <- ksvm(as.matrix(temp_data[, 1:10]), as.factor(temp_data[, 11]), 
                    type = "C-svc", kernel = "vanilladot", 
                    C = C_value, scaled = TRUE)
  
  pred <- predict(model_svm, test_data[, 1:10])
  test_accuracy <- sum(pred == test_data[, 11]) / nrow(test_data)
  
  accuracy_svm[j,"test_accuracy"] <- test_accuracy
  
}

# run knn models with k=5,12,40

accuracy_knn<- data.frame(
  Column1 = numeric(),
  Column2 = numeric(),
  Column3 = numeric(),
  stringsAsFactors = FALSE
)

colnames(accuracy_knn) <- c("k_value", "vali_accuracy","test_accuracy")

k_values <- c(5,12,40)
for (j in seq_along(C_values)) {
  k_value=k_values[j]
  accuracy=0
  for (i in 1:10) {
    vali_data <-subset(data, ID > 0.2+0.08*(i-1) & ID <= 0.2+0.08*i)
    train_data <- anti_join(temp_data, vali_data)
    
    knn_model  <- kknn(train_data[,11]~.,train_data[,1:10],vali_data[,1:10],
                       k=k_value, distance=2, scale = TRUE)
    
    pred <- round(fitted(knn_model))== vali_data[,11]
    accuracy=accuracy+sum(pred == vali_data[, 11]) / nrow(vali_data)
  }
  
  avg_accuracy=accuracy/10
  
  accuracy_knn[j,"k_value"] <- k_value
  accuracy_knn[j,"vali_accuracy"] <- avg_accuracy
  
  model_knn_test <- kknn(temp_data[,11]~.,temp_data[,1:10],test_data[,1:10],
                         k=k_value, distance=2, scale = TRUE)
  
  pred <- round(fitted(model_knn_test))== test_data[,11]
  test_accuracy <- sum(pred == test_data[, 11]) / nrow(test_data)
  
  accuracy_knn[j,"test_accuracy"] <- test_accuracy
  
}

