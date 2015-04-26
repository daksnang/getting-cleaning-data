############################################################
# Final project for "Getting and Cleaning Data"            #
# Spring 2015                                              #
#                                                          #
# Please see Readme file for technical data.               #
# Some commands and function calls are platform specific.  #
#                                                          #
# Ubuntu 14.10                                             # 
# x86_64-pc-linux-gnu (64-bit)                             #  
# R 3.1.1 (2014-07-10)                                     #
# name of working directory: 'samsung-data'                #                        
############################################################

## load needed libraries
library(plyr)

## set working directory where the files will be extracted
if(!file.exists("samsung-data")){
  dir.create("samsung-data")
}
setwd("~/samsung-data")

## download and extract files
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, "~/samsung-data/dataset.zip", method="wget")
unzip("dataset.zip")
setwd("./UCI HAR Dataset")

## find which columns contain relevant data from the features.txt file 
features <- as.matrix(read.table("features.txt", colClasses=c("NULL", "character")))
# find which entries relate to mean and standard deviation
# we will use appropriate column index variables to extract relevant columns later
relevant_columns <- grep("mean|std", features)
column_names <- grep("mean|std", features, value=TRUE)
column_names <- c("subject", "activity", column_names)
# value NULL will eliminate unwanted columns, see help(read.table)
index <- rep("NULL", 561)
# for all other columns set value to 'numeric'
for(i in relevant_columns){
  index[i]="numeric"
}

# create variable with names of the activities 
activities <- read.table("activity_labels.txt", colClasses=c("NULL", "character"))
# we will use dictionary to replace activity id with actual description later
dict <- read.table("activity_labels.txt", colClasses=c("integer", "character"), col.names=c("id", "activity"))

## Extract relevant data from test and training sets 
# we'll work on the test set first
setwd("./test")
subject_test <- read.table("subject_test.txt")
activity_test <- read.table("y_test.txt")

# now we will work on the training set
setwd("~/samsung-data/UCI HAR Dataset/train")
subject_train <- read.table("subject_train.txt")
activity_train <- read.table("y_train.txt")

### (2) EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION
###     FOR EACH MEASUREMENT
setwd("~/samsung-data/UCI HAR Dataset/test")
test_set <- read.table("X_test.txt", colClasses = index)
setwd("~/samsung-data/UCI HAR Dataset/train")
train_set <- read.table("X_train.txt", colClasses = index)

test_set <- cbind(subject_test, activity_test, test_set)
train_set <- cbind(subject_train, activity_train, train_set)

### (4) APPROPRIATELY LABEL THE DATA SET WITH DESCRIPTIVE
###     VARIABLE NAMES
# we'll reuse names of the features extracted earlier
colnames(test_set) <- column_names
colnames(train_set) <- column_names

### (1) MERGE THE TRAINING AND THE TEST SET 
data_set <- rbind(test_set, train_set)

### (3) USE DESCRIPTIVE _ACTIVITY NAMES_ TO NAME THE ACTIVITIES 
###     IN THE DATA SET
setwd("~/samsung-data/UCI HAR Dataset")
data_set$activity <- with(dict, activity[match(data_set$activity, id)])

### (5) CREATE TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE
###     FOR EACH ACTIVITY AND EACH SUBJECT 
# average per activity for each subject (participant)
# ordered by subject...
data_set_avg <- ddply(data_set, .(subject, activity), colwise(mean))
# ...or activity - uncomment if needed 
#data_set_avg1 <- data_set_avg[order(data_set_avg$activity, data_set_avg$subject),]
#data_set_avg1 <- data_set_avg1[, c(2,1,3:81)]
# sanity check 
#data_set_avg2 <- aggregate(.~ activity + subject, FUN=mean, data=data_set)
setwd("~/samsung-data")
write.table(data_set_avg, file="tidy_data.txt", sep=" ", row.names=FALSE)
# uncomment in needed
#write.table(data_set_avg, file="tidy_data.csv", sep=",", row.names=FALSE)
#write.table(data_set_avg1, file="tidy_data_by_activity.csv", sep=",", row.names=FALSE)

# Thank you for taking the time to evaluate my work :)