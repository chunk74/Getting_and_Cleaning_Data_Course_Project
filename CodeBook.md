### Getting and Cleaning Data Course Project

### Description

Additional information about the variables, data and transformations used in the course project for the Coursera Getting and Cleaning Data course.

### Source Data

A full description of the data used in this project can be found at <a href = http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones> The UCI Machine Learning Repository </a>

The source data for this project can be found <a href = https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>here</a>.

### Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### Attribute Information

For each record in the dataset it is provided:
<ul>
  <li>Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.</li>
  <li>Triaxial Angular velocity from the gyroscope.</li>
  <li>A 561-feature vector with time and frequency domain variables.</li>
  <li>Its activity label.</li>
  <li>An identifier of the subject who carried out the experiment.</li>
</ul>
### Section 1. Merge the training and the test sets to create one data set.

After setting the source directory for the files, read into tables the data located in:
<ul>
  <li>Y_test.txt</li>
  <li>Y_train.txt</li>
  <li>subject_test.txt</li>
  <li>subject_train.txt</li>
  <li>X_test.txt</li>
  <li>X_train.txt</li>
</ul>

<ol>
  <li>Combine all test and training data into 3 separate tables for activity, subject and feature</li>
  <li>Label columns appropriately for each 3 tables</li>
  <li>Combine activity and subject tables into 1 table (dataMerge)</li>
  <li>Combine dataMerge with features table (dataFinal)</li>
</ol>

### Section 2. Extract only the measurements on the mean and standard deviation for each measurement.

<ol>
  <li>Create list of features using "mean()" and "std()" in the name using grep</li>
  <li>Create subset of data based on selected names from the list of features (dataSub_meanstd)</li>
</ol>

### Section 3. Use descriptive activity names to name the activities in the data set

Apply actitivy descriptions from "activity_labels.txt" to "dataSub_meanstd$activity"

### Section 4. Appropriately label the data set with descriptive activity names.

Use gsub function for pattern replacement to clean up the data labels.

### Section 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

Per the project instructions, produce a data set with the average of each variable for each activity and each subject
