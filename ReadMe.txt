#Overview
This repo contains an R script called “run_analysis.R” which processes raw data collected from the accelerometers from the Samsung Galaxy S smartphone and outputs a tidy data set with the average of each variable for each activity and each subject.  The codebook for the resulting data can be found at https://github.com/jlyons7777/gettingdataproject/blob/master/Codebook.pdf

#Data
A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The exact copy of the data used was provided by the instructors for John’s Hopkins Bloomberg School of Public Health “Getting and Cleaning Data” course.  A copy of the data in .zip file form is available at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

#Perquisites
This script was developed in a specific operating environment and set of conditions.  The results may not be reproducible in a different environment with different settings.  Below are the key settings that may differ from those being used to reproduce the results:

1. This script was developed on Windows 8.1 and R 3.1.2.  It may not function properly in other environments

2. This script requires that the following files be in your working directory.  This files can be downloaded from the link(s) provided above.
--*features.txt
--*X_test.txt
--*y_test.txt
--*subject_test.txt
--*X_train.txt
--*y_train.txt
--*subject_train.txt
--*activity_labels.txt

3. This script requires the use of the following R packages
--*plyr
--*reshape2

#Details

The “run_analysis.R” script does the following 

1. Merges the training and the test sets to create one data set.
The study underlying this data included both “test” and “training” data for given individuals (called subjects in this study) performing a variety of activities (for example sitting or walking).  The data is segregated into two different groups of data in “test” or “train” files.  Each group of files contains 3 files that must be combined to get the full data set.  

--*“subject_test.txt”/”subject_train.txt” - these files contain the data from indicating which subject obtained the reading for each row in the corresponding "X_test" or "X_train" data files.

--*“y_test.txt”/”y_train.txt” - these files indicate the activities that were undertaken for each set of readings.  There is one rown in each of these files for each row in the "X_test" and "X_train" data files.

--*"X_test.txt”/”X_train.txt” – these files contain the data from the accelerometers for the test and training sets.  Each column in these tables is a specific measurement from the accelerometers.

--*"features.txt" - this file is contains the names of the measures found in the "X_test" and "X_train" data files.  There is one row in this file for every column of metrics in the "X_test" and "X_train" files.

The run_analysis.R script reads in the features.txt file to establish the column names for the files.  Then the script reads in the relevant "training" data, column binding the "X_train.txt" to "y_train.txt" and "subject_train.txt".  The sript does the same with the "test" data and then row binds the training and test data together to create a master data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 
The original Train and Test datasets contain 561 values collected from the smartphones.  The “run_analysis.R” script selected XX of these values based on the field names.  “run_analysis.R” selected the values to keep by retaining those with the strings “mean” or “std” (abbreviation for standard deviation) in their name.  This decision was based on reading the “features_info.txt” file which indicated the metrics measured by the smartphones and that “mean” indicated the mean value of each and “std” indicated the standard deviation of each. The script keeps all variables with "mean" and "std" in the name anywhere to be as inclusive as possible.

3. Uses descriptive activity names to name the activities in the data set
The tidy data set produced by “run_analysis.R” uses the activity names from “activity_lables.txt” file.  These names convert the integer values of 1-6 found in the raw data to readable names such as “walking”, “sitting” and “standing” for example.

4. Appropriately labels the data set with descriptive variable names. 
Each name includes a metric from the accelerometer, and indication if the measurement is a mean or std and a direction of the measure if relevant.  These are human readable names.  The variable names from the "features.txt" file generally subscribe to the tidy data naming principles and were not changed. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
The data produced from the raw data is a tidy dataset and meets the following principles
--*Each variable has one column.  In this case there is a column for the subject, activity, variable (measurement) and the value measured.
--*Each observation of the variable has one row.  In this case there is one row for each instance of the subject, activity and variable.
--*There is only one table with this type of data.  Since this data all pertains to the accelerometer readings of subjects in different activities it is being considered one task.

There has been some debate on whether a wide or narrow dataset would the the prime choice for this project.  Arguments can be made for either form and there is a discussion on the topic available at https://class.coursera.org/getdata-014/forum/thread?thread_id=31 if the reader might question the choise made here.

The codebook for the tidy dataset output by "run_analysis.R" can be found at https://github.com/jlyons7777/gettingdataproject/blob/master/Codebook.pdf


