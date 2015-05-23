## This script processes raw data collected from the accelerometers 
## from the Samsung Galaxy S smartphone and outputs a tidy
## data set with the average of each variable for each activity and
## each subject.  This tidy dataset will be written to a file call
## tinydata.txt in your working directory.  You can learn more about 
## this script by reading the ReadMe.txt file at
## https://github.com/jlyons7777/gettingdataproject/blob/master/ReadMe.txt

library("plyr")
library("reshape2")

## Get field names for features data

	features_vector<-"features.txt"

	features<-read.table(features_vector, colClasses="character")

	features$V3=sub("()-",".",features$V2, fixed=TRUE)

	features$V3=sub("-",".",features$V3, fixed=TRUE)

	features$V3=sub("()",".",features$V3, fixed=TRUE)

	colnames=features$V3

## Reads in the train data

	train_subject<-"subject_train.txt"

	train_subject_data<-read.table(train_subject)

	names(train_subject_data)[names(train_subject_data)=="V1"]<-"subject"

	train_data<-"X_train.txt"

	train_data<-read.table(train_data, col.names=colnames)

	train_labels<-"y_train.txt"

	train_label_data<-read.table(train_labels)

	names(train_label_data)[names(train_label_data)=="V1"]<-"activity"

	dftrain<-cbind(train_subject_data,train_data)
	
	dftrain<-cbind(dftrain,train_label_data)
	
	dftrain$source="train"


## Reads in the test data

	test_subject<-"subject_test.txt"

	test_subject_data<-read.table(test_subject)

	names(test_subject_data)[names(test_subject_data)=="V1"]<-"subject"

	test_data<-"X_test.txt"

	test_data<-read.table(test_data, col.names=colnames)

	test_labels<-"y_test.txt"

	test_label_data<-read.table(test_labels)

	names(test_label_data)[names(test_label_data)=="V1"]<-"activity"

	dftest<-cbind(train_subject_data,train_data)
	
	dftest<-cbind(dftest,train_label_data)
	
	dftest$source="test"

## Combine the test and train data sets

	master.data<-rbind(dftrain,dftest)

## Identify the mean and std fields to keep in the dataset
	std.names<-grep("std",colnames(master.data),value=TRUE)

	mean.names<-grep("mean",colnames(master.data),value=TRUE)

	field.names<-c("subject", "activity", "source", mean.names, std.names)

## Subset master data to keep only the necessary fields

	master.data<-master.data[field.names]


## Summarize data

	data.melt<-melt(master.data,id=(1:3),measure.vars=(4:82))

	summ.data<-ddply(data.melt, .(subject,activity,variable), summarize,
			mean(value)
			)


## Get tidy names for the activities

	activity_labels<-"activity_labels.txt"

	activity_labels_data<-read.table(activity_labels)
	
	names(activity_labels_data)[names(activity_labels_data)=="V1"]<-"activity"

	names(activity_labels_data)[names(activity_labels_data)=="V2"]<-"activity.label"

## Merge the tidy names for activities into the master data

	master.data<-merge(summ.data,activity_labels_data)

	names(master.data)[names(master.data)=="..1"]<-"value"

## Write out tidy dataset

	tidy.names<-c("subject","activity.label", "variable", "value")

	output.data<-master.data[tidy.names]

	write.table(output.data, "tidydata.txt", row.name=FALSE)


