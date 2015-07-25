## read the data in to seperate df's
> ActivityTrain <- read.table("/Users/NickVerhoeven/Desktop/data/y_train.txt", header=F)
> ActivityTest <- read.table("/Users/NickVerhoeven/Desktop/data/y_test.txt",header=F)
> SubjectTest <- read.table("/Users/NickVerhoeven/Desktop/data/subject_test.txt",header=F)
> SubjectTrain <- read.table("/Users/NickVerhoeven/Desktop/data/subject_train.txt",header=F)
> FeaturesTrain <- read.table("/Users/NickVerhoeven/Desktop/data/x_train.txt",header=F)
> FeaturesTest <- read.table("/Users/NickVerhoeven/Desktop/data/x_test.txt",header=F)
## merge the data
> subject <- rbind(SubjectTrain,SubjectTest)
> activity <- rbind(ActivityTrain,ActivityTest)
> features <- rbind(FeaturesTrain,FeaturesTest)
## apply appropriate names
> names(subject) <- c("subject")
> names(activity) <- c("activity")
> FeatureNames <- read.table("/Users/NickVerhoeven/Desktop/data/features.txt", header=F)
> names(features) <- FeatureNames$V2
##Final merge of the three
> merge<- cbind(features,activity,subject)
## extract mean and std  values for activity and subject
> meanSTD <- grep(".*Mean.*|.*Std.*", names(merge), ignore.case=TRUE)
> subset <- c(meanSTD, 562, 563)
> mergeExtract <- merge[,subset]
## descriptive names for activity, read the corresponding table and factorize it in merge after characterizing
> activityLabels <- read.table("activity_labels.txt",header = FALSE)
> mergeExtract$activity <- as.character(mergeExtract$activity)
> for (i in 1:6){
        +     mergeExtract$activity[mergeExtract$activity == i] <- as.character(activityLabels[i,2])
        + }
> mergeExtract$activity <- as.factor(mergeExtract$activity)
## appropriate name variable names
## t = time: Acc = by Accelerometer, Gyro = Gyroscope, f = frequency, Mag = Magnitude
> names(mergeExtract)<-gsub("^t", "time", names(mergeExtract))
> names(mergeExtract)<-gsub("^f", "frequency", names(mergeExtract))
> names(mergeExtract)<-gsub("Acc", "Accelerometer", names(mergeExtract))
> names(mergeExtract)<-gsub("Gyro", "Gyroscope", names(mergeExtract))
> names(mergeExtract)<-gsub("Mag", "Magnitude", names(mergeExtract))
##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
## subject as factor and create tidy set and write to txt
> mergeExtract$subject <- as.factor(mergeExtract$subject)
> tidyData <- aggregate(. ~subject + activity, mergeExtract, mean)
> tidyData <- tidyData[order(tidyData$subject,tidyData$activity),]
> write.table(tidyData, file = "TidyData.txt", row.names = FALSE)


