# run_analysis.R Code Book

This is a code book that describes the purpose of all variables that was declared and use in run_analysis.R.

## Global Variable

* basePath : Points to the folder that contains all the required data.


## Variable used to store retrieved Data Sets. 

| Variable Name  | Source                         |
|----------------|--------------------------------|
| testSubject    | test/subject_test.txt          |
| testX          | test/X_test.txt                |
| testY          | test/y_test.txt                |
| trainSubject   | train/subject_test.txt         |
| trainX         | train/X_test.txt               |
| trainY         | train/y_test.txt               |
| featureList    | features.txt                   |
| activityLabels | activitylabels.txt             |


## Variables used to store combined datasets during the data set transformation process

| Variable Name  | Description                                          | Names within dataset         |
|----------------|------------------------------------------------------|------------------------------|
| mainSubject    | combined data from test & Train                      | Subject                      |
| mainX          | combined data from test & Train                      | retrieved from freatures.txt |
| mainY          | combined data from test & Train                      | ActivityName                 |
| rawData        | combined data from subject and activity (mainY)      | N/A                          |
| finalData      | combined data from mainX (readings) and rawData      | N/A                          |
| finalData2     | Similar to finalData but with proper Activity Label  | N/A                          |
| meanData       | The final output that will be exported to .txt file  | N/A                          |

## Variables used to store datasets/vectors used to filter the combined Dataset to desired form

| Variable Name  | Description                                                    | 
|----------------|----------------------------------------------------------------|
| meanStdFilter  | Used to filter finalData to retain mean and std only     	  |
| selectedNames  | Combination of meanStdFilter with "activityName" and "Subject" |

## Replacement keywords from the finalData Datasets to more readible keywords

| Original  | Replacement        |
|-----------|--------------------|
| t         | Time               |
| f         | Frequency          |
| Acc       | Accelerometer      |
| Gyro      | Gyroscope          |
| Mag       | Magnitude          |
| std       | StdDev             |
| mean      | Average            |
| ()        | **Removed**        |

## Tidy Data Set Variable explanation:

The Tidy Set created contains the following headers:
* Subject		: The person that participated in this experiment (Code named 1-30 for a total of 30 personnel)
* Activity		: The 6 activities that was performed by the subject. (WALKING, WALKING_UPSTAIRS
, WALKING_DOWNSTAIRS
, SITTING
, STANDING
, LAYING)

* Others		: The remaining header values are the experiment data collected by the smartphone and recorded down.