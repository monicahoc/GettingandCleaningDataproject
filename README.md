Title: "Coursera Getting and Cleaning Data" project 
Author: Monica Hochstein
Date: 05/17/2015
R version: "R version 3.2.0 (2015-04-16)"
R studio version: "Version 0.98.1103 – © 2009-2014 RStudio, Inc."
R Packages: "dplyr" (for more information http://cran.r-project.org/web/packages/dplyr/dplyr.pdf)
					            Package        LibPath                          Version     Priority 
					dplyr        "dplyr"        ".../R/win-library/3.2" 		"0.4.1"     NA
Operating System: Windows 8.1 64-bit
output: dataframe in the shape of a text file (tidydata.txt)
.
.
---
 
## Project Description

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy
data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. 
You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing
the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed 
to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains 
how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies 
like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to 
from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full 
description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity
   and each subject.
   
## Study design and data processing
 
### Collection of the raw data

1. Libraries to be used are loaded.
2. A check to see if a folder to store raw data exist is performed. If the folder doesn't exist one is created. This
   folder is named "data".
3. Data was downloaded from the internet using "download.file" command. The url argument is the one give in the project 
   description and the destfile argument (destination file) is set to be "projectdata.zip" in the "data" folder
4. The date when the raw data was downloaded is recorder.
5. The downloaded files are in a zip files that need to be decompress. To do this "unzip" command is applied to
   the "project.zip" folder where the data is located.
6. Check to see the contents of the decompress folder are. 
7. The folder "UCI HAR Dataset" shows in the working directory ("data" in this case) with the working data.

###Notes on the original (raw) data 

The data in the "UCI HAR Dataset" consists of the following folders and files:
1)4 text (.txt) files <br />
	a)Two files with instructions <br />
		I) README.txt <br />
		II) features_info.txt<br />
	b) Two files with data<br />
		I) activity_labels.txt<br />
		II) features.txt<br />
2) 2 folders<br />
	a) Train (contents of this folder are 3 text files and 1 folder)<br />
		I) subject_train.txt (data)<br />
		II) X_train.txt (data)<br />
		III) y_train.txt (data)<br />
		IV) Inertia Signals (folder with 9 text files)<br />
			A. body_acc_x_train.txt (data)<br />
			B. body_acc_y_train.txt (data)<br />
			C. body_acc_z_train.txt (data)<br />
			D. body_gyro_x_train.txt (data)<br />
			E. body_gyro_y_train.txt (data)<br />
			F. body_gyro_z_train.txt (data)<br />
			G. total_acc_x_train.txt (data)<br />
			H. total_acc_y_train.txt (data)<br />
			I. total_acc_z_train.txt (data)<br />
	b) Test (contents of this folder are 3 text files and 1 folder)<br />
		I) subject_test.txt (data)<br />
		II) X_test.txt (data)<br />
		III) y_test.txt (data)<br />
		IV) Inertia Signals (folder with 9 text files)<br />
			A. body_acc_x_test.txt (data)<br />
			B. body_acc_y_test.txt (data)<br />
			C. body_acc_z_test.txt (data)<br />
			D. body_gyro_x_test.txt (data)<br />
			E. body_gyro_y_test.txt (data)<br />
			F. body_gyro_z_test.txt (data)<br />
			G. total_acc_x_test.txt (data)<br />
			H. total_acc_y_test.txt (data)<br />
			I. total_acc_z_test.txt (data)<br />
 
##Creating the tidy datafile
 
###Guide to create the tidy data file

1) Download raw data

2) Create tables(with "read.table" command)for all the text files described above (with the exception of the ones
   in the inertia folders, check answer for that in https://class.coursera.org/getdata-014/forum/thread?thread_id=30)

3) Check the dimensions for each one of the tables created in 2)

4) Check the contents of the tables. Here is a small description of what is on the data files
   The data in the "UCI HAR Dataset" consists of the following folders and files:
	a) activity_labels.txt - 6x2 table with the six activities each person performed (WALKING, WALKING_UPSTAIRS, 
	                         WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) See the README.txt file and also * 
	b) features.txt - 561x2 table with signal descriptions described in the features_info.txt file 
	c) Train 
		I) subject_train.txt - 7352x1 table. Contains numbers between 1 and 30. It is assumed these are related to the 
							   volunteer identity (ID)  (Check README.txt and *)                     
		II) X_train.txt - 7352x561 table
		III) y_train.txt - 7352x1 table. Contains numbers between 1 and 6. It is assumied these are related to the 
							   activity identity (ID) in activity_labels.txt
	d) Test
		I) subject_test.txt - 2497x1 table.Contains numbers between 1 and 30. It is assumed these are related to the 
						  volunteer identity (ID)  (Check README.txt and *)
		II) X_test.txt - 2497x561 table
		III) y_test.txt - 2497x1 table. Contains numbers between 1 and 6. It is assumed these are related to the 
							   activity identity (ID) in activity_labels.txt
							   
	From the dimensions of the tables and the contents it can be concluded that the subject, 
	X_ and y_ tables for the train and test set can be merged into two tables. This conclusion comes from the fact
	that they have the same number of rows (7352 for Train and 2497 for Test). 
	In conclusion two new tables with dimensions 7352x563 and 2497x563 are merged (side by side). Since what
	matches is the number of rows "cbind" command is used
	Adding 7352 and 2497 results in 10299 which coincides with the number of instances reported in *.
	Finally we can see that these two tables have the same number of columns so we can merge them (one on top
	of the other) with the "rbind" command. This creates one big Train-Test data frame

