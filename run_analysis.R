# Course project by Felix Albrecht

# loading plyr package for later use
library(plyr)

labels <- read.table("UCI HAR Dataset/features.txt")
keepers <- which(grepl("std",labels[,2])==TRUE | grepl("mean",labels[,2])==TRUE )   # extract column index of mean and std vars
labelsRed <- labels[which(grepl("std",labels[,2])==TRUE | grepl("mean",labels[,2])==TRUE),2]    # extract column names of mean and std vars

# --- train
xTrainFull <- read.table("UCI HAR Dataset/train/X_train.txt")   # read vars
xTrain <- xTrainFull[keepers]   # reduce to only mean and std vars
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")   # read activities
sTrain <- read.table("UCI HAR Dataset/train/subject_train.txt") # 

trainSet <- cbind(sTrain,yTrain,xTrain) # join the 3 above datasets
colnames(trainSet)[1] <- "id"   # rename column 1 to id
colnames(trainSet)[2] <- "activity"     # rename column 2 to activity

# remove unused matrices to free memory
rm(labels)
rm(xTrainFull)
rm(xTrain)
rm(yTrain)
rm(sTrain)

# --- test (documentation see above)
xTestFull <- read.table("UCI HAR Dataset/test/X_test.txt")
xTest <- xTestFull[keepers]
yTest <- read.table("UCI HAR Dataset/test/y_test.txt")
sTest <- read.table("UCI HAR Dataset/test/subject_test.txt")

testSet <- cbind(sTest,yTest,xTest)
colnames(testSet)[1] <- "id"
colnames(testSet)[2] <- "activity"

rm(xTestFull)
rm(xTest)
rm(yTest)
rm(sTest)

# --- label variables + remove all non alpha numeric chars from the name
for(i in 1:length(labelsRed)){
    colnames(trainSet)[i+2] <- gsub("[[:punct:]]", "", labelsRed[i])
    colnames(testSet)[i+2] <- gsub("[[:punct:]]", "", labelsRed[i])
    # print(i) # checkpoint
}

# --- append testSet to trainSet
allSet <- rbind(trainSet,testSet) 

# --- labeling var 'activity' factors
acti <- read.table("UCI HAR Dataset/activity_labels.txt")
activ <- unlist(acti[,1]) # vector of factor levels
actil <- unlist(acti[,2]) # vector of factor labels
allSet$activity <- factor(allSet$activity,levels = activ,labels = actil ) # assing factor labels
rm(acti)

# --- generate mean table based on subject + activity
meanSet <- aggregate(.~ id + activity,data=allSet,FUN=mean) 

write.table(meanSet,file="output.txt", row.names=FALSE) # write secondary 'means' table

codebook(meanSet)

