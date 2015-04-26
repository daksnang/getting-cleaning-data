# Getting and Cleaning Data Course Project

## List of Files
- Readme - provides explanation of the methods and steps taken to accomplish the project objectives.
- run_analysis.R - script used to complete the project
- tidy_data.csv - output of the analysis
- Codebook - provides (some) information on data, variables and data transformations.

## Technical notes
- Software platform: Ubuntu 14.10, 64-bit
- R version: 3.1.1 (2014-07-10)
- R library used in project: plyr

## What _run_analysis.R_ does?
1. Creates working directory
2. Downloads and extracts files to the working directory
3. Extracts relevant feature names and position in the "features.txt" file. 
    * the position index has twofold role: (i) to extract only the columns of interest and (ii) to skip irrelevant columns (by assigning "NULL" value to appropriate index) 
4. Extracts relevant columns for analysis from training and test sets.
5. Labels column with feature names extracted in step 3
6. Averages relevant features for each participant and every activity
7. Writes resultant tidy data to file

## Notes
When using linux distribution, with appropriate R libraries, the "run_analysis.R" script can be sourced to produce "tidy_data.csv" file. R will create "samsung-data" directory, download and extract dataset, and perform all necessary data transformations and calculations.

On Windows platform, some modifications to folder path names need to be made for the script to run. For example, 'wget' method is used on linux but 'curl' may be needed on other operating systems. 

The code was written in spirit of 'literate programming' and hopefully the code is annotated in a way that helps the reader. Additional details are contained in the codebook.
