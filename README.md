# rocker <img src='man/figures/logo.png' align="right" height="138" />

<!-- badges: start -->
[![CRAN status](https://www.r-pkg.org/badges/version/rocker)](https://cran.r-project.org/package=rocker)
[![GitHub version](https://img.shields.io/badge/devel%20version-0.1.2.9003-yellow.svg)](https://github.com/nikolaus77/rocker)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
<!-- badges: end -->

'R6' class interface for handling database connections using 'DBI' package as backend. The class allows handling of connections to e.g. PostgreSQL, MariaDB and SQLite. The purpose is having an intuitive object allowing straightforward handling of databases. 

## Installation

Installation of current released version from CRAN.

```R
install.packages("rocker")
```

Installation of current development version from GitHub.

```R
install.packages("devtools")
devtools::install_github("nikolaus77/rocker")
```

## New 'rocker' class object

Create new 'rocker' database handling object.

```R
# Option 1
db <- rocker::newDB()

# Option 2
db <- rocker::rocker$new()
```

## Additional packages and database types

The listed packages are required for some functions of 'rocker'.

### 'crayon' package

The package is required for colored terminal output.
If missing terminal output is monochrome.


```R
install.packages("crayon")
```

Controlling terminal output.

```R
db <- rocker::newDB()
# Terminal output on (default)
db$verbose <- TRUE
# Terminal output off
db$verbose <- FALSE
```

Structure of terminal output.

```
[RSQLite | :memory:] Dctr Driver load RSQLite

 RSQLite                                      = Database driver
           :memory:                           = Database settings
                     D                        = Driver     (D = loaded,    d = not set)
                      c                       = Connection (C = opened,    c = closed)
                       t                      = Transation (T = active,    t = no tranastion)
                        r                     = Result     (R = available, r = no result)
                          Driver load RSQLite = Message text

```

### 'RSQLite' package

Package for handling SQLite database connections.
It is required for the setupSQLite() function of 'rocker' class.

```R
install.packages("RSQLite")
```

Setup database

```R
# Option 1
db <- rocker::newDB()
db$setupSQLite(dbname = ":memory:")
#> [RSQLite | :memory:] Dctr Driver load RSQLite
db$unloadDriver()
#> [RSQLite | :memory:] dctr Driver unload RSQLite 

# Option 2
db <- rocker::newDB()
db$setupDriver(drv = RSQLite::SQLite(), dbname = ":memory:")
#> [RSQLite | :memory:] Dctr Driver load RSQLite
db$unloadDriver()
#> [RSQLite | :memory:] dctr Driver unload RSQLite
```

### 'RPostgres' package

Package for handling PostgreSQL database connections.
It is required for the setupPostgreSQL() function of 'rocker' class.

```R
install.packages("RPostgres")
```

Setup database

```R
# Option 1
db <- rocker::newDB()
db$setupPostgreSQL(host = "127.0.0.1", port = "5432", dbname = "mydb", user = "postgres", password = "password")
#> [RPostgres | 127.0.0.1 | 5432 | mydb] Dctr Driver load RPostgres
db$unloadDriver()
#> [RPostgres | 127.0.0.1 | 5432 | mydb] dctr Driver unload RPostgres

# Option 2
db <- rocker::newDB()
db$setupDriver(
  drv = RPostgres::Postgres(),
  host = "127.0.0.1", port = "5432", dbname = "mydb", user = "postgres", password = "password"
)
#> [RPostgres | 127.0.0.1 | 5432 | mydb] Dctr Driver load RPostgres
db$unloadDriver()
#> [RPostgres | 127.0.0.1 | 5432 | mydb] dctr Driver unload RPostgres
```

### 'RMariaDB' package

Package for handling MariaDB and MySQL database connections.
It is required for the setupMariaDB() function of 'rocker' class.

```R
install.packages("RMariaDB")
```

Setup database

```R
# Option 1
db <- rocker::newDB()
db$setupMariaDB(host = "127.0.0.1", port = "3306", dbname = "mydb", user = "root", password = "password")
#> [RMariaDB | 127.0.0.1 | 3306 | mydb] Dctr Driver load RMariaDB
db$unloadDriver()
#> [RMariaDB | 127.0.0.1 | 3306 | mydb] dctr Driver unload RMariaDB

# Option 2
db <- rocker::newDB()
db$setupDriver(
  drv = RMariaDB::MariaDB(),
  host = "127.0.0.1", port = "3306", dbname = "mydb", user = "root", password = "password"
)
#> [RMariaDB | 127.0.0.1 | 3306 | mydb] Dctr Driver load RMariaDB
db$unloadDriver()
#> [RMariaDB | 127.0.0.1 | 3306 | mydb] dctr Driver unload RMariaDB
```

## Database connection

### About the following examples

Before running the following examples this code block needs to be executed first.
*(pre code block)*

```R
# New database handling object
db <- rocker::newDB()

# Setup SQLite database
db$setupSQLite(dbname = tempfile())
#> [RSQLite | tempfile] Dctr Driver load RSQLite

# Open connection
db$connect()
#> [RSQLite | tempfile] DCtr Database connected

# Create table for testing
db$writeTable("iris", iris)

# Close connection
db$disconnect()
#> [RSQLite | tempfile] Dctr Database disconnected
```

After running the following examples this code block needs to be executed.
*(post code block)*

```R
# Reset database handling object
db$unloadDriver()
#> [RSQLite | tempfile] dctr Driver unload RSQLite
```

### Different ways to connect and to get data

#### Example 1

Get query with automatic connection / disconnection.
*(do also run pre and post code block)*

```R
# Get query
output <- db$getQuery("SELECT * FROM iris;")
#> [RSQLite | tempfile] DCtr Database connected
#> [RSQLite | tempfile] DCtR Send query 19 characters
#> [RSQLite | tempfile] DCtR Fetch rows all -> Received 150 rows, 5 columns, 7440 bytes
#> [RSQLite | tempfile] DCtR Rows fetched 150
#> [RSQLite | tempfile] DCtR Has completed yes
#> [RSQLite | tempfile] DCtr Clear result
#> [RSQLite | tempfile] Dctr Database disconnected
```

Get query with automatic connection / disconnection.
*(full example; including pre and post code blocks)*

```R
# New database handling object
db <- rocker::newDB()

# Setup SQLite database
db$setupSQLite(dbname = tempfile())
#> [RSQLite | tempfile] Dctr Driver load RSQLite

# Open connection
db$connect()
#> [RSQLite | tempfile] DCtr Database connected

# Create table for testing
db$writeTable("iris", iris)

# Close connection
db$disconnect()
#> [RSQLite | tempfile] Dctr Database disconnected

# Get query
output <- db$getQuery("SELECT * FROM iris;")
#> [RSQLite | tempfile] DCtr Database connected
#> [RSQLite | tempfile] DCtR Send query 19 characters
#> [RSQLite | tempfile] DCtR Fetch rows all -> Received 150 rows, 5 columns, 7440 bytes
#> [RSQLite | tempfile] DCtR Rows fetched 150
#> [RSQLite | tempfile] DCtR Has completed yes
#> [RSQLite | tempfile] DCtr Clear result
#> [RSQLite | tempfile] Dctr Database disconnected

# Reset database handling object
db$unloadDriver()
#> [RSQLite | tempfile] dctr Driver unload RSQLite
```

#### Example 2

Get query with manual connection / disconnection.
*(do also run pre and post code block)*

```R
# Open connection
db$connect()
#> [RSQLite | tempfile] DCtr Database connected

# Get query 1
output1 <- db$getQuery("SELECT * FROM iris;")
#> [RSQLite | tempfile] DCtR Send query 19 characters
#> [RSQLite | tempfile] DCtR Fetch rows all -> Received 150 rows, 5 columns, 7440 bytes
#> [RSQLite | tempfile] DCtR Rows fetched 150
#> [RSQLite | tempfile] DCtR Has completed yes
#> [RSQLite | tempfile] DCtr Clear result

# Get query 2
output2 <- db$getQuery("SELECT * FROM iris;", 60)
#> [RSQLite | tempfile] DCtR Send query 19 characters
#> [RSQLite | tempfile] DCtR Fetch rows 60 -> Received 60 rows, 5 columns, 3776 bytes
#> [RSQLite | tempfile] DCtR Rows fetched 60
#> [RSQLite | tempfile] DCtR Has completed no
#> [RSQLite | tempfile] DCtR Fetch rows 60 -> Received 60 rows, 5 columns, 3784 bytes
#> [RSQLite | tempfile] DCtR Rows fetched 120
#> [RSQLite | tempfile] DCtR Has completed no
#> [RSQLite | tempfile] DCtR Fetch rows 60 -> Received 30 rows, 5 columns, 2520 bytes
#> [RSQLite | tempfile] DCtR Rows fetched 150
#> [RSQLite | tempfile] DCtR Has completed yes
#> [RSQLite | tempfile] DCtr Clear result

# Close connection
db$disconnect()
#> [RSQLite | tempfile] Dctr Database disconnected
```

#### Example 3

Function getQuery() is a combination of functions sendQuery(), fetch() and clearResult().
*(do also run pre and post code block)*

```R
# Open connection
db$connect()
#> [RSQLite | tempfile] DCtr Database connected

# Send query
db$sendQuery("SELECT * FROM iris;")
#> [RSQLite | tempfile] DCtR Send query 19 characters

# Fetch result
output <- db$fetch()
#> [RSQLite | tempfile] DCtR Fetch rows all -> Received 150 rows, 5 columns, 7440 bytes

# Clean up result
db$clearResult()
# [RSQLite | tempfile] DCtr Clear result

# Close connection
db$disconnect()
#> [RSQLite | tempfile] Dctr Database disconnected
```

## Password storage

Some efforts were undertaken to encrypt and to protect the password in the private area of the class. The class stores the password hidden and inaccessible. **Please let me know, in case you discover a way how to access the password!**

```R
# New database handling object
db <- rocker::newDB()

# Setup PostgreSQL database with stored password (password and user are hidden - default behavior)
db$setupDriver(
  RPostgres::Postgres(),
  host = "127.0.0.1", port = "5432", dbname = "mydb", user = "postgres", password = "password",
  protect = c("password", "user")
)
#> [RPostgres | 127.0.0.1 | 5432 | mydb] Dctr Driver load RPostgres

# Open connection 1; Password is stored in the class and does not need to be provided.
db$connect()
#> [RPostgres | 127.0.0.1 | 5432 | mydb] DCtr Database connected

# Get query 1
output1 <- db$getQuery("SELECT * FROM iris;")
#> [RPostgres | 127.0.0.1 | 5432 | mydb] DCtR Send query 19 characters
#> [RPostgres | 127.0.0.1 | 5432 | mydb] DCtR Fetch rows all -> Received 150 rows, 5 columns, 7440 bytes
#> [RPostgres | 127.0.0.1 | 5432 | mydb] DCtR Rows fetched 150
#> [RPostgres | 127.0.0.1 | 5432 | mydb] DCtR Has completed yes
#> [RPostgres | 127.0.0.1 | 5432 | mydb] DCtr Clear result

# Close connection 1
db$disconnect()
#> [RPostgres | 127.0.0.1 | 5432 | mydb] Dctr Database disconnected

# Open connection 2; Password is stored in the class and does not need to be provided.
db$connect()
#> [RPostgres | 127.0.0.1 | 5432 | mydb] DCtr Database connected

# Get query 2
output2 <- db$getQuery("SELECT * FROM iris;")
#> [RPostgres | 127.0.0.1 | 5432 | mydb] DCtR Send query 19 characters
#> [RPostgres | 127.0.0.1 | 5432 | mydb] DCtR Fetch rows all -> Received 150 rows, 5 columns, 7440 bytes
#> [RPostgres | 127.0.0.1 | 5432 | mydb] DCtR Rows fetched 150
#> [RPostgres | 127.0.0.1 | 5432 | mydb] DCtR Has completed yes
#> [RPostgres | 127.0.0.1 | 5432 | mydb] DCtr Clear result

# Close connection 2
db$disconnect()
#> [RPostgres | 127.0.0.1 | 5432 | mydb] Dctr Database disconnected

# Reset database handling object
db$unloadDriver()
#> [RPostgres | 127.0.0.1 | 5432 | mydb] dctr Driver unload RPostgres
```

In case you do not want to store the password in the class, you will need to provide it each time a connection is opened.

```R
# New database handling object
db <- rocker::newDB()

# Setup PostgreSQL database without stored password
db$setupDriver(
  RPostgres::Postgres(),
  host = "127.0.0.1", port = "5432", dbname = "mydb", user = "postgres"
)
#> [RPostgres | 127.0.0.1 | 5432 | mydb] Dctr Driver load RPostgres

# Open connection 1; Password needs to be provided.
db$connect(password = "password")
#> [RPostgres | 127.0.0.1 | 5432 | mydb] DCtr Database connected

# Get query 1
output1 <- db$getQuery("SELECT * FROM iris;")
#> [RPostgres | 127.0.0.1 | 5432 | mydb] DCtR Send query 19 characters
#> [RPostgres | 127.0.0.1 | 5432 | mydb] DCtR Fetch rows all -> Received 150 rows, 5 columns, 7440 bytes
#> [RPostgres | 127.0.0.1 | 5432 | mydb] DCtR Rows fetched 150
#> [RPostgres | 127.0.0.1 | 5432 | mydb] DCtR Has completed yes
#> [RPostgres | 127.0.0.1 | 5432 | mydb] DCtr Clear result

# Close connection 1
db$disconnect()
#> [RPostgres | 127.0.0.1 | 5432 | mydb] Dctr Database disconnected

# Open connection 2; Password needs to be provided.
db$connect(password = "password")
#> [RPostgres | 127.0.0.1 | 5432 | mydb] DCtr Database connected

# Get query 2
output2 <- db$getQuery("SELECT * FROM iris;")
#> [RPostgres | 127.0.0.1 | 5432 | mydb] DCtR Send query 19 characters
#> [RPostgres | 127.0.0.1 | 5432 | mydb] DCtR Fetch rows all -> Received 150 rows, 5 columns, 7440 bytes
#> [RPostgres | 127.0.0.1 | 5432 | mydb] DCtR Rows fetched 150
#> [RPostgres | 127.0.0.1 | 5432 | mydb] DCtR Has completed yes
#> [RPostgres | 127.0.0.1 | 5432 | mydb] DCtr Clear result

# Close connection 2
db$disconnect()
#> [RPostgres | 127.0.0.1 | 5432 | mydb] Dctr Database disconnected

# Reset database handling object
db$unloadDriver()
#> [RPostgres | 127.0.0.1 | 5432 | mydb] dctr Driver unload RPostgres
```

## 'DBI' objects

'rocker' class encapsulates the 'DBI' objects driver, connection and result.
If required, these objects can be directly used with 'DBI' functions.
**However, it is recommended to use this option with care. Direct usage of 'DBI' functions, may disrupt proper function of 'rocker' class. Many 'DBI' functions are implemented in 'rocker' class. Whenever possible, use the 'rocker' class functions.**

DBIDriver-class

```R
# New database handling object
db <- rocker::newDB()
db$.drv
#> NULL
db$.con
#> NULL
db$.res
#> NULL

# Setup SQLite database
db$setupSQLite()
#> [RSQLite | :memory:] Dctr Driver load RSQLite

# 'DBI' DBIDriver-class
db$.drv
#> <SQLiteDriver>

# Direct usage of 'DBI' function on rocker class
DBI::dbIsValid(db$.drv)
#> TRUE

```

DBIConnection-class

```R
# # Open connection
db$connect()
#> [RSQLite | :memory:] DCtr Database connected

# 'DBI' DBIConnection-class
db$.con
#> <SQLiteConnection>
#>   Path: :memory:
#>   Extensions: TRUE

# Direct usage of 'DBI' function on rocker class
DBI::dbIsValid(db$.con)
#> TRUE
```

DBIResult-class

```R
# Create table for testing
db$writeTable("iris", iris)

# Send query
db$sendQuery("SELECT * FROM iris;")
#> [RSQLite | :memory:] DCtR Send query 19 characters

# 'DBI' DBIResult-class
db$.res
#> <SQLiteResult>
#>   SQL  SELECT * FROM iris;
#>   ROWS Fetched: 0 [incomplete]
#>        Changed: 0

# Direct usage of 'DBI' function on rocker class
DBI::dbIsValid(db$.res)
#> TRUE
```

Clean up

```R
# Clean up result
db$clearResult()
#> [RSQLite | :memory:] DCtr Clear result
db$.res
#> NULL

# Close connection
db$disconnect()
#> [RSQLite | :memory:] Dctr Database disconnected
db$.con
#> NULL

# Reset database handling object
db$unloadDriver()
#> [RSQLite | :memory:] dctr Driver unload RSQLite
db$.drv
#> NULL
```

## Transaction

Setup database and a table with 32 rows.

```R
# New database handling object
db <- rocker::newDB()

# Setup SQLite database
db$setupSQLite()
#> [RSQLite | :memory:] Dctr Driver load RSQLite

# Open connection
db$connect()
#> [RSQLite | tempfile] DCtr Database connected

# Create table for testing
db$writeTable("mtcars", mtcars)

# Get query -> 32 rows
output <- db$getQuery("SELECT * FROM mtcars;")
#> [RSQLite | :memory:] DCtR Send query 21 characters
#> [RSQLite | :memory:] DCtR Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes
#> [RSQLite | :memory:] DCtR Rows fetched 32
#> [RSQLite | :memory:] DCtR Has completed yes
#> [RSQLite | :memory:] DCtr Clear result

# Transaction indicator
db$transaction
#> FALSE
```

Starting with a table with 32 rows, begin transaction 1. Delete 15 rows and commit transaction. Operations results in a table with 17 rows.

```R
# Start transaction 1
db$begin()
#> [RSQLite | :memory:] DCTr Transaction begin

# Transaction indicator
db$transaction
#> TRUE

# Modify table -> 15 rows
AFFECTED <- db$execute("DELETE FROM mtcars WHERE gear = 3;")
#> [RSQLite | :memory:] DCTR Send statement 34 characters
#> [RSQLite | :memory:] DCTR Rows affected 15
#> [RSQLite | :memory:] DCTr Clear result

# Commit transaction 1
db$commit()
#> [RSQLite | :memory:] DCtr Transaction commit

# Transaction indicator
db$transaction
#> FALSE

# Get query -> 17 rows
output <- db$getQuery("SELECT * FROM mtcars;")
#> [RSQLite | :memory:] DCtR Send query 21 characters
#> [RSQLite | :memory:] DCtR Fetch rows all -> Received 17 rows, 11 columns, 3504 bytes
#> [RSQLite | :memory:] DCtR Rows fetched 17
#> [RSQLite | :memory:] DCtR Has completed yes
#> [RSQLite | :memory:] DCtr Clear result
```

Starting with a table with 17 rows, begin transaction 2. Delete 5 rows and rollback transaction. Operations results in a table with 17 rows.

```R
# Start transaction 2
db$begin()
#> [RSQLite | :memory:] DCTr Transaction begin

# Transaction indicator
db$transaction
#> TRUE

# Modify table -> 5 rows
AFFECTED <- db$execute("DELETE FROM mtcars WHERE gear = 5;")
#> [RSQLite | :memory:] DCTR Send statement 34 characters
#> [RSQLite | :memory:] DCTR Rows affected 5
#> [RSQLite | :memory:] DCTr Clear result

# Rollback transaction 2
db$rollback()
#> [RSQLite | :memory:] DCtr Transaction rollback

# Transaction indicator
db$transaction
#> FALSE

# Get query -> 17 rows
output <- db$getQuery("SELECT * FROM mtcars;")
#> [RSQLite | :memory:] DCtR Send query 21 characters
#> [RSQLite | :memory:] DCtR Fetch rows all -> Received 17 rows, 11 columns, 3504 bytes
#> [RSQLite | :memory:] DCtR Rows fetched 17
#> [RSQLite | :memory:] DCtR Has completed yes
#> [RSQLite | :memory:] DCtr Clear result
```

Clean up.

```R
# Close connection
db$disconnect()
#> [RSQLite | :memory:] Dctr Database disconnected

# Reset database handling object
db$unloadDriver()
#> [RSQLite | :memory:] dctr Driver unload RSQLite
```

## Further help

Please read the documentation of 'rocker' class.

```R
help(rocker)
```

Reading of 'DBI' package documentation is also recommended.

* [CRAN](https://cran.r-project.org/package=DBI)
* [GitHub](https://github.com/r-dbi/DBI)
