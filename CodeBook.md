## Code Book for the Course Project
## for
## Getting and Cleaning Data

This readme does not repeat information already found in the documentation files contained with the data set.

# Data
The dataset is taken from the the Human Activity Recognition Using Smartphones Dataset. It can be accessed at the following URL: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

# Variables
The variables are a subset of those found in the full dataset. The full list of variables is given in the features.txt file included in the data. Of the 561 variables, or features, only the data for mean and standard deviation is included. This totals 79 variables in the data set.

# Transformations
The main data set files (x_train.txt, x_test.txt) do not contain identifying row information nor identifying column information. This information is in the subject files, the y_train and y_test files, and the features.txt file.

The first transformation was to determine which columns to retain and then subset just those columns. Next, I added the identifying columns for each record of data (subject and activity) and added the column lables.

The next major step was the summarize the data grouping by subject and activity, taking the mean of all 79 variables. The aggregate function throws warning if all columns (including those grouped!) are not numeric.

The last major step was to transform the activities column into a factor and assign the levels corresponding to the data in the activities_labels.txt file.

Finally, the summarized tidy data set is sent to an output file.