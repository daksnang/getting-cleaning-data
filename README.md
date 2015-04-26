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

## Notes
When using linux distribution, with appropriate R libraries, the "run_analysis.R" script can be sourced to produce "tidy_data.csv" file. R will create "samsung-data" directory, download and extract dataset, and perform all necessary data transformations and calculations.

On Windows platform, some modifications to folder path names need to be made for the script to run. For example, 'wget' method is used on linux but 'curl' may be needed on other operating systems. 

The code was written in spirit of 'literate programming' and hopefully the code is annotated in a way that helps the reader. Additional details are contained in the codebook.
