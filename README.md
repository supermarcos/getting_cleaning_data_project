# Coursera - Getting and Cleaning Data

## Course Project

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## How to run this script

1. Download the data source from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, put it into a folder on your local drive. Unzip it there and you should have a folder named ```UCI HAR Dataset```.
alternatively
1. If you don't download the data source, the script will download it, unzip it and work on it automatically, my version is ready for doing it by itself unless the data source changes
2. Put ```run_analysis.R``` in the same folder where ```UCI HAR Dataset```, then set it as your working directory using ```setwd()``` function in R.
alternatively
2. If you didn't download manually the data and you let the script do the job by itself, you won't need to put the script file in any particular place neither set the working directory
3. You can run the script on RStudio with ```source("run_analysis.R")``` or using the command line directly, then it will generate a new file ```tinydata.txt``` in your working directory or by the original data if you let it do the whole job.

## Dependencies

this script needs ```reshape2```, ```data.table``` and ```plyr```
