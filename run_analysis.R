##You should create one R script called run_analysis.R that does the following. 
##1.Merges the training and the test sets to create one data set.
X_test <- read.table("~/R_practice/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", quote="\"", stringsAsFactors=FALSE)
subject_test <- read.table("~/R_practice/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", quote="\"")
y_test <- read.table("~/R_practice/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", quote="\"")
X_train <- read.table("~/R_practice/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", quote="\"", stringsAsFactors=FALSE)
subject_train <- read.table("~/R_practice/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", quote="\"")
y_train <- read.table("~/R_practice/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", quote="\"")
features <- read.table("~/R_practice/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt", quote="\"", stringsAsFactors=FALSE)
activity_labels <- read.table("~/R_practice/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", quote="\"", stringsAsFactors=FALSE)

a<-c("subject","activity",features[,2])
testdata<-cbind(subject_test,y_test,X_test)
traindata<-cbind(subject_train,y_train,X_train)
names(testdata)<-a
names(traindata)<-a
ucidata<-rbind(testdata,traindata)
ucidata$activity<-factor(ucidata$activity)
levels(ucidata$activity)<-activity_labels[,2]

##2.Extracts only the measurements on 
##      the mean and standard deviation for each measurement. 
ucidata_mean<-regexpr("-mean()",names(ucidata))
ucidata_std<-regexpr("-std()",names(ucidata))
mean_std<- (ucidata_mean>0)|(ucidata_std>0)

##3.Uses descriptive activity names to name the activities in the data set

ucidata_ms<-cbind(ucidata$subject,ucidata$activity,ucidata[,mean_std])
names(ucidata_ms)[1:2]<-c("subject","activity")

##4.Appropriately labels the data set with descriptive variable names. 
features2<-names(ucidata2)
features2m<-gsub("-m","M",features2)
features2ms<-gsub("-s","S",features2m)
features2ms_<-gsub("-","",features2ms)
features3<-gsub("\\(\\)","",features2ms_)
names(ucidata_ms)<-features3

##5.Creates a second, independent tidy data set 
##      with the average of each variable for each activity and each subject. 
ucidata2<-aggregate(ucidata_ms[,3:81],ucidata_ms[,1:2],FUN=mean)
