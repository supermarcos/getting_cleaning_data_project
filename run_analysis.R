### THIS IS JUST ENVIRONMENT PREPARATION AND DATA ACQUISITION

# prepare the environment
# The script needs data.table and reshape2 libraries, if they don't exist on the environment, this pre-script step will install them
if(!require("data.table")){
    install.packages("data.table")
}
require("data.table")

if(!require("reshape2")){
    install.packages("reshape2")
}
require("reshape2")


# NOTE: the rest of dependencies and libraries should be there, usually are included in a standard R installation
#       if something is missing, try to run install.packages(library_name) to fix the problem


dataPath = "./data/UCI HAR Dataset" # this will be the name of the directory where the data is in when downloaded and unziped, if the source changes, this needs to be changed to match paths

# get the data to analyse
# check if the data folder is there, if not, create it (data will be the folder to download the data from the given source):
if(!file.exists("./data")){
    dir.create("./data")
}
# download the data if it is not already there:
if(!file.exists("./data/data.zip")){
    downloadUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    res = download.file(downloadUrl, destfile="./data/data.zip")  # 0 when OK, error otherwise
    if(res == 0){
        # if the file has been correctly downloaded, unzip it:
        if(file.exists("./data/data.zip")){
            unzip(zipfile="./data/data.zip", exdir="./data")
            if(!file.exists(dataPath)){
                # if unzip function didn't create the folder indicated on the variable dataPath, something went wrong trying to unzip the file, probably the file is corrupt
                print("Error: couldn't unzip the data file, probably downloaded file is corrupt. Try to get it manually and unzip it to check if it the source is OK.")
                stop("program terminated")
            }
        }else{
            # if the datafile doesn't exist at this point, something went wrong and that's probably the file couldn't be downloaded
            print("Error: no data file downloaded. Try to download the file manually to see if the source is OK.")
            stop("program terminated")
        }
    }else{
        print("Error: impossible to download the data file from the url given. Try to download the file manually to see if the source is OK.")
        stop("program terminated")
    }
}

### HERE STARTS POINT 1: Merge the training and the test sets to crate one data set

# read the data the script will need to make them accesible

# NOTE: this is probably not the best practice, it may depend on how big the data to analyse is and 
#       how much RAM memory the computer has available, but that's what the project asks for anyway...

# Let's create a couple of variables: test and train that will have different properties inside (activity, features and subjects)
test.activity   <- read.table(paste(dataPath, "/test/y_test.txt", sep = ""), col.names = "label", header = FALSE)
test.features   <- read.table(paste(dataPath, "/test/X_test.txt", sep = ""), header = FALSE)
test.subjects    <- read.table(paste(dataPath, "/test/subject_test.txt", sep = ""), col.names = "subject", header = FALSE)

train.activity  <- read.table(paste(dataPath, "/train/y_train.txt", sep = ""), col.names = "label", header = FALSE)
train.features  <- read.table(paste(dataPath, "/train/X_train.txt", sep = ""), header = FALSE)
train.subjects   <- read.table(paste(dataPath, "/train/subject_train.txt", sep = ""), col.names = "subject", header = FALSE)

# merge the data
# Let's merge the data step by step, first it is merge subjects, activities and features together, then give names to columns and then merge all together
subject_data    <- rbind(test.subjects, train.subjects)
activity_data   <- rbind(test.activity, train.activity)
features_data   <- rbind(test.features, train.features)
# set column names
names(subject_data)     <- c("subject")
names(activity_data)    <- c("activity")
# for features, we have to take V2 column from the file "features.txt"
features_names          <- read.table(paste(dataPath, "/features.txt", sep = ""), header = FALSE)
names(features_data)    <- features_names$V2
# finally, merge the data
data <- cbind(subject_data, cbind(activity_data, features_data))  ## <- this dataset is the result for point 1

### HERE STARTS POINT 2: Extract only the meassurements on the mean and standard deviation for each measurement

# get mean and standard deviation from features_names
subset_features_names <- features_names$V2[grep("mean\\(\\)|std\\(\\)", features_names$V2)]  # using grep, which is similar in linux, it is possible to filter out strings
selected_features_names <- c(as.character(subset_features_names), "subject", "activity")  # add "subject" and "activity" columns
data <- subset(data, select = selected_features_names)  ## <- this subset is the result for point 2

### HERE STARTS POINT 3: Use descriptive activity names to name the activities in the data set

# get the activity labels
activity_labels <- read.table(paste(dataPath, "/activity_labels.txt", sep = ""), header = FALSE)

### HERE STARTS POINT 3: Appropriately label the data set with descriptive variable names

names(data) <- gsub("^t", "Time", names(data))  # <- this will replace the starting "t" by the word time
names(data) <- gsub("^f", "Frequency", names(data)) # <- this will replace the starting "f" by the word frequency
names(data) <- gsub("Acc", "Accelerometer", names(data)) # <- this will replace the word "Acc" by the word "accelerometer"
names(data) <- gsub("Gyro", "Gyroscope", names(data)) # <- this will replace the word "Gyro" by the word "Gyroscope"
names(data) <- gsub("Mag", "Magnitude", names(data)) # <- this will replace the word "Mag" by the word "Magnitude"
names(data) <- gsub("BodyBody", "Body", names(data)) # <- this will replace the word "BodyBody" by the word "Body"

### HERE STARTS POINT 4: Create a second, independent tidy data set with the average of each variable for each activity and each subject

library(plyr)
second_data <- aggregate(. ~subject + activity, data, mean) # mean of every value
second_data <- second_data[order(second_data$subject, second_data$activity),] # order the output by subject and activity
second_data$activity <- activity_labels$V2[match(activity_labels$V1, second_data$activity)]  # swap key by description of the activvity (1 by "WALKING"... and so on) so it is more human-readable

# the output file will be generated inside the data directory
write.table(second_data, file = "./data/tidydata.txt", row.name = FALSE)



