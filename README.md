Readme file
For Getting and Cleaning Data Course Project
========================================================
I. SCRIPT <run_analysis.R>
All of the steps: reading, processing of raw data to convert into tidy data and writing out to a file, are performed by the single accompanying R script <run_analysis.R>. It works as follows:

1. It downloads and unzips the files.
2. It reads in the training and test data: variables X, Activity Info Y and Subjects
3. Merges Training and Test data into Xmerged, Ymerged and subjmerged.
4. Identifies fetaures that represent mean and std, and extracts them into a select_features list. This leads to selecting 79 of 561 features
5. Creates a prelim data frame: data1, that contains as columns: activities, subjects and measurement data for a total of 2+79 = 81 columns.
6. Then, it utilizes the by() function to compute mean of each vaiable grouped by activity and subject.
7. The results are all bound together into the dataframe: tidydata. Which is of size 180 x 81. 
8. The tidydata is written into a text file: <tidydata.txt>.
9. As a check, the text file is readback and viewed in teh R Studio data viewer and is verified to meet the requirements of tidy data

II. CODEBOOK
A code book that describe the tidy data is also provided.
