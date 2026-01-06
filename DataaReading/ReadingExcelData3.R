url <- "http://www.jaredlander.com/data/ExcelExample.xlsx"
destfile <- "Excel_Jaredexample.xlsx"
download.file(url, destfile, mode = "wb")

# Read first sheet (default)
example_data <- read_excel(destfile)
print(head(example_data))

# Read sheet 2 by number (if many sheets are available)
wineXL1 <- read_excel(destfile, sheet = 2)
cat("\n=== Wine Data (Sheet 2) ===\n")
print(wineXL1)

# Read sheet by name
wineXL2 <- read_excel(destfile, sheet = 'Wine')
cat("\n=== Wine Data (by name) ===\n")
print(head(wineXL2))

# Check all available sheets
cat("\n=== Available sheets ===\n")
print(excel_sheets(destfile))

#cat() stands for concatenate and print. It's used to display text output to the console.