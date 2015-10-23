# CodeBook

This is the codebook that describes variables, data, steps and process that you need to perform to clean up the data.

## Data source

* Downloadable from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* More information and description about the dataset found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## What is in the data?

The data has been extracted out of a group of volunteers within certain age range that performed several physical activities while wearing an smartphone to record the activity helped for the sensors these devices feature.
The experiment used a Samsung Galaxy SII tied to the waist and collected data from the accelerometer and gyroscope embedded in the phone.
The data has been already filtered out to remove noise data.

## What is its structure?

The zip file includes the next files:
- 'README.txt'
- 'features.txt' (contains all the features of the dataset)
- 'features_info.txt' (more information about the features)
- 'activity_labels.txt' (keys and names of the different physical activities performed in the experiment)
- 'train/X_train.txt' (trainings dataset)
- 'train/y_train.txt' (trainings labels)
- 'test/X_test.txt' (tests dataset)
- 'test/y_test.txt' (tests labels)
- 'train/Inertial Signals/body_acc_x_train.txt' (this is the body acceleration resulted subtracting the gravity value from the total acceleration value)
- 'train/Inertial Signals/total_acc_x_train.txt' (this is the x axis of the accelerometer)
- 'train/Inertial Signals/body_gyro_x_train.txt' (this is the angular velocity given by the gyroscope)
- 'train/subject_train.txt' (subjects who performed the activities)

## STEP-BY-STEP, requests and notes:

There are 6 basic steps the script will perform:

NOTE: The script will set up the environment, will download the data and will unzip it to get it ready. 
If you prefer to download the data manually, you can and the script will skip this part.
If you download manually the data, the best way is to put the script file by the data downloaded and unzipped in the same directory so the script will find the data easily without bothering in setting the working directory.

1. Merge the training and the test sets to crate one data set
2. Extract only the measurements on the mean and standard deviation for each measurement
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive activity names
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject

## How does ```run_analysis.R``` run?

* Require and install if they are not in the environment the libraries ```reshapre2``` and ```data.table```
* Download and unzip data from source url
* Load trainings and tests
* Merge data
* Load activities and features labels
* Get just the data from mean and standard deviation columns
* Process data
* Tide up a bit the data, column names get better human-readable name and activity keys are substituted by their actual activity name
