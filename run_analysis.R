# Getting and Cleaning Data (Coursera) class project
# May 2015
# 
# This script does the following (in acordance to "Getting and Cleaning Data (Coursera)" class project):
#         
#         1. Merges the training and the test sets to create one data set.
#         2. Extracts only the measurements on the mean and standard deviation for
#            each measurement. 
#         3. Uses descriptive activity names to name the activities in the data set
#         4. Appropriately labels the data set with descriptive variable names. 
#         5. From the data set in step 4, creates a second, independent tidy data 
#            set with the average of each variable for each activity and each subject.
# 
# -------------------------------------------------------------------------------------
# 
# 1. Merges the training and the test sets to create one data set.
# 
#    In order to perform this part the following steps are taken:
#         
#                 a) Download data
#                 b) Unzip data
#                 c) Read all data into tables
#                 d) Merge data

# a) Download data
#    Set working directory and load the libraries that are needed in the project

#setwd("C:/Users/Monica/Desktop/Analytics Software/R project/R_Working_Directory/Coursera/3 Getting and Cleanning Data/Project")

datadir <- getwd()

library(dplyr)

#    Check if a folder where to store the data exist (called "data"), if not create one

if(!file.exists("data")){
        dir.create("data")
}
#    Download file (zip file) that goes to a folder called "projectdata.zip"

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file(fileURL, destfile = "./data/projectdata.zip", mode="wb")

dateDownloaded <- date()        #Get download date

# b) Unzip data in projectdata.zip folder

setwd("./data")                 # Change workingdirectory to "data"

unzip("projectdata.zip")

list.files()                    # Check for what was unziped
                                # A foder named "UCI HAR Dataset" shows up

setwd ("./UCI HAR Dataset")     # Change workingdirectory to "UCI HAR Dataset"

list.files()                    # Check for what is in "UCI HAR Dataset" folder
                                # There are 2 folders ("test" and "train")
                                # There are 4 text files. Two of these files are
                                # descriptions files ("features_info.txt", and 
                                # "README.txt"). The other 2 files contain data
                                # ("activity_labels.txt" and "features.txt")

# c) Read all data into tables and get the dimensions of each one of these tables


activityDescription <- read.table("activity_labels.txt")
dim(activityDescription)

variablesDescription <- read.table("features.txt")
dim(variablesDescription)

# Check for what is in "train", and "test" folders

list.files("train")
list.files("test")

# Each folder contains 3 test files (subject, X and Y) and a folder ("Inertial signals")
# Read the 6 text files (3 per folder) into tables

trainVolunteerID <- read.table("train/subject_train.txt")
dim(trainVolunteerID)
unique(trainVolunteerID$V1)     # Checks for the unique values in "subject_train.txt"

testVolunteerID <- read.table("test/subject_test.txt")
dim(testVolunteerID)
unique(testVolunteerID$V1)      # Checks for the unique values in "subject_test.txt"

trainXData <- read.table("train/X_train.txt")
dim(trainXData)

testXData <- read.table("test/X_test.txt")
dim(testXData)

trainYData <- read.table("train/y_train.txt")
dim(trainYData)
unique(trainYData)              # Checks for the unique values in "y_train.txt"

testYData <- read.table("test/y_test.txt")
dim(testYData)
unique(testYData)               # Checks for the unique values in "y_test.txt"

# d) Merge data

# Merge data related to training (train)
trainData <- cbind(trainVolunteerID,trainYData,trainXData)
dim(trainData)

# Merge data related to testing (test)
testData <- cbind(testVolunteerID,testYData,testXData)
dim(testData)

# Merge the train and teste data frames
trainTestData <- rbind(trainData,testData)

#----------------------------------------------------------------------------------------------------------------
# 2. Extracts only the measurements on the mean and standard deviation for
#    each measurement.
#
#    In order to perform this part the following steps are taken:
#         
#                 a) Assign names to trainTestData data frame
#                 b) Identify (subset) which are the column names that have mean
#                    or std in their names
#                 c) Subset trainTestData data frame with the values from 
#                    meanandstdvariables

# a) Assign the values obtained in "features.txt" to be the column names of
#    trainTestData data frame

namesTrainTestData <- c("VolunteerID","ActivityID",as.character(variablesDescription$V2))
                                                           # Add two names ("VolunteerID"
                                                           # and "ActivityID") for the merged 
                                                           # columns in d) above
names(trainTestData) <- namesTrainTestData                 # Assigns names to "testTrainData"

# b) Identify (subset) which are the column names that have mean or std in their names

meanandstdvariables <- as.character(variablesDescription$V2[grep("mean\\(\\)|std\\(\\)",variablesDescription$V2)])


# c) Subset trainTestData data frame with the values from meanandstdvariables

subsetNamesTrainTestData <- c("VolunteerID","ActivityID",meanandstdvariables)  
                # Add two names ("VolunteerID" and "ActivityID") for the merged columns in 1.d) above

subsetTrainTest <- subset(trainTestData,select=subsetNamesTrainTestData)       
                # Subset trainTestData data frame with the values from meanandstdvariables

#----------------------------------------------------------------------------------------------------------------
# 3. Uses descriptive activity names to name the activities in the data set

#    Convert the "ActivityID" column in the "subsetTrainTest" data frame to factor

subsetTrainTest$ActivityID <- factor(subsetTrainTest$ActivityID, labels=activityDescription$V2)

#----------------------------------------------------------------------------------------------------------------
#  4. Appropriately labels the data set with descriptive variable names.
#
#     Appropriately labels should have the following characteristics
#       a) All lowercases
#       b) No special characters like period, dash, underscore, parenthesis
#       c) Descriptive names

# a) All lowercases
names(subsetTrainTest) <- tolower(names(subsetTrainTest))

# b) No special characters like period, dash, underscore, parenthesis
names(subsetTrainTest) <- gsub("-","",names(subsetTrainTest))
names(subsetTrainTest) <- gsub("\\()","",names(subsetTrainTest))

# c) Descriptive
names(subsetTrainTest) <- gsub("^t","time",names(subsetTrainTest))
names(subsetTrainTest) <- gsub("^f","frequency",names(subsetTrainTest))
names(subsetTrainTest) <- gsub("mag","magnitude",names(subsetTrainTest))
names(subsetTrainTest) <- gsub("gyro","gyroscope",names(subsetTrainTest))
names(subsetTrainTest) <- gsub("bodyacc","bodyacceleration",names(subsetTrainTest))
names(subsetTrainTest) <- gsub("gravityacc","gravityacceleration",names(subsetTrainTest))
names(subsetTrainTest) <- gsub("std","standarddeviation",names(subsetTrainTest))
names(subsetTrainTest) <- gsub("bodybody","body",names(subsetTrainTest))


# -------------------------------------------------------------------------------------
# 
# 5. From the data set in step 4, creates a second, independent tidy data 
#    set with the average of each variable for each activity and each subject.
# 
# For data to be tidy no columns can be repeated. This step is to ensure no column
# names are repeated
identical(names(subsetTrainTest),unique(names(subsetTrainTest)))

tidydataset <- aggregate(. ~volunteerid + activityid, subsetTrainTest, mean)
tidydataset <- tidydataset[order(tidydataset$volunteerid,tidydataset$activityid),]
setwd(datadir)
write.table(tidydataset, file="tidydata.txt",row.name=FALSE)