5) Assign names to the columns in the big data frame - With the assumptions in (4) the first two columns are named
   as "VolunteerID" and "ActivityID", leaving 561 columns to be renamed. Here it is recognized that 561 is the number or rows
   in the "features.txt" table. One more assumption is that these names correspond to the remaining names in the
   big data frame

6) Identify (subset)big data frame to a smaller data frame that contains only the variables (column names) that
   have "mean" or "std" on their names. To do this the "grep()" function is used and apply the resulting 
   vector to the big data frame resulting in a smaller dataframe that contains only the "mean" and "std" measurements. The
   resulting subset is a 10299 rows and 68 columns dataframe
   
7) Appropriately label the data set with descriptive variable names (from activity_labels.txt) using
   the factor function

8) Appropriately labels the data set with descriptive variable names
     Appropriately labels should have the following characteristics (using the "gsub" command)
       a) All lower cases
       b) No special characters like period, dash, underscore, parenthesis
       c) Descriptive names. Descriptive names should not have abbreviations nor duplicates
	   
9) Creating the tidy data set as described, an independent tidy data set with the average of each variable 
   for each activity and each subject
      a) For data to be tidy no columns can be repeated. The unique function is used to ensure no column names are repeated
	  b) Creates the independent tidy data set with the average of each variable for each activity and each subject
	     using the "aggregate" function in the "stats" library***. (Splits the data into subsets, computes summary statistics for each, and returns the result in a convenient form.)
		 
10) Making the data set as a .txt file with the write.table() command, using row.name=FALSE as stated in the project
  
## Description of the variables in the run_analysis file

1) Folders 
   a) ./data						Folder where data is going to be downloaded and work on
   b) ./data/projectdata.zip		Folder where the zip folder is going to be downloaded
   c) ./data/UCI HAR Dataset		Folder created after zip folder is decompressed
   d) ./data/UCI HAR Dataset/train	Folder where the training data is stored
   e) ./data/UCI HAR Dataset/test	Folder where the testing data is stores
   
 2) Files
	The data in the "UCI HAR Dataset" consists of the following files: 
		a) README.txt				Information about the experiment
		b) features_info.txt		Information about the experiment and variables measured
		c) activity_labels.txt		Names of the activities in experiment (WALKING, WALKING_UPSTAIRS, 
									WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
		d) features.txt				Names of the measured variables in the experiment

	The data in the "train" consists of the following files: 
		e) subject_train.txt		Individuals Identification tags for training experiments
		f) X_train.txt				Experimental training measurements
		g) y_train.txt				Activity number performed by each individual in training (as described 
									in activity_labels.txt)
		
	The data in the "test" consists of the following files:
		h) subject_test.txt (data)	Individuals Identification tags for testing experiments
		i) X_test.txt (data)		Experimental testing measurements
		j) y_test.txt (data)		Activity number performed by each individual in testing (as described 
									in activity_labels.txt)
									
	File with the tidy data set
		k) tidydata.txt				Tidy data generated by run_analysis.R
									
3) Variables

	a) datadir					[1] 	Character vector containing the initial working directory
	b) fileURL 					[1] 	Character vector containing the url where the data is downloaded from
	c) dateDownloaded			[1] 	Character vector with the date data was downloaded
	d) namesTrainTestData		[563] 	Character vector with column names for trainTestData dataframe
	e) meanandstdvariables		[66]	Character vector with column names that contain "mean" or "std" 
	f) subsetNamesTrainTestData [68] 	Character vector meanandstdvariables plus "VolunteerID" and
										"Activity ID" at the beginning to name the 2 merged columns
	
	Tables and dataframes
	
	a) activityDescription 	[6x2] 		Dataframe from activity_labels.txt
	b) variablesDescription [561x2] 	Dataframe from features.txt
	c) trainVolunteerID		[7352x1] 	Dataframe from subject_train.txt
	d) testVolunteerID		[2947x1] 	Dataframe from subject_train.txt
	e) trainXData			[7352x561]	Dataframe from X_train.txt
	f) testXData			[2947x561] 	Dataframe from X_test.txt
	g) trainYData			[7351x1] 	Dataframe from trainYData
	h) testYData			[2497x1] 	Dataframe from y_test.txt
	i) trainData 			[7352x563] 	Dataframe that merges all the training data
	j) testData				[2947x563]	Dataframe that merges all the testing data
	k) trainTestData		[10299x563] Dataframe with all the data (training and testing) together	
	l) subsetTrainTest		[10299x68]  Dataframe with the data that includes only the VolunteerID, ActivityID, 
										mean and std columns
	m) tidydataset			[160x68]	Dataframe with the tidy data

For information on the variables in the dataframe with the tidy data check the codebook.md file	

##Sources
										
  *   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  **  http://cran.r-project.org/web/packages/dplyr/dplyr.pdf)
  *** https://stat.ethz.ch/R-manual/R-patched/library/stats/html/aggregate.html
      http://www.inside-r.org/r-doc/stats/aggregate
