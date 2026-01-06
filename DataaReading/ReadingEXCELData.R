#The main function is read_excel, which reads the data from a single Excel sheet. 
#Unlike read.table,read_delim and fread, read_excel cannot read data directly 
#from the Internet, and thus the files must be downloaded first. We could do this
#by visiting a browser or we can stay within R and use download.file.

download.file( url='http://www.jaredlander.com/data/ExcelExample.xlsx',
               destfile='data/ExcelExample.xlsx', method='curl')
library(readxl)
excel_sheets('data/ExcelExample.xlsx')


#The main function is read_excel, which reads the data from a single Excel sheet
#Unlike read.table,read_delim and fread, read_excel cannot read data directly
#from the Internet, and thus the files must be downloaded first. We could do this
#by visiting a browser or we can stay within R and use download.file.

# Read from local file
library(readxl)
excel_data <- read_excel('D:/downloads/New Folder/Downloads/ExcelExample.xlsx')

# View the sheets in the file (optional)
excel_sheets('D:/downloads/New Folder/Downloads/ExcelExample.xlsx')

#By default read_excel reads the first sheet, in this case the one holding the tomato
#data.The result is a tibble rather than a traditional data.frame.
tomatoXL <- read_excel('D:/downloads/New Folder/Downloads/ExcelExample.xlsx')
tomatoXL
