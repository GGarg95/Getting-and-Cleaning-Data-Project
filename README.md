# Getting-and-Cleaning-Data-Project
Week 4 Project - Getting and Cleaning Data

## README
##-------
This repo contains 
1 - README.md that explains in detail how the script run_analysis works.
2 - CodeBook.md that explains the variables and how the data was transformed and how it becomes a tidy data. 
3 – R script “run_analysis.R” contains the code using which the data was transformed into a tidy data.

## Working of the Script – “run_analysis.R” 
First we start by setting the working directory to where the UCI HAR Dataset is. We then start the cleaning process by first reading in the features.txt into R and store it in a variable called “features”. 

Then we get all the variable names that has the name “mean” or “std” in it.

This also includes “meanFreq”. Hence we have to remove that.

We then have an object called “req_variables” that has only “mean” and “std”.

We then read the avtivity_labels.txt to get the labels values so that we can use this information to convert the numbers 1 to 6 into appropriate activities.

We read subject_train.txt, y_train.txt, X_train.txt into R using read.table().

Similarly we read in data corresponding to test.

We give appropriate column names to the all the 6 objects.

We merge all parts of test data and train data separately using cbind() and call them “test” and “train”.

Now we merge test and train data to form a single data called “data” using rbind().

Apart from the first two columns, we subset only those column names from “data” that are in req_variables and store it in another data frame called req_data.

We convert the activity variable into factor and name them according to the information given in activity_labels.

We use the reshape2 package to melt the data and cast it into a tidy format as per the requirement.  In melt the id variables will be “subject” and “activity”. Using melt() we melt the data which can be then transformed using dcast(). The dcast() then casts the data into a format where for each subject and for each of his activities, mean is calculated for different types of measurement.

Here each column [i.e 3:68] is independent since each has unique type of measurements. Hence we get a data that is tidy. We then write this tidy data into a “.csv” file using write.csv.
 
      



  


