setwd("~/Documents/Data Science/Coursera/Getting and Cleaning Data Course 3/Project_Getting_and_Cleaning_Data")

if(0) { ## Get the data, if not already
  fileUrl  <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileUrl, destfile = "project.zip", method = "curl", quiet = "TRUE")
  unzip("project.zip", exdir = ".", overwrite = TRUE)  
}

if(1) {   ## Control execution, to save exec time on subsequent runs
Xtrain        <- read.table("./UCI HAR Dataset/train/X_train.txt")
Ytrain        <- read.table("./UCI HAR Dataset/train/y_train.txt")
subjtrain     <- read.table("./UCI HAR Dataset/train/subject_train.txt")

Xtest         <- read.table("./UCI HAR Dataset/test/X_test.txt")
Ytest         <- read.table("./UCI HAR Dataset/test/y_test.txt")
subjtest      <- read.table("./UCI HAR Dataset/test/subject_test.txt")

Xmerged       <- rbind(Xtrain, Xtest)   ## Combine train and test data
Ymerged       <- rbind(Ytrain, Ytest)
subjmerged    <- rbind(subjtrain, subjtest)

features         <- read.table("./UCI HAR Dataset/features.txt")
activity_labels  <- read.table("./UCI HAR Dataset/activity_labels.txt")
}

indx               <- grepl("mean", features$V2) | grepl("std", features$V2)    ## indx of mean and std columns
tempX              <- Xmerged[,indx]
select_features    <- features$V2[indx]
names(tempX)       <- select_features     ## Asigns names/measurement labels to columns

tempY                      <- Ymerged$V1
tempY[which(tempY == 1)]   <- "WALKING"
tempY[which(tempY == 2)]   <- "WALKING_UPSTAIRS"
tempY[which(tempY == 3)]   <- "WALKING_DOWNSTAIRS"
tempY[which(tempY == 4)]   <- "SITTING"
tempY[which(tempY == 5)]   <- "STANDING"
tempY[which(tempY == 6)]   <- "LAYING"

data1                   <- cbind(tempY, subjmerged, tempX)
names(data1)[c(1,2)]    <- c("activity", "subject")
data1                   <- data1[order(data1$activity, data1$subject),]

## Create activity and subjects vectors fo length 6*30
activity       <- c(rep("WALKING",30), rep("WALKING_UPSTAIRS",30), rep("WALKING_DOWNSTAIRS",30), rep("SITTING",30), rep("STANDING",30), rep("LAYING",30))
subjects       <- c(rep(seq(1,30), 6))
tidydata       <- data.frame(cbind(activity, subjects))
## Comopute mean of teh measurement variables for each activity, for each subject
for(i in 3:81) { 
  aa           <- by(data1[,i], data1[,c("subject", "activity")], mean, na.rm = TRUE)
  bb           <- signif(as.vector(as.matrix(aa[,])),3)
  tidydata     <- cbind(tidydata, bb)
}

colnames(tidydata) <- c("activity", "subject", as.character(select_features))   ## Name cols of tidy data

write.table(tidydata,"tidydata.txt", row.names = FALSE)
write.table(select_features, "selected_features.txt", sep = " \n", row.names = FALSE)  ## output for codebook

readback <- read.table("tidydata.txt", header = TRUE)     ## Read the tidydata back to check
View(readback)   ## This opens data viewer


## 