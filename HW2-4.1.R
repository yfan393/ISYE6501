# Assignment: HM2
# Students (name, GT id):
#          Yuanting Fan, 904047984
#          Wenjia Hu, 904057780
#          Sen Yang, 904025995

data <- (iris)
data_predictors <- scale(iris[,1:4], scale = TRUE)
data_realresult <- iris[,5]

#1st, find the best k for clustering. Here we use cluster_num to denote k for kmeans clustering
cluster_num=15
wss = sapply(1:cluster_num,
             function(k){kmeans(data_predictors, centers= k, nstart= 10)$tot.withinss})
plot(1:cluster_num,wss,type='b', 
     xlab='k(number of cluster)',
     ylab='total within-clusters sum of squares')

# 2nd, fix models(with k = 3) by different combinations of predictors and report their wss
# 4 predictors:
#Step1: fix the model with k = 3
cluster_num=15
wss = sapply(1:cluster_num,
             function(k){kmeans(data_predictors, centers = 3, nstart = 10)$tot.withinss})
#Step2: report its performance
print(kmeans(data_predictors,3,nstart=10)$tot.withinss) 

# combinations of 3 predictors:
# 1,2,3:
#Step1: fix the model with k = 3
cluster_num=15
wss = sapply(1:cluster_num,
             function(k){kmeans(data_predictors[,c(1,2,3)], centers = 3, nstart = 10)$tot.withinss})
#Step2: report its performance
print(kmeans(data_predictors[,c(1,2,3)],3,nstart=10)$tot.withinss) 

# 1,2,4:
#Step1: fix the model with k = 3
cluster_num=15
wss = sapply(1:cluster_num,
             function(k){kmeans(data_predictors[,c(1,2,4)], centers = 3, nstart = 10)$tot.withinss})
#Step2: report its performance
print(kmeans(data_predictors[,c(1,2,4)],3,nstart=10)$tot.withinss) 

# 1,3,4:
#Step1: fix the model with k = 3
cluster_num=15
wss = sapply(1:cluster_num,
             function(k){kmeans(data_predictors[,c(1,3,4)], centers = 3, nstart = 10)$tot.withinss})
#Step2: report its performance
print(kmeans(data_predictors[,c(1,3,4)],3,nstart=10)$tot.withinss) 

# 2,3,4:
#Step1: fix the model with k = 3
cluster_num=15
wss = sapply(1:cluster_num,
             function(k){kmeans(data_predictors[,c(2,3,4)], centers = 3, nstart = 10)$tot.withinss})
#Step2: report its performance
print(kmeans(data_predictors[,c(2,3,4)],3,nstart=10)$tot.withinss) 

# combinations of 2 predictors:
# 1,2:
#Step1: fix the model with k = 3
cluster_num=15
wss = sapply(1:cluster_num,
             function(k){kmeans(data_predictors[,c(1,2)], centers = 3, nstart = 10)$tot.withinss})
#Step2: report its performance
print(kmeans(data_predictors[,c(1,2)],3,nstart=10)$tot.withinss) 

# 1,3:
#Step1: fix the model with k = 3
cluster_num=15
wss = sapply(1:cluster_num,
             function(k){kmeans(data_predictors[,c(1,3)], centers = 3, nstart = 10)$tot.withinss})
#Step2: report its performance
print(kmeans(data_predictors[,c(1,3)],3,nstart=10)$tot.withinss) 

# 1,4:
#Step1: fix the model with k = 3
cluster_num=15
wss = sapply(1:cluster_num,
             function(k){kmeans(data_predictors[,c(1,4)], centers = 3, nstart = 10)$tot.withinss})
#Step2: report its performance
print(kmeans(data_predictors[,c(1,4)],3,nstart=10)$tot.withinss) 

# 2,3:
#Step1: fix the model with k = 3
cluster_num=15
wss = sapply(1:cluster_num,
             function(k){kmeans(data_predictors[,c(2,3)], centers = 3, nstart = 10)$tot.withinss})
#Step2: report its performance
print(kmeans(data_predictors[,c(2,3)],3,nstart=10)$tot.withinss) 

# 2,4:
#Step1: fix the model with k = 3
cluster_num=15
wss = sapply(1:cluster_num,
             function(k){kmeans(data_predictors[,c(2,4)], centers = 3, nstart = 10)$tot.withinss})
#Step2: report its performance
print(kmeans(data_predictors[,c(2,4)],3,nstart=10)$tot.withinss) 

# 3,4:
#Step1: fix the model with k = 3
cluster_num=15
wss = sapply(1:cluster_num,
             function(k){kmeans(data_predictors[,c(3,4)], centers = 3, nstart = 10)$tot.withinss})
#Step2: report its performance
print(kmeans(data_predictors[,c(3,4)],3,nstart=10)$tot.withinss) 

# combinations of 1 predictors:
# 1:
#Step1: fix the model with k = 3
cluster_num=15
wss = sapply(1:cluster_num,
             function(k){kmeans(data_predictors[,c(1)], centers = 3, nstart = 10)$tot.withinss})
