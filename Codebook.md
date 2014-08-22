### Codebook for run_analysis.R and output.txt ###

- Data obtained from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip .
- Join - subject ids, activities and measures taken by the experimental smartphone gyroscope, for 'test' and 'train' dataset.
- Join -  datasets 'train' and 'test'.
- Reduce - dataset to vars containing 'means' and 'std'
- Remove non-alphanumeric characters from variable names of previous dataset
- Name variables of the dataset *
- Label factors of variable 'activity' according to original dataset

- Generate secondary matrix of means by subjects and activity*

- 'id' = subject's id
- 'activity' = subject's acitivity at time of measurement
- all further variables are means of subjects and the respective activity*

* Variable names correspond to previous names after removal of all non-numeric character. See original, reduced codebook (codebook_orig.md) for variable definition. 

#####################################################
