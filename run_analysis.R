library(reshape)

if(!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")) {
     download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "getdata-projectfiles-UCI HAR Dataset.zip", method="curl")
}

if(!file.exists("UCI HAR Dataset")) {
     unzip("getdata-projectfiles-UCI HAR Dataset.zip")
}

## Load, isolate, and clean headers
headersDf <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
headers <- headersDf[,2]
gsub("BodyBody", "Body", headers)

## Read data files
xTest <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE, col.names = headers)
xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE, col.names = headers)
testSubj <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
trainSubj <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
yTest <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
yLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)

## Establish filters for column names
## keeping only those labeled as mean() and std() in the codebook
mfCols <- grepl("meanFreq", headers, ignore.case = TRUE)
extCols <- grepl("mean|std", headers, ignore.case = TRUE)

## Merge test and train sensor data sets
xData <- rbind(xTest, xTrain)

## Reduce full data set to mean and standard deviation columns only
xData <- xData[,extCols == TRUE & mfCols == FALSE]

## Merge test and train subject data sets
allSubj <- rbind(testSubj, trainSubj)

## Create subject ID vector
SubjectID <- allSubj[,1]

## Merge test and train activity data sets
yData <- rbind(yTest, yTrain)

## Convert full activity data to text and label as "Activity"
Activity <- yLabels$V2[yData$V1]

## Add Activity column to full sensor data set
finalData <- cbind(SubjectID, xData, Activity)

## Create tidy data set
mData <- melt(finalData, id = c("SubjectID", "Activity"))
tidyData <- dcast(mData, SubjectID + Activity ~ variable, mean)

## Output data sets
write.table(finalData, file = "UCI_HAR_finalData.txt", row.names = FALSE)
write.table(tidyData, file = "UCI_HAR_tidyData_Means.txt", row.names = FALSE)