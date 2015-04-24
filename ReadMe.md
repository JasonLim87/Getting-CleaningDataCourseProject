# Getting and Cleaning Data Course Project

## Overview
This Course Project is part of the **Getting and Cleaning Data** Online Course provided by Coursera.org.
The objective of this Project is to manipulate the [Data - Human Activity Recognition Using Smartphones](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) into a desired dataset, and finally take out a subset and create a text file of the Tidy Data.

## Objectives
Create a R script named run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## How to Use

Make sure the [required Data Set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) has been downloaded and is placed in the `UCI HAR Dataset` Folder.

Load the run_analysis.R file into R studio, and run the entire script.
The full function will automatically execute for one time when the script is ran.
If the function is required to be called multiple times, type `createSummaryData()` into R Studio terminal to re-run it.
