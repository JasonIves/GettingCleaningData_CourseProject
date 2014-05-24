GETTING AND CLEANING DATA - Course Project
========================================================

README
------------------------------------------

This code was written as part of a project for the Coursera
course Getting and Cleaning Data in May 2014 (https://class.coursera.org/getdata-003).

It is based on data from this site:  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones



### REPO CONTENTS

* __README.md__ - README file describing the project

* __CodeBook.md__ - A CodeBook briefly describing the variables in the data sets created by run_analysis.R.

* __run_analysis.R__ - Data processing program.  It downloads and reads in the relevant data, cleans and processes it, and creates 2 outputs:

     * __UCI_HAR_finalData.txt__ - a cleaned and aggregated "wide" data set compiling mean and standard deviation data from both the test and train sets of data, and including subject identifiers and activity data.
     
     
     * __UCI_HAR_tidyData_Means.txt__ - a processing of the data cleaned in UCI_HAR_finalData.txt, resulting in a table of means for each variable, for each combination of subject identifier and activity.