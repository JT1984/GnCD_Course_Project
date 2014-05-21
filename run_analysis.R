## Getting and Cleaning Data Course Project

## Determine which columns of data to retain.
features <- read.table("./data/UCI HAR Dataset/features.txt")
## Convert from factors to character.
featureVector <- as.character(features[,2])
## Use partial matching to find the column names with "mean" and "std".
meanCols <- grep("mean", featureVector)
stdCols <- grep("std", featureVector)
## Combine both sets into one vector.
allCols <- sort(c(meanCols,stdCols))

## Read in the test data.
testSet <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
testLabels <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subjectTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
## Create the test subset
subsetTestSet <- testSet[,allCols]
## Add the activity label and name columns.
subsetTestWithLabels <- cbind(testLabels,subsetTestSet)
subsetTestWithNames <- cbind(subjectTest,subsetTestWithLabels)

## Read the training data.
trainSet <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
trainLabels <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subjectTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
## Create the training subset.
subsetTrainSet <- trainSet[,allCols]
## Add the activity label and name columns.
subsetTrainWithLabels <- cbind(trainLabels, subsetTrainSet)
subsetTrainWithNames <- cbind(subjectTrain, subsetTrainWithLabels)

## Combine the two data frames into one.
combinedDataset <- rbind(subsetTestWithNames, subsetTrainWithNames)

## Add column names.
colnames(combinedDataset)[1] <- "subject"
colnames(combinedDataset)[2] <- "activity"
colnames(combinedDataset)[3:(ncol(combinedDataset))] <- featureVector[allCols]

## Summarize the data by name and activity caluculating the mean of the columns.
summaryData <- aggregate(combinedDataset, by=list(combinedDataset$subject, 
                        combinedDataset$activity), FUN=mean, na.rm=TRUE)
## Remove the first two columns, which are redundant to the third and fourth.
summaryData <- summaryData[, 3:(ncol(summaryData))]

## Convert the activity data into human-readable factors. This is done after the 
## aggregate function to avoid warnings.
summaryData[,2] <- factor(summaryData[,2])
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
levels(summaryData[,2]) <- activities[,2]

## Create the output file to upload.
write.table(summaryData, "./data/tidyData.txt")