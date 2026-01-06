# Load the required library
library(RSQLite)

# Set up the SQLite driver
drv <- dbDriver('SQLite')
class(drv)

# Define the database path
db_path <- 'data/diamonds.db'

# Check if the data directory exists, if not create it
if (!dir.exists('data')) {
  dir.create('data')
}

# Download the database file if it doesn't exist
if (!file.exists(db_path)) {
  download.file(
    url = 'http://www.jaredlander.com/data/diamonds.db',
    destfile = db_path,
    mode = 'wb'  # Use binary mode for database files
  )
}

# Now connect to the database
con <- dbConnect(drv, db_path)

# List all tables in the database
dbListTables(con)

#List of Fields in the databasetable of diamonds 
dbListFields(con, name='diamonds')

#List of Fields in the databasetable of diamondcolors
dbListFields(con, name='DiamondColors')

# Read a table
diamonds_data <- dbReadTable(con, 'diamonds')
head(diamonds_data)

# Close the connection when done
if (dbIsValid(con)) {
  dbDisconnect(con)
}

