
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rocker <img src='man/figures/logo.png' align="right" height="138" />

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/rocker)](https://cran.r-project.org/package=rocker)
[![GitHub
version](https://img.shields.io/badge/devel%20version-0.1.2.9011-yellow.svg)](https://github.com/nikolaus77/rocker)
[![R-CMD-check](https://github.com/nikolaus77/rocker/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/nikolaus77/rocker/actions/workflows/check-standard.yaml)
[![License:
MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
<!-- badges: end -->

‘R6’ class interface for handling database connections using ‘DBI’
package as backend. The class allows handling of connections to
e.g. PostgreSQL, MariaDB and SQLite. The purpose is having an intuitive
object allowing straightforward handling of databases.

## Installation

Installation of current released version from CRAN.

``` r
install.packages("rocker")
```

Installation of current development version from GitHub.

``` r
install.packages("devtools")
devtools::install_github("nikolaus77/rocker")
```

## New ‘rocker’ class object

Create new ‘rocker’ database handling object.

Option 1

``` r
db <- rocker::newDB() # New database handling object
#> 5J08VMV12CW | dctr | Object id 5J08VMV12CW
```

Option 2

``` r
db <- rocker::rocker$new() # New database handling object
#> 5J08VMV12EC | dctr | Object id 5J08VMV12EC
```

## Additional packages and database types

The listed packages are required for some functions of ‘rocker’.

### ‘crayon’ package

The package is required for colored terminal output. If missing terminal
output is monochrome.

``` r
install.packages("crayon")
```

Controlling terminal output.

``` r
db <- rocker::newDB() # New database handling object
#> 5J08VMV12G0 | dctr | Object id 5J08VMV12G0
db$verbose <- FALSE # Terminal output off
db$verbose <- TRUE # Terminal output on (default)
```

Structure of terminal output.

    5J08UQZ6E00 | Dctr | Driver load RSQLite

    5J08UQZ6E00                              = Object ID
                  D                          = Driver     (D = loaded,    d = not set)
                   c                         = Connection (C = opened,    c = closed)
                    t                        = Transation (T = active,    t = no tranastion)
                     r                       = Result     (R = available, r = no result)
                         Driver load RSQLite = Message text

### ‘RSQLite’ package

Package for handling SQLite database connections. It is required for the
setupSQLite() function of ‘rocker’ class.

``` r
install.packages("RSQLite")
```

#### Setup database

Option 1

``` r
db <- rocker::newDB() # New database handling object
#> 5J08VMV12I0 | dctr | Object id 5J08VMV12I0
db$setupSQLite( # Setup SQLite database
  dbname = ":memory:"
)
#> 5J08VMV12I0 | Dctr | Driver load RSQLite
db$unloadDriver() # Reset database handling object
#> 5J08VMV12I0 | dctr | Driver unload RSQLite
```

Option 2

``` r
db <- rocker::newDB() # New database handling object
#> 5J08VMV12JC | dctr | Object id 5J08VMV12JC
db$setupDriver( # Setup SQLite database
  drv = RSQLite::SQLite(),
  dbname = ":memory:"
)
#> 5J08VMV12JC | Dctr | Driver load RSQLite
db$unloadDriver() # Reset database handling object
#> 5J08VMV12JC | dctr | Driver unload RSQLite
```

### ‘RPostgres’ package

Package for handling PostgreSQL database connections. It is required for
the setupPostgreSQL() function of ‘rocker’ class.

``` r
install.packages("RPostgres")
```

#### Setup database

Option 1

``` r
db <- rocker::newDB() # New database handling object
#> 5J08VMV12LS | dctr | Object id 5J08VMV12LS
db$setupPostgreSQL( # Setup PostgreSQL database
  host = "127.0.0.1", port = "5432", dbname = "mydb",
  user = "postgres", password = "password"
)
#> 5J08VMV12LS | Dctr | Driver load RPostgres
db$unloadDriver() # Reset database handling object
#> 5J08VMV12LS | dctr | Driver unload RPostgres
```

Option 2

``` r
db <- rocker::newDB() # New database handling object
#> 5J08VMV12NC | dctr | Object id 5J08VMV12NC
db$setupDriver( # Setup PostgreSQL database
  drv = RPostgres::Postgres(),
  host = "127.0.0.1", port = "5432", dbname = "mydb",
  user = "postgres", password = "password"
)
#> 5J08VMV12NC | Dctr | Driver load RPostgres
db$unloadDriver() # Reset database handling object
#> 5J08VMV12NC | dctr | Driver unload RPostgres
```

### ‘RMariaDB’ package

Package for handling MariaDB and MySQL database connections. It is
required for the setupMariaDB() function of ‘rocker’ class.

``` r
install.packages("RMariaDB")
```

#### Setup database

Option 1

``` r
db <- rocker::newDB() # New database handling object
#> 5J08VMV12PK | dctr | Object id 5J08VMV12PK
db$setupMariaDB( # Setup MariaDB database
  host = "127.0.0.1", port = "3306", dbname = "mydb",
  user = "root", password = "password"
)
#> 5J08VMV12PK | Dctr | Driver load RMariaDB
db$unloadDriver() # Reset database handling object
#> 5J08VMV12PK | dctr | Driver unload RMariaDB
```

Option 2

``` r
db <- rocker::newDB() # New database handling object
#> 5J08VMV12RC | dctr | Object id 5J08VMV12RC
db$setupDriver( # Setup MariaDB database
  drv = RMariaDB::MariaDB(),
  host = "127.0.0.1", port = "3306", dbname = "mydb",
  user = "root", password = "password"
)
#> 5J08VMV12RC | Dctr | Driver load RMariaDB
db$unloadDriver() # Reset database handling object
#> 5J08VMV12RC | dctr | Driver unload RMariaDB
```

## Database connection

### About the following examples

Before running the following examples, this code block <sup>*(pre code
block)*</sup> needs to be executed first.

``` r
db <- rocker::newDB() # New database handling object
#> 5J08VMV12SS | dctr | Object id 5J08VMV12SS
db$setupSQLite(dbname = tempfile()) # Setup SQLite database
#> 5J08VMV12SS | Dctr | Driver load RSQLite
db$connect() # Open connection
#> 5J08VMV12SS | DCtr | Database connected
db$writeTable("mtcars", mtcars) # Create table for testing
#> 5J08VMV12SS | DCtr | Write table mtcars columns mpg, cyl, disp, hp, drat, wt, qsec, vs, am, gear, carb rows 32
db$disconnect() # Close connection
#> 5J08VMV12SS | Dctr | Database disconnected
```

After running the following examples, this code block <sup>*(post code
block)*</sup> needs to be executed.

``` r
db$unloadDriver() # Reset database handling object
#> 5J08VMV12SS | dctr | Driver unload RSQLite
```

### Different ways to connect and to get data

#### Example 1

Get query with automatic connection / disconnection. <sup>*(Do also run
pre and post code blocks.)*</sup>

``` r
output <- db$getQuery("SELECT * FROM mtcars;") # Get query
#> 5J08VMV12X8 | DCtr | Database connected 
#> 5J08VMV12X8 | DCtR | Send query 21 characters 
#> 5J08VMV12X8 | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> 5J08VMV12X8 | DCtR | Rows fetched 32 
#> 5J08VMV12X8 | DCtR | Has completed yes 
#> 5J08VMV12X8 | DCtr | Clear result 
#> 5J08VMV12X8 | Dctr | Database disconnected
```

Get query with automatic connection / disconnection. <sup>*(full
example; including pre and post code blocks)*</sup>

``` r
db <- rocker::newDB() # New database handling object
#> 5J08VMV1320 | dctr | Object id 5J08VMV1320
db$setupSQLite(dbname = tempfile()) # Setup SQLite database
#> 5J08VMV1320 | Dctr | Driver load RSQLite
db$connect() # Open connection
#> 5J08VMV1320 | DCtr | Database connected
db$writeTable("mtcars", mtcars) # Create table for testing
#> 5J08VMV1320 | DCtr | Write table mtcars columns mpg, cyl, disp, hp, drat, wt, qsec, vs, am, gear, carb rows 32
db$disconnect() # Close connection
#> 5J08VMV1320 | Dctr | Database disconnected
output <- db$getQuery("SELECT * FROM mtcars;") # Get query
#> 5J08VMV1320 | DCtr | Database connected 
#> 5J08VMV1320 | DCtR | Send query 21 characters 
#> 5J08VMV1320 | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> 5J08VMV1320 | DCtR | Rows fetched 32 
#> 5J08VMV1320 | DCtR | Has completed yes 
#> 5J08VMV1320 | DCtr | Clear result 
#> 5J08VMV1320 | Dctr | Database disconnected
db$unloadDriver() # Reset database handling object
#> 5J08VMV1320 | dctr | Driver unload RSQLite
```

#### Example 2

Get query with manual connection / disconnection. <sup>*(Do also run pre
and post code blocks.)*</sup>

``` r
db$connect() # Open connection
#> 5J08VMV133W | DCtr | Database connected
output1 <- db$getQuery("SELECT * FROM mtcars;") # Get query 1
#> 5J08VMV133W | DCtR | Send query 21 characters 
#> 5J08VMV133W | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> 5J08VMV133W | DCtR | Rows fetched 32 
#> 5J08VMV133W | DCtR | Has completed yes 
#> 5J08VMV133W | DCtr | Clear result
output2 <- db$getQuery("SELECT * FROM mtcars;", 15) # Get query 2
#> 5J08VMV133W | DCtR | Send query 21 characters 
#> 5J08VMV133W | DCtR | Fetch rows 15 -> Received 15 rows, 11 columns, 3416 bytes 
#> 5J08VMV133W | DCtR | Rows fetched 15 
#> 5J08VMV133W | DCtR | Has completed no 
#> 5J08VMV133W | DCtR | Fetch rows 15 -> Received 15 rows, 11 columns, 3416 bytes 
#> 5J08VMV133W | DCtR | Rows fetched 30 
#> 5J08VMV133W | DCtR | Has completed no 
#> 5J08VMV133W | DCtR | Fetch rows 15 -> Received 2 rows, 11 columns, 2184 bytes 
#> 5J08VMV133W | DCtR | Rows fetched 32 
#> 5J08VMV133W | DCtR | Has completed yes 
#> 5J08VMV133W | DCtr | Clear result
db$disconnect() # Close connection
#> 5J08VMV133W | Dctr | Database disconnected
```

#### Example 3

Function getQuery() is a combination of functions sendQuery(), fetch()
and clearResult(). <sup>*(Do also run pre and post code blocks.)*</sup>

``` r
db$connect() # Open connection
#> 5J08VMV137O | DCtr | Database connected
db$sendQuery("SELECT * FROM mtcars;") # Send query
#> 5J08VMV137O | DCtR | Send query 21 characters
output <- db$fetch() # Fetch result
#> 5J08VMV137O | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes
db$clearResult() # Clean up result
#> 5J08VMV137O | DCtr | Clear result
db$disconnect() # Close connection
#> 5J08VMV137O | Dctr | Database disconnected
```

## Password storage

Some efforts were undertaken to encrypt and to protect the password in
the private area of the class. The class stores the password hidden and
inaccessible. **Please let me know, in case you discover a way how to
access the password!**

``` r
db <- rocker::newDB() # New database handling object
#> 5J08VMV13AW | dctr | Object id 5J08VMV13AW
db$setupDriver( # Setup PostgreSQL database with stored password (password and user are hidden - default behavior)
  RPostgres::Postgres(),
  host = "127.0.0.1", port = "5432", dbname = "mydb",
  user = "postgres", password = "password",
  protect = c("password", "user")
)
#> 5J08VMV13AW | Dctr | Driver load RPostgres
db$connect() # Open connection 1; Password is stored in the class and does not need to be provided.
#> 5J08VMV13AW | DCtr | Database connected
output1 <- db$getQuery("SELECT * FROM mtcars;") # Get query 1
#> 5J08VMV13AW | DCtR | Send query 21 characters 
#> 5J08VMV13AW | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> 5J08VMV13AW | DCtR | Rows fetched 32 
#> 5J08VMV13AW | DCtR | Has completed yes 
#> 5J08VMV13AW | DCtr | Clear result
db$disconnect() # Close connection 1
#> 5J08VMV13AW | Dctr | Database disconnected
db$connect() # Open connection 2; Password is stored in the class and does not need to be provided.
#> 5J08VMV13AW | DCtr | Database connected
output2 <- db$getQuery("SELECT * FROM mtcars;") # Get query 2
#> 5J08VMV13AW | DCtR | Send query 21 characters 
#> 5J08VMV13AW | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> 5J08VMV13AW | DCtR | Rows fetched 32 
#> 5J08VMV13AW | DCtR | Has completed yes 
#> 5J08VMV13AW | DCtr | Clear result
db$disconnect() # Close connection 2
#> 5J08VMV13AW | Dctr | Database disconnected
db$unloadDriver() # Reset database handling object
#> 5J08VMV13AW | dctr | Driver unload RPostgres
```

In case you do not want to store the password in the class, you will
need to provide it each time a connection is opened.

``` r
db <- rocker::newDB() # New database handling object
#> 5J08VMV13R4 | dctr | Object id 5J08VMV13R4
db$setupDriver( # Setup PostgreSQL database without stored password
  RPostgres::Postgres(),
  host = "127.0.0.1", port = "5432", dbname = "mydb",
  user = "postgres"
)
#> 5J08VMV13R4 | Dctr | Driver load RPostgres
db$connect(password = "password") # Open connection 1; Password needs to be provided.
#> 5J08VMV13R4 | DCtr | Database connected
output1 <- db$getQuery("SELECT * FROM mtcars;") # Get query 1
#> 5J08VMV13R4 | DCtR | Send query 21 characters 
#> 5J08VMV13R4 | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> 5J08VMV13R4 | DCtR | Rows fetched 32 
#> 5J08VMV13R4 | DCtR | Has completed yes 
#> 5J08VMV13R4 | DCtr | Clear result
db$disconnect() # Close connection 1
#> 5J08VMV13R4 | Dctr | Database disconnected
db$connect(password = "password") # Open connection 2; Password needs to be provided.
#> 5J08VMV13R4 | DCtr | Database connected
output2 <- db$getQuery("SELECT * FROM mtcars;") # Get query 2
#> 5J08VMV13R4 | DCtR | Send query 21 characters 
#> 5J08VMV13R4 | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> 5J08VMV13R4 | DCtR | Rows fetched 32 
#> 5J08VMV13R4 | DCtR | Has completed yes 
#> 5J08VMV13R4 | DCtr | Clear result
db$disconnect() # Close connection 2
#> 5J08VMV13R4 | Dctr | Database disconnected
db$unloadDriver() # Reset database handling object
#> 5J08VMV13R4 | dctr | Driver unload RPostgres
```

## ‘DBI’ objects

‘rocker’ class encapsulates the ‘DBI’ objects driver, connection and
result. If required, these objects can be directly used with ‘DBI’
functions. **However, it is recommended to use this option with care!**
Direct usage of ‘DBI’ functions, may disrupt proper function of ‘rocker’
class. Many ‘DBI’ functions are implemented in ‘rocker’ class. Whenever
possible, use the ‘rocker’ class functions.

Prepare object

``` r
db <- rocker::newDB() # New database handling object
#> 5J08VMV13Y0 | dctr | Object id 5J08VMV13Y0
db$.drv # Empty driver
#> NULL
db$.con # Empty connection
#> NULL
db$.res # Empty result
#> NULL
```

**DBIDriver-class**

``` r
db$setupSQLite() # Setup SQLite database
#> 5J08VMV13Y0 | Dctr | Driver load RSQLite
db$.drv # 'DBI' DBIDriver-class
#> <SQLiteDriver>
```

``` r
DBI::dbGetInfo(db$.drv) # Direct usage of 'DBI' function on rocker class
#> $driver.version
#> [1] '2.2.8'
#> 
#> $client.version
#> [1] '3.36.0'
```

**DBIConnection-class**

``` r
db$connect() # Open connection
#> 5J08VMV13Y0 | DCtr | Database connected
db$.con # 'DBI' DBIConnection-class
#> <SQLiteConnection>
#>   Path: :memory:
#>   Extensions: TRUE
```

``` r
DBI::dbGetInfo(db$.con) # Direct usage of 'DBI' function on rocker class
#> $db.version
#> [1] "3.36.0"
#> 
#> $dbname
#> [1] ":memory:"
#> 
#> $username
#> [1] NA
#> 
#> $host
#> [1] NA
#> 
#> $port
#> [1] NA
```

Prepare table

``` r
db$writeTable("mtcars", mtcars) # Create table for testing
#> 5J08VMV13Y0 | DCtr | Write table mtcars columns mpg, cyl, disp, hp, drat, wt, qsec, vs, am, gear, carb rows 32
```

**DBIResult-class**

``` r
db$sendQuery("SELECT * FROM mtcars;") # Send query
#> 5J08VMV13Y0 | DCtR | Send query 21 characters
db$.res # 'DBI' DBIResult-class
#> <SQLiteResult>
#>   SQL  SELECT * FROM mtcars;
#>   ROWS Fetched: 0 [incomplete]
#>        Changed: 0
```

``` r
DBI::dbGetInfo(db$.res) # Direct usage of 'DBI' function on rocker class
#> $statement
#> [1] "SELECT * FROM mtcars;"
#> 
#> $row.count
#> [1] 0
#> 
#> $rows.affected
#> [1] 0
#> 
#> $has.completed
#> [1] FALSE
```

Clean up

``` r
db$clearResult() # Clean up result
#> 5J08VMV13Y0 | DCtr | Clear result
db$.res # Empty result
#> NULL
db$disconnect() # Close connection
#> 5J08VMV13Y0 | Dctr | Database disconnected
db$.con # Empty connection
#> NULL
db$unloadDriver() # Reset database handling object
#> 5J08VMV13Y0 | dctr | Driver unload RSQLite
db$.drv # Empty driver
#> NULL
```

## ‘DBI’ functions in ‘rocker’

Generally, ‘rocker’ function names are related to ‘DBI’ function names.
In ‘rocker’ functions, the leading *db* is removed.

In ‘DBI’ most functions need to be supplied with a driver
<sup>(drv)</sup>, connection <sup>(conn)</sup> or result
<sup>(res)</sup> object. In ‘rocker’, functions automatically access the
corresponding objects <sup>(.drv,</sup> <sup>.con</sup> <sup>and</sup>
<sup>.res)</sup> stored in the class.

### ‘DBI’ example

``` r
drv <- RSQLite::SQLite() # SQLite driver
DBI::dbCanConnect( # Test parameter
  drv = drv,
  dbname = ":memory:"
)
#> [1] TRUE
con <- DBI::dbConnect( # Open connection
  drv = drv,
  dbname = ":memory:"
)
DBI::dbWriteTable(con, "mtcars", mtcars) # Create table for testing
res <- DBI::dbSendQuery(con, "SELECT * FROM mtcars;") # Send query
output <- DBI::dbFetch(res) # Fetch result
DBI::dbClearResult(res) # Clean up result
DBI::dbDisconnect(con) # Close connection
DBI::dbUnloadDriver(drv) # Unload driver
```

### ‘rocker’ example

``` r
db <- rocker::newDB(verbose = FALSE) # New database handling object
db$setupDriver( # Setup SQLite database
  drv = RSQLite::SQLite(),
  dbname = ":memory:"
)
db$canConnect() # Test parameter
#> [1] TRUE
db$connect() # Open connection
db$writeTable("mtcars", mtcars) # Create table for testing
db$sendQuery("SELECT * FROM mtcars;") # Send query
output <- db$fetch() # Fetch result
db$clearResult() # Clean up result
db$disconnect() # Close connection
db$unloadDriver() # Reset database handling object
```

### List of functions

| ‘rocker’ function | Corresponding ‘DBI’ function                             | ‘DBI’ object used                 | Comment                                                                                           |
|-------------------|----------------------------------------------------------|-----------------------------------|---------------------------------------------------------------------------------------------------|
| initialize()      | *none*                                                   | *none*                            |                                                                                                   |
| print()           | *none*                                                   | *none*                            |                                                                                                   |
| setupDriver()     | *none*                                                   | *driver from appropriate package* | Usually, parameters provided to dbConnect() in ‘DBI’ are provided to setupDriver() in ‘rocker’    |
| setupPostgreSQL() | *none*                                                   | *none*                            | RPostgres::Postgres() is used with ‘rocker’ function setupDriver()                                |
| setupMariaDB()    | *none*                                                   | *none*                            | RMariaDB::MariaDB() is used with ‘rocker’ function setupDriver()                                  |
| setupSQLite()     | *none*                                                   | *none*                            | RSQLite::SQLite() is used with ‘rocker’ function setupDriver()                                    |
| unloadDriver()    | dbUnloadDriver()                                         | driver                            |                                                                                                   |
| canConnect()      | dbCanConnect()                                           | driver                            | Usually, parameters provided to dbCanConnect() in ‘DBI’ are provided to setupDriver() in ‘rocker’ |
| connect()         | dbConnect()                                              | driver                            | Usually, parameters provided to dbConnect() in ‘DBI’ are provided to setupDriver() in ‘rocker’    |
| disconnect()      | dbDisconnect()                                           | connection                        |                                                                                                   |
| sendQuery()       | dbSendQuery()                                            | connection                        |                                                                                                   |
| getQuery()        | Is **not** using dbGetQuery(), but has the same function | connection                        | Especially, combination of ‘rocker’ functions sendQuery(), fetch() and clearResult()              |
| sendStatement()   | dbSendStatement()                                        | connection                        |                                                                                                   |
| execute()         | Is **not** using dbExecute(), but has the same function  | connection                        | Especially, combination of ‘rocker’ functions sendStatement() and clearResult()                   |
| fetch()           | dbFetch()                                                | result                            |                                                                                                   |
| hasCompleted()    | dbHasCompleted()                                         | result                            |                                                                                                   |
| getRowsAffected() | dbGetRowsAffected()                                      | result                            |                                                                                                   |
| getRowCount()     | dbGetRowCount()                                          | result                            |                                                                                                   |
| columnInfo()      | dbColumnInfo()                                           | result                            |                                                                                                   |
| getStatement()    | dbGetStatement()                                         | result                            |                                                                                                   |
| clearResult()     | dbClearResult()                                          | result                            |                                                                                                   |
| begin()           | dbBegin()                                                | connection                        |                                                                                                   |
| commit()          | dbCommit()                                               | connection                        |                                                                                                   |
| rollback()        | dbRollback()                                             | connection                        |                                                                                                   |
| getInfoDrv()      | dbGetInfo()                                              | driver                            |                                                                                                   |
| getInfoCon()      | dbGetInfo()                                              | connection                        |                                                                                                   |
| getInfoRes()      | dbGetInfo()                                              | result                            |                                                                                                   |
| isValidDrv()      | dbIsValid()                                              | driver                            |                                                                                                   |
| isValidCon()      | dbIsValid()                                              | connection                        |                                                                                                   |
| isValidRes()      | dbIsValid()                                              | result                            |                                                                                                   |
| createTable()     | dbCreateTable()                                          | connection                        |                                                                                                   |
| appendTable()     | dbAppendTable()                                          | connection                        |                                                                                                   |
| writeTable()      | dbWriteTable                                             | connection                        |                                                                                                   |
| readTable()       | dbReadTable                                              | connection                        |                                                                                                   |
| removeTable()     | dbRemoveTable()                                          | connection                        |                                                                                                   |
| existsTable()     | dbExistsTable()                                          | connection                        |                                                                                                   |
| listFields()      | dbListFields()                                           | connection                        |                                                                                                   |
| listObjects()     | dbListObjects()                                          | connection                        |                                                                                                   |
| listTables()      | dbListTables()                                           | connection                        |                                                                                                   |

## Transaction

Setup database and a table with 32 rows.

``` r
db <- rocker::newDB() # New database handling object
#> 5J08VMV149W | dctr | Object id 5J08VMV149W
db$setupSQLite() # Setup SQLite database
#> 5J08VMV149W | Dctr | Driver load RSQLite
db$connect() # Open connection
#> 5J08VMV149W | DCtr | Database connected
db$writeTable("mtcars", mtcars) # Create table for testing
#> 5J08VMV149W | DCtr | Write table mtcars columns mpg, cyl, disp, hp, drat, wt, qsec, vs, am, gear, carb rows 32
output <- db$getQuery("SELECT * FROM mtcars;") # Get query -> 32 rows
#> 5J08VMV149W | DCtR | Send query 21 characters 
#> 5J08VMV149W | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> 5J08VMV149W | DCtR | Rows fetched 32 
#> 5J08VMV149W | DCtR | Has completed yes 
#> 5J08VMV149W | DCtr | Clear result
db$transaction # Transaction indicator
#> [1] FALSE
```

Starting with a table with 32 rows, begin transaction 1. Delete 15 rows
and commit transaction. Operations results in a table with 17 rows.

``` r
db$begin() # Start transaction 1
#> 5J08VMV149W | DCTr | Transaction begin
db$transaction # Transaction indicator
#> [1] TRUE
AFFECTED <- db$execute("DELETE FROM mtcars WHERE gear = 3;") # Modify table -> 15 rows
#> 5J08VMV149W | DCTR | Send statement 34 characters 
#> 5J08VMV149W | DCTR | Rows affected 15 
#> 5J08VMV149W | DCTr | Clear result
db$commit() # Commit transaction 1
#> 5J08VMV149W | DCtr | Transaction commit
db$transaction # Transaction indicator
#> [1] FALSE
output <- db$getQuery("SELECT * FROM mtcars;") # Get query -> 17 rows
#> 5J08VMV149W | DCtR | Send query 21 characters 
#> 5J08VMV149W | DCtR | Fetch rows all -> Received 17 rows, 11 columns, 3504 bytes 
#> 5J08VMV149W | DCtR | Rows fetched 17 
#> 5J08VMV149W | DCtR | Has completed yes 
#> 5J08VMV149W | DCtr | Clear result
```

Starting with a table with 17 rows, begin transaction 2. Delete 5 rows
and rollback transaction. Operations results in a table with 17 rows.

``` r
db$begin() # Start transaction 2
#> 5J08VMV149W | DCTr | Transaction begin
db$transaction # Transaction indicator
#> [1] TRUE
AFFECTED <- db$execute("DELETE FROM mtcars WHERE gear = 5;") # Modify table -> 5 rows
#> 5J08VMV149W | DCTR | Send statement 34 characters 
#> 5J08VMV149W | DCTR | Rows affected 5 
#> 5J08VMV149W | DCTr | Clear result
output <- db$getQuery("SELECT * FROM mtcars;") # Get query -> 12 rows
#> 5J08VMV149W | DCTR | Send query 21 characters 
#> 5J08VMV149W | DCTR | Fetch rows all -> Received 12 rows, 11 columns, 3416 bytes 
#> 5J08VMV149W | DCTR | Rows fetched 12 
#> 5J08VMV149W | DCTR | Has completed yes 
#> 5J08VMV149W | DCTr | Clear result
db$rollback() # Rollback transaction 2
#> 5J08VMV149W | DCtr | Transaction rollback
db$transaction # Transaction indicator
#> [1] FALSE
output <- db$getQuery("SELECT * FROM mtcars;") # Get query -> 17 rows
#> 5J08VMV149W | DCtR | Send query 21 characters 
#> 5J08VMV149W | DCtR | Fetch rows all -> Received 17 rows, 11 columns, 3504 bytes 
#> 5J08VMV149W | DCtR | Rows fetched 17 
#> 5J08VMV149W | DCtR | Has completed yes 
#> 5J08VMV149W | DCtr | Clear result
```

Clean up.

``` r
db$disconnect() # Close connection
#> 5J08VMV149W | Dctr | Database disconnected
db$unloadDriver() # Reset database handling object
#> 5J08VMV149W | dctr | Driver unload RSQLite
```

## Further help

Please read the documentation of ‘rocker’ class.

``` r
help(rocker)
```

Reading of ‘DBI’ package documentation is also recommended.

-   [CRAN](https://cran.r-project.org/package=DBI)
-   [GitHub](https://github.com/r-dbi/DBI)
