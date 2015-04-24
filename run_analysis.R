#check if required libraries are installed, if not, install these libraries and load them
if (!("plyr" %in% rownames(installed.packages())) ) { install.packages("plyr") }
library(plyr)

# A simple function to read the required files with less typing.
readFile<-function(path,item){
  if (path=="") {addSep<-""; undScore<-""} else  {addSep<-"/";undScore<-"_" }
  fileDes<-paste(basePath,path,addSep,item,undScore,path,".txt",sep="")
  print(paste("Reading File '",fileDes,"'...",sep=""))
  retFile<-read.table(fileDes)  
  retFile
}

# The meat of the function, all 5 steps will be performed within the createSummaryData() function.
createSummaryData<-function(){
  ## Setting the access path into the UCI HAR Dataset folder in the WD (Working Directory)
  basePath <<- "UCI HAR Dataset/"
  
  
  
  #======================PART 1 : MERGING THE DATA SETS===================
  
  print("Retrieving data sets from UCI HAR Dataset folder.")
  #check if these files has been loaded before, if yes, don't reload them to save time.
  if (!exists("testSubject")) {testSubject<<-readFile("test","subject")}
  if (!exists("testX")) {testX<<-readFile("test","X")}
  if (!exists("testY")) {testY<<-readFile("test","y")}
  
  if (!exists("trainSubject")) {trainSubject<<-readFile("train","subject")}
  if (!exists("trainX")) {trainX<<-readFile("train","X")}
  if (!exists("trainY")) {trainY<<-readFile("train","y")}
  
  #Merging the separated train and test sub datasets into complete sets
  mainSubject <- rbind(trainSubject, testSubject)
  mainX <- rbind(trainX, testX)
  mainY <-rbind(trainY, testY)
  
  #Provide Suitable Variable names to replace the V1/2 variable in the Subject and Y datasets
  names(mainSubject)<-c("Subject")
  names(mainY)<- c("ActivityName")
  
  #Retrieving the suitable variable names from features.txt file, and replace them in the X dataset.
  if (!exists("featureList"))  {featureList<<-readFile("","features") }
  names(featureList)<-c("seq","measurement")
  names(mainX)<- featureList$measurement
  
  #Finally, merging all three datasets into a single Set which will be used for the remainder of this process.
  print("Merging data sets into one data set.")
  rawData <- cbind(mainSubject, mainY)
  finalData <- cbind(mainX, rawData)
  #==========================PART 1 END=====================================
  
  
  
  #======================PART 2 : EXTRACTION OF MEAN & STD DEV SET===================
  print("Extracting only mean and std Dev columns from data set.")
  
  #by using the grep() funtion, retrieve only variables with mean or std labels.
  meanStdFilter<-featureList$measurement[grep("mean\\()|std()", featureList$measurement)]
  
  #Before Subsetting, must ensure the Subject and ActivityName column is not filtered as well by including them into the filter.
  finalFilter<-c(as.character(meanStdFilter), "Subject", "ActivityName" )
  
  #Finally, subset the finalData dataset to filter out everything not related to mean or std, as well as retaining the Subject and ActivityName
  finalData<-subset(finalData,select=finalFilter)
  #==========================PART 2 END=====================================
  
  
  #======================PART 3 : Descriptive Activity Names===================
  #Currently for the activity column, all activities are coded 1-6, this process will replace these codes with their
  #respective activities for clearer understanding.
  
  print("Replacing suitable Activity Names for clearer understanding.")
  
  #Retrieving and setting suitable names for the code <-> activity list
  if (!exists("activityLabels"))  {activityLabels<<-readFile("","activity_labels")}
  names(activityLabels)<-c("Code","Activity")

  #merging the finalData and activityLabels set to replace the coded activity with proper names.
  finalData2 <- merge(finalData, activityLabels, by.x = "ActivityName", by.y = "Code", all = TRUE)
  #Remove the original "ActivityName" as it can be replaced by the clearer "Activity" header by the above merger.
  finalData2<-finalData2[,-1]
  #==========================PART 3 END=====================================
  
  
  #======================PART 4 : Descriptive Variable Names===================
  #as the X columns uses alot of shortforms, this part will replace all shortforms as well as unwanted symbols
  #to provide a clearer picure for users.
  print("Replacing suitable Variable Names for clearer understanding.")
  names(finalData2)<-gsub("^t", "Time", names(finalData2))
  names(finalData2)<-gsub("^f", "Frequency", names(finalData2))
  names(finalData2)<-gsub("Acc", "Accelerometer", names(finalData2))
  names(finalData2)<-gsub("Gyro", "Gyroscope", names(finalData2))
  names(finalData2)<-gsub("Mag", "Magnitude", names(finalData2))
  names(finalData2)<-gsub("std", "StdDev", names(finalData2))
  names(finalData2)<-gsub("mean", "Average", names(finalData2))
  names(finalData2)<-gsub("([()])","", names(finalData2))
  #==========================PART 4 END=====================================
  
  
  #======================PART 5 : Tidy Data Creation===================
  print("Creating required Tidy Data.")
  #creating a secondary data set that has the average of each variable for each activity and each subject.
  meanData<-ddply(finalData2,.(Subject,Activity),numcolwise(mean))
  
  #Exporting the secondary data set to a text file.
  write.table(meanData, file = "Avg_Tidy_Data.txt",row.name=FALSE)
  
  #Inform the user where the textfile is located.
  print(paste("Tidy Data created at ",getwd(),"/","Avg_Tidy_Data.txt",sep=""))
  #==========================PART 5 END=====================================
}

#auto trigger the createSummaryData() function when running the entire Script.
createSummaryData()