#!/usr/bin/env Rscript
# This line tells the system to use Rscript to execute this file

# Load the readxl library, which provides functions to read Excel files
library(readxl)

# Define the URL where the Excel file is located
# This is a Microsoft sample sales dataset
url <- "https://go.microsoft.com/fwlink/?LinkID=521962"

# Specify the destination filename where the downloaded file will be saved
# The file will be saved in the current working directory
destfile <- "sample_sales.xlsx"

# Download the Excel file from the URL
# mode = "wb" means write in binary mode, which is required for Excel files
download.file(url, destfile, mode = "wb")

# Read the downloaded Excel file into a data frame
# By default, it reads the first sheet of the workbook
sales_data <- read_excel(destfile)

# Print a success message to the console
cat("Sales data loaded!\n")

# Display the dimensions (number of rows and columns) of the dataset
cat("Dimensions:", nrow(sales_data), "rows,", ncol(sales_data), "columns\n")

# Print the first 6 rows of the dataset to preview the data
# head() shows the top rows by default
print(head(sales_data))


#DISPLAYING BY POSITION OF SHEET 
#using position
wineXL1 <- read_excel( destfile,sheet=2)#if many sheets are available
head(wineXL1)
