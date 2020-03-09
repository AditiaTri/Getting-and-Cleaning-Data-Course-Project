# Getting-and-Cleaning-Data-Course-Project

## Initial data for research
The script is created to prepare data from [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
The archive needs to be extracted to the working directory (./UCI HAR Dataset/)

## The following files from the initial dataset is used:
'features.txt': List of all features.
'train/X_train.txt': Training set. The measurements of the features in train set
'train/y_train.txt': Training labels. Activity (from 1 to 6) for each measurement from the train set
'test/X_test.txt': Test set. The measurements of the features in set set
'test/y_test.txt': Test labels. Activity (from 1 to 6) for each measurement from the test set
'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

## Data loading into R Dataframe:
The following steps are performed to load data from the necessary files:
- Load the features description from features.txt as a data frame

- Load the measurements from X_train.txt as a data frame
- (STEP 4: Appropriately label the data set with descriptive variable names). For X_train, column names are modified to be more user-friendly using features description loaded on the previous stage. 
- Load the measurements from y_train.txt as a data frame
- Create column activity from data in y_train
- Load the measurements from subject_train.txt as a data frame
- Create column subject from data in subject_train

- Load the measurements from X_test.txt as a data frame
- (STEP 4: Appropriately label the data set with descriptive variable names). For X_test, column names are modified to be more user-friendly using features description loaded on the previous stage. 
- Load the measurements from y_test.txt as a data frame
- Create column activity from data in y_test
- Load the measurements from subject_test.txt as a data frame
- Create column subject from data in subject_test

## STEP 1: Merges the training and the test sets to create one data set.
Rows from test and train data frames are merged together to form data frame with complete data.

## STEP 2: Extract only the measurements on the mean and standard deviation for each measurement of assignment
Extract measurements that involves only mean and standard deviation values script using grep, that is, finding column names that includes "mean(" or "std(" (activity and subject columns are also added to filtered data frame). A new data frame is the created.

## STEP 3: Uses descriptive activity names to name the activities in the data set
Provide descriptive values for activity labels a new variable "activitylabel" is added to dataset, containing a factor variable based on data provided in y_train and y_test.

## STEP 4: Appropriately labels the data set with descriptive variable names
This step is performed at the "Data Loading" step before STEP 1.

## STEP 5: Create a tidy dataset with mean values for each subject and activity
Creates a melted data frame using activity label and subject as ids, after that mean values for all variables are calculated grouped by activity and subject using dcast() function and tidy data frame is created.
