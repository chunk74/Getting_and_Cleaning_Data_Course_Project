###################################################################################################
#
# Cliff Hayes
# Getting and Cleaning Data
# Course Project
# 2015-04-26
#
# run_analysis.R does the following. 
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names. 
# 5) From the data set in step 4, creates a second, independent tidy data set with the average
#    of each variable for each activity and each subject.
#
###################################################################################################

###################################################################################################
#
# 1) Merges the training and the test sets to create one data set.
#
###################################################################################################

## Set working directory and clean workspace
setwd("~/Coursera/Data Science Track/03 Getting and Cleaning Data")
rm(list=ls())

## Create folder for course project data and download the data
if(!file.exists("./course_prj")){dir.create("./course_prj")}
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("./course_prj/data.zip")){download.file(URL, destfile="./course_prj/data.zip")}

## unzip data.zip to course_prj directory
if(!file.exists("./course_prj/UCI HAR Dataset/README.txt"))
    {unzip(zipfile = "./course_prj/data.zip", exdir="./course_prj")}

## Create path to data and a file list for all data files 
path_toData <- file.path("./course_prj" , "UCI HAR Dataset")
file_list   <- list.files(path_toData, recursive=TRUE)

## Read in data from files
activityTest  <- read.table(file.path(path_toData, "test" , "Y_test.txt" ), header = FALSE)
activityTrain <- read.table(file.path(path_toData, "train", "Y_train.txt"), header = FALSE)
subjectTest   <- read.table(file.path(path_toData, "test" , "subject_test.txt"), header = FALSE)
subjectTrain  <- read.table(file.path(path_toData, "train", "subject_train.txt"), header = FALSE)
featuresTest  <- read.table(file.path(path_toData, "test" , "X_test.txt" ), header = FALSE)
featuresTrain <- read.table(file.path(path_toData, "train", "X_train.txt"), header = FALSE)

## Combine test and training data by rows
dataSubject  <- rbind(subjectTrain, subjectTest)
dataActivity <- rbind(activityTrain, activityTest)
dataFeatures <- rbind(featuresTrain, featuresTest)

## Apply column names to combined data
names(dataSubject)  <- c("subject")
names(dataActivity) <- c("activity")
featuresNames       <- read.table(file.path(path_toData, "features.txt"), head=FALSE)
names(dataFeatures) <- featuresNames$V2

## Combine columns of dataSubject & dataActivity
dataMerge <- cbind(dataSubject, dataActivity)

## Combine columns of dataFeatures with dataMerge01
dataFinal <- cbind(dataMerge, dataFeatures)

###################################################################################################
#
# 2) Extracts only the measurements on the mean and standard deviation for each measurement.
#
###################################################################################################

## Create list of features using "mean()" and "std()" in the name using grep
mean_stdFeatures <- featuresNames$V2[grep("mean\\(\\)|std\\(\\)", featuresNames$V2)]

## Create subset of data based on selected names
selectedNames   <- c(as.character(mean_stdFeatures), "subject", "activity")
dataSub_meanstd <- subset(dataFinal, select=selectedNames)

###################################################################################################
#
# 3) Uses descriptive activity names to name the activities in the data set
#
###################################################################################################

## Apply actitivy descriptions from activity_labels.txt to dataSub_meanstd$activity
activityLabels <- read.table(file.path(path_toData, "activity_labels.txt"), header = FALSE)
names(activityLabels)    <- c("activityID", "activityDESC")
dataSub_meanstd$activity <- factor(dataSub_meanstd$activity,
                                   labels=as.character(activityLabels$activityDESC))

###################################################################################################
#
# 4) Appropriately labels the data set with descriptive variable names.
#
###################################################################################################

names(dataSub_meanstd) <- gsub("^t",       "time",          names(dataSub_meanstd))
names(dataSub_meanstd) <- gsub("^f",       "frequency",     names(dataSub_meanstd))
names(dataSub_meanstd) <- gsub("Acc",      "Accelerometer", names(dataSub_meanstd))
names(dataSub_meanstd) <- gsub("Gyro",     "Gyroscope",     names(dataSub_meanstd))
names(dataSub_meanstd) <- gsub("Mag",      "Magnitude",     names(dataSub_meanstd))
names(dataSub_meanstd) <- gsub("BodyBody", "Body",          names(dataSub_meanstd))
names(dataSub_meanstd) <- gsub("\\()",     "",              names(dataSub_meanstd))
names(dataSub_meanstd) <- gsub("-std",     "-StdDev",       names(dataSub_meanstd))
names(dataSub_meanstd) <- gsub("-mean",    "-Mean",         names(dataSub_meanstd))

###################################################################################################
#
# 5) From the data set in step 4, creates a second, independent tidy data set with the average
#    of each variable for each activity and each subject.
#
###################################################################################################

library(plyr);
dataTidy <- aggregate(. ~subject + activity, dataSub_meanstd, mean)
dataTidy <- dataTidy[order(dataTidy$subject,dataTidy$activity),]
write.table(dataTidy, file = "dataTidy.txt",row.name=FALSE)