#Step2: report its performance
print(kmeans(data_predictors[,c(1)],4,nstart=10)$tot.withinss) 

# 2:
#Step1: fix the model with k = 3
cluster_num=15
wss = sapply(1:cluster_num,
             function(k){kmeans(data_predictors[,c(2)], centers = 3, nstart = 10)$tot.withinss})
#Step2: report its performance
print(kmeans(data_predictors[,c(2)],3,nstart=10)$tot.withinss) 

# 3:
#Step1: fix the model with k = 3
cluster_num=15
wss = sapply(1:cluster_num,
             function(k){kmeans(data_predictors[,c(3)], centers = 3, nstart = 10)$tot.withinss})
#Step2: report its performance
print(kmeans(data_predictors[,c(3)],3,nstart=10)$tot.withinss) 

# 4:
#Step1: fix the model with k = 3
cluster_num=15
wss = sapply(1:cluster_num,
             function(k){kmeans(data_predictors[,c(4)], centers = 3, nstart = 10)$tot.withinss})
#Step2: report its performance
print(kmeans(data_predictors[,c(4)],3,nstart=10)$tot.withinss) 



# Step1: calculate the correct rate of the model when choosing the 3rd predictor and k=3:
model_kmeans=kmeans(data_predictors[,c(3)],3,nstart=10)
model_kmeans$cluster

# Step2: compare the model result and the real result to get the final correct rate
true_cluster <- rep(0,150)
true_cluster[which(data_realresult=='setosa')] <- 3
true_cluster[which(data_realresult=='versicolor')] <-1
true_cluster[which(data_realresult=='virginica')] <- 2

correct_rate_kmeans <- sum(model_kmeans$cluster==true_cluster) /
  nrow(data)
print(table(model_kmeans$cluster,true_cluster))

print(correct_rate_kmeans)



#_____________________Extra: two methods to reduce predictors_________________________________
#1. do correlation analysis to remove redundant predictors
library(ggplot2)

# import data
iris <- read.csv("E:/OneDrive/Courses/ISYE 6501/HW2/iris.txt", sep="")
numeric_iris <- iris[,1:4]

# do correlation analysis to remove redundant predictors
correlation_matrix <- cor(numeric_iris)
print(correlation_matrix)

# since Petal.Length and Petal.Width are highly correlated, 
# we remove Petal.Length and keep the other three predictors
data <- iris[, c(1,2,4)]

# scale data
scaled_data <- scale(data)

library(tibble)

# set the range of k from 1 to 10
n_clusters <- 10
wss <- numeric(n_clusters)

# run the loop to get multiple WSS
set.seed(123)
for (i in 1:n_clusters) {
  training_result <- kmeans(scaled_data, centers = i, nstart = 25)
  wss[i] <- training_result$tot.withinss
}

# Produce a scree plot
wss_df <- tibble(clusters = 1:n_clusters, wss = wss)

scree_plot <- ggplot(wss_df, aes(x = clusters, y = wss, group = 1)) +
  geom_line() +
  geom_point() +
  scale_x_continuous(breaks = c(2, 4, 6, 8, 10))+
  labs(title = "Elbow Method for Optimal Clusters",
       x = "Number of Clusters",
       y = "Within-Cluster Sum of Squares (WSS)")
scree_plot

# choose k=3 based on the plot
k <- 3
set.seed(123)
training_result_new <- kmeans(scaled_data, centers = k, nstart = 25)

# visualize the clusters
library(factoextra)
fviz_cluster(training_result_new, data = scaled_data)

# validate how well k=3 clustering predicts flower type
actual_types <- iris[,c(5)]
cluster_results <- training_result_new$cluster
table(actual_types, cluster_results)

#2.do PCA to reduce dimension

library(factoextra)
library(cluster)
library(mclust)

data <- as.data.frame(iris)
pca <- prcomp(data[,1:4], scale. = TRUE)
data_pca <- pca$x[, 1:2]  # Choose the first two principal components

# Compute k-means clustering for different k values
wss <- sapply(1:10, function(k) kmeans(data_pca, centers = k, nstart = 25)$tot.withinss)
# Plot the elbow method
plot(1:10, wss, type = "b", pch = 19, frame = FALSE,
     xlab = "Number of Clusters", ylab = "Total Within-Cluster Sum of Squares")

# Choose optimal k, e.g., k = 3
kmeans_result <- kmeans(data_pca, centers = 3, nstart = 25)

# Measure clustering performance
conf_matrix <- table(Predicted = kmeans_result$cluster, Actual = data[,5])
print(conf_matrix)

# Compute silhouette width
silhouette_score <- silhouette(kmeans_result$cluster, dist(data))
# Plot silhouette scores
plot(silhouette_score)

# Compute Adjusted Rand Index. Measures the similarity between the clustering result and the true labels, adjusting for chance.

ari <- adjustedRandIndex(kmeans_result$cluster, data[, 5])
print(ari)