# The following steps will be completed in this R script: 
# 1.Merges the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for each measurement.
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names.
# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Load the necessary libraries
library(reshape2)

# Read features and activity data
features <- read.table("./UCI HAR Dataset/features.txt")

# Read train data
## Train features
train <- read.table("./UCI HAR Dataset/train/X_train.txt")
colnames(train) <- features$V2 # STEP 4
## Train activities
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
train$activity <- y_train$V1
## Train subjects
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train$subject <- subject_train$V1

# Read test data
## Test features
test <- read.table("./UCI HAR Dataset/test/X_test.txt")
colnames(test) <- features$V2 # STEP 4
## Test activities
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt") 
test$activity <- y_test$V1
## Test subjects
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#test$subject <- factor(subject_test$V1)
test$subject <- subject_test$V1


# STEP 1: Merge train and test sets
dataset <- rbind(test, train) 

# STEP 2: Filter column names
## Get column names
col_names <- colnames(dataset)
## Get columns of standard deviation and mean values, also preserves activity and subject values 
col_names_filtered <- grep("std\\(|mean\\(|activity|subject", 
  col_names, 
  value=TRUE)
## Subsets the filtered dataset
dataset_filtered <- dataset[, col_names_filtered] 

# STEP 3: Add descriptive values for activity column
dataset_filtered$activitylabel <- factor(dataset_filtered$activity, labels= c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))

# STEP 5: Create a tidy dataset with mean values for each subject and activity
## Get column names of measure columns
features_col_names = grep("std\\(|mean\\(", col_names, value=TRUE)
## Melt the dataframe
dataset_molten <- melt(dataset_filtered, id = c('activitylabel', 'subject'), measure.vars = features_col_names)
## Create average value for each activity and each subject 
dataset_tidy <- dcast(dataset_molten, activitylabel + subject ~ variable, mean)

# Create the tidy dataset file  
write.table(dataset_tidy, file = "tidydataset.txt", row.names = FALSE)