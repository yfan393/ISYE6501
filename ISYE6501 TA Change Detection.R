data <- airquality
str(data)
head(data)
sum(is.na(data))
data <- airquality  # Create a copy of the dataset

# imputation of missing values with the mean
data[] <- lapply(data, function(col) {
  if (is.numeric(col)) {
    col[is.na(col)] <- mean(col, na.rm = TRUE)
  }
  return(col)
})

# Check the data frame to verify the missing values are filled
sum(is.na(data))
summary(data)

# Initialize the results dataframe to store when the positive or negative change occurs
results_df <- data.frame(metric = character(), month = character(), day = character(), change_sign = character(), CUSUM = numeric(), stringsAsFactors = FALSE)

for (i in 1:4) {
  
  # Calculate mean and standard deviation of temperature
  mean_temp <- mean(data[,i])
  std_temp <- sd(data[,i])
  
  # Define a critical value C and threshold t for change detection
  C <- 0.5 * std_temp
  t <- 2 * std_temp
  
  # Initialize CUSUM variable placeholder, this resets the cusum variables for each column
  cusum_pos <- numeric(length(data[,i]))
  cusum_neg <- numeric(length(data[,i]))
  
  # Loop through data to calculate CUSUM
  for (j in 2:length(data[,i])) {
    cusum_pos[j] <- max(0, cusum_pos[j-1] + (data[j,i] - mean_temp - C))
    cusum_neg[j] <- max(0, cusum_neg[j-1] + (mean_temp - data[j,i] - C))
    
    # Check if CUSUM has crossed the threshold t
    if (cusum_pos[j] > t) {
      cat("Positive shift detected at month", data[j,5], "day", data[j,6], "for", names(data)[i], "\n")
      extra_row_pos <- data.frame(metric = names(data)[i], month = data[j,5], day = data[j,6], change_sign = "positive", CUSUM = cusum_pos[j])
      results_df <- rbind(results_df, extra_row_pos)
      # break # can comment out to check flow of cum_sum
    }
    if (cusum_neg[j] > t) {
      cat("Negative shift detected at month", data[j,5], "day", data[j,6], "for", names(data)[i], "\n")
      extra_row_neg <- data.frame(metric = names(data)[i], month = data[j,5], day = data[j,6], change_sign = "negative", CUSUM = cusum_neg[j])
      results_df <- rbind(results_df, extra_row_neg)
      # break # can comment out to check flow of cum_sum
    }
  }
}
