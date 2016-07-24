# Set the working directory to where the UCI HAR Dataset is
# for eg: setwd("C:/Statistics/Rcoursera/Getting and Cleaning Data/UCI HAR Dataset/")

features <- read.table("./features.txt")
colnames(features) <- c("id_no","variable_names")

# Get all the varaible names that has the name "mean" and "std"

id_no_mean_std <-  grep("(*mean)|(*std)",features$variable_names) 

## the above will contain row numbers that has mean, std and also meanFreq

req_variables <- features[id_no_mean_std,]

## we need to remove meanFreq from this

id_no_freq <- grep("(*meanFreq)",req_variables$variable_names)
req_variables <- req_variables[-id_no_freq,]

# Read activity.txt into R to get that data 
activity_labels <- read.table("./activity_labels.txt")
colnames(activity_labels) <- c("sno","activity")

activity_labels <- activity_labels[,2]

# Collect train and test data and merge it using cbind() and rbind() and also simultaneously
# name all the colums in the data set
train_subject <- read.table("./train/subject_train.txt")
train_label   <- read.table("./train/y_train.txt")
train_data 	  <- read.table("./train/X_train.txt")

colnames(train_subject) <- "subject"
colnames(train_label) <- "activity"
colnames(train_data) <- features$variable_names

test_subject 	<- read.table("./test/subject_test.txt")
test_label		<- read.table("./test/y_test.txt")
test_data		<- read.table("./test/X_test.txt")

colnames(test_subject) <- "subject"
colnames(test_label) <- "activity"
colnames(test_data) <- features$variable_names


test <- cbind(test_subject,test_label,test_data)
train <- cbind(train_subject,train_label,train_data)
data <- rbind(test,train)

# subset the data set which has the mean and std function in the column names
req_names <- as.character(req_variables$variable_names)
req_data <- data[,c("subject","activity",req_names)] 

# Covert the activity varaible into a factor and name them accordingly
req_data$activity = factor(req_data$activity, labels = activity_labels) 

# Also convert the subject variable into a factor
req_data$subject = factor(req_data$subject)

# Use the package reshape2 to melt the data and cast it in such a way that it is in a tidy form
library(reshape2)
molten <- melt(req_data, id= c("subject","activity"))
dcast_data <-  dcast(molten, subject + activity ~ variable, mean)

# Write the dcast_data into a .txt file called tidy_data
write.table(dcast_data,"./tidy_data.txt",row.names =  FALSE)
## for reading the file back into R use and viewing it use
##  tidy_data <- read.table("./tidy_data.txt", header = TRUE)
## View(tidy_data)





