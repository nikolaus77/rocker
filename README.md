
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rocker <img src='man/figures/logo.png' align="right" height="138" />

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/rocker)](https://cran.r-project.org/package=rocker)
[![GitHub
version](https://img.shields.io/badge/devel%20version-0.1.2.9006-yellow.svg)](https://github.com/nikolaus77/rocker)
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
#> 5J08UQZASDS | dctr | Object id 5J08UQZASDS
```

Option 2

``` r
db <- rocker::rocker$new() # New database handling object
#> 5J08UQZASE8 | dctr | Object id 5J08UQZASE8
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
#> 5J08UQZASF4 | dctr | Object id 5J08UQZASF4
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
#> 5J08UQZASG8 | dctr | Object id 5J08UQZASG8
db$setupSQLite( # Setup SQLite database
  dbname = ":memory:"
)
#> 5J08UQZASG8 | Dctr | Driver load RSQLite
db$unloadDriver() # Reset database handling object
#> 5J08UQZASG8 | dctr | Driver unload RSQLite
```

Option 2

``` r
db <- rocker::newDB() # New database handling object
#> 5J08UQZASH8 | dctr | Object id 5J08UQZASH8
db$setupDriver( # Setup SQLite database
  drv = RSQLite::SQLite(),
  dbname = ":memory:"
)
#> 5J08UQZASH8 | Dctr | Driver load RSQLite
db$unloadDriver() # Reset database handling object
#> 5J08UQZASH8 | dctr | Driver unload RSQLite
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
#> 5J08UQZASIS | dctr | Object id 5J08UQZASIS
db$setupPostgreSQL( # Setup PostgreSQL database
  host = "127.0.0.1", port = "5432", dbname = "mydb",
  user = "postgres", password = "password"
)
#> 5J08UQZASIS | Dctr | Driver load RPostgres
db$unloadDriver() # Reset database handling object
#> 5J08UQZASIS | dctr | Driver unload RPostgres
```

Option 2

``` r
db <- rocker::newDB() # New database handling object
#> 5J08UQZASJK | dctr | Object id 5J08UQZASJK
db$setupDriver( # Setup PostgreSQL database
  drv = RPostgres::Postgres(),
  host = "127.0.0.1", port = "5432", dbname = "mydb",
  user = "postgres", password = "password"
)
#> 5J08UQZASJK | Dctr | Driver load RPostgres
db$unloadDriver() # Reset database handling object
#> 5J08UQZASJK | dctr | Driver unload RPostgres
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
#> 5J08UQZASKO | dctr | Object id 5J08UQZASKO
db$setupMariaDB( # Setup MariaDB database
  host = "127.0.0.1", port = "3306", dbname = "mydb",
  user = "root", password = "password"
)
#> 5J08UQZASKO | Dctr | Driver load RMariaDB
db$unloadDriver() # Reset database handling object
#> 5J08UQZASKO | dctr | Driver unload RMariaDB
```

Option 2

``` r
db <- rocker::newDB() # New database handling object
#> 5J08UQZASLC | dctr | Object id 5J08UQZASLC
db$setupDriver( # Setup MariaDB database
  drv = RMariaDB::MariaDB(),
  host = "127.0.0.1", port = "3306", dbname = "mydb",
  user = "root", password = "password"
)
#> 5J08UQZASLC | Dctr | Driver load RMariaDB
db$unloadDriver() # Reset database handling object
#> 5J08UQZASLC | dctr | Driver unload RMariaDB
```

## Database connection

### About the following examples

Before running the following examples this code block needs to be
executed first. *(pre code block)*

``` r
db <- rocker::newDB() # New database handling object
#> 5J08UQZASMW | dctr | Object id 5J08UQZASMW
db$setupSQLite(dbname = tempfile()) # Setup SQLite database
#> 5J08UQZASMW | Dctr | Driver load RSQLite
db$connect() # Open connection
#> 5J08UQZASMW | DCtr | Database connected
db$writeTable("mtcars", mtcars) # Create table for testing
#> 5J08UQZASMW | DCtr | Write table mtcars columns mpg, cyl, disp, hp, drat, wt, qsec, vs, am, gear, carb rows 32
db$disconnect() # Close connection
#> 5J08UQZASMW | Dctr | Database disconnected
```

After running the following examples this code block needs to be
executed. *(post code block)*

``` r
db$unloadDriver() # Reset database handling object
#> 5J08UQZASMW | dctr | Driver unload RSQLite
```

### Different ways to connect and to get data

#### Example 1

Get query with automatic connection / disconnection. *(do also run pre
and post code block)*

``` r
output <- db$getQuery("SELECT * FROM mtcars;") # Get query
#> 5J08UQZASQW | DCtr | Database connected 
#> 5J08UQZASQW | DCtR | Send query 21 characters 
#> 5J08UQZASQW | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> 5J08UQZASQW | DCtR | Rows fetched 32 
#> 5J08UQZASQW | DCtR | Has completed yes 
#> 5J08UQZASQW | DCtr | Clear result 
#> 5J08UQZASQW | Dctr | Database disconnected
```

Get query with automatic connection / disconnection. *(full example;
including pre and post code blocks)*

``` r
db <- rocker::newDB() # New database handling object
#> 5J08UQZASVS | dctr | Object id 5J08UQZASVS
db$setupSQLite(dbname = tempfile()) # Setup SQLite database
#> 5J08UQZASVS | Dctr | Driver load RSQLite
db$connect() # Open connection
#> 5J08UQZASVS | DCtr | Database connected
db$writeTable("mtcars", mtcars) # Create table for testing
#> 5J08UQZASVS | DCtr | Write table mtcars columns mpg, cyl, disp, hp, drat, wt, qsec, vs, am, gear, carb rows 32
db$disconnect() # Close connection
#> 5J08UQZASVS | Dctr | Database disconnected
output <- db$getQuery("SELECT * FROM mtcars;") # Get query
#> 5J08UQZASVS | DCtr | Database connected 
#> 5J08UQZASVS | DCtR | Send query 21 characters 
#> 5J08UQZASVS | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> 5J08UQZASVS | DCtR | Rows fetched 32 
#> 5J08UQZASVS | DCtR | Has completed yes 
#> 5J08UQZASVS | DCtr | Clear result 
#> 5J08UQZASVS | Dctr | Database disconnected
db$unloadDriver() # Reset database handling object
#> 5J08UQZASVS | dctr | Driver unload RSQLite
```

#### Example 2

Get query with manual connection / disconnection. *(do also run pre and
post code block)*

``` r
db$connect() # Open connection
#> 5J08UQZASXK | DCtr | Database connected
output1 <- db$getQuery("SELECT * FROM mtcars;") # Get query 1
#> 5J08UQZASXK | DCtR | Send query 21 characters 
#> 5J08UQZASXK | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> 5J08UQZASXK | DCtR | Rows fetched 32 
#> 5J08UQZASXK | DCtR | Has completed yes 
#> 5J08UQZASXK | DCtr | Clear result
output2 <- db$getQuery("SELECT * FROM mtcars;", 15) # Get query 2
#> 5J08UQZASXK | DCtR | Send query 21 characters 
#> 5J08UQZASXK | DCtR | Fetch rows 15 -> Received 15 rows, 11 columns, 3416 bytes 
#> 5J08UQZASXK | DCtR | Rows fetched 15 
#> 5J08UQZASXK | DCtR | Has completed no 
#> 5J08UQZASXK | DCtR | Fetch rows 15 -> Received 15 rows, 11 columns, 3416 bytes 
#> 5J08UQZASXK | DCtR | Rows fetched 30 
#> 5J08UQZASXK | DCtR | Has completed no 
#> 5J08UQZASXK | DCtR | Fetch rows 15 -> Received 2 rows, 11 columns, 2184 bytes 
#> 5J08UQZASXK | DCtR | Rows fetched 32 
#> 5J08UQZASXK | DCtR | Has completed yes 
#> 5J08UQZASXK | DCtr | Clear result
db$disconnect() # Close connection
#> 5J08UQZASXK | Dctr | Database disconnected
```

#### Example 3

Function getQuery() is a combination of functions sendQuery(), fetch()
and clearResult(). *(do also run pre and post code block)*

``` r
db$connect() # Open connection
#> 5J08UQZAT1K | DCtr | Database connected
db$sendQuery("SELECT * FROM mtcars;") # Send query
#> 5J08UQZAT1K | DCtR | Send query 21 characters
output <- db$fetch() # Fetch result
#> 5J08UQZAT1K | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes
db$clearResult() # Clean up result
#> 5J08UQZAT1K | DCtr | Clear result
db$disconnect() # Close connection
#> 5J08UQZAT1K | Dctr | Database disconnected
```

## Password storage

Some efforts were undertaken to encrypt and to protect the password in
the private area of the class. The class stores the password hidden and
inaccessible. **Please let me know, in case you discover a way how to
access the password!**

``` r
db <- rocker::newDB() # New database handling object
#> 5J08UQZAT4G | dctr | Object id 5J08UQZAT4G
db$setupDriver( # Setup PostgreSQL database with stored password (password and user are hidden - default behavior)
  RPostgres::Postgres(),
  host = "127.0.0.1", port = "5432", dbname = "mydb",
  user = "postgres", password = "password",
  protect = c("password", "user")
)
#> 5J08UQZAT4G | Dctr | Driver load RPostgres
db$connect() # Open connection 1; Password is stored in the class and does not need to be provided.
#> 5J08UQZAT4G | DCtr | Database connected
output1 <- db$getQuery("SELECT * FROM mtcars;") # Get query 1
#> 5J08UQZAT4G | DCtR | Send query 21 characters 
#> 5J08UQZAT4G | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> 5J08UQZAT4G | DCtR | Rows fetched 32 
#> 5J08UQZAT4G | DCtR | Has completed yes 
#> 5J08UQZAT4G | DCtr | Clear result
db$disconnect() # Close connection 1
#> 5J08UQZAT4G | Dctr | Database disconnected
db$connect() # Open connection 2; Password is stored in the class and does not need to be provided.
#> 5J08UQZAT4G | DCtr | Database connected
output2 <- db$getQuery("SELECT * FROM mtcars;") # Get query 2
#> 5J08UQZAT4G | DCtR | Send query 21 characters 
#> 5J08UQZAT4G | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> 5J08UQZAT4G | DCtR | Rows fetched 32 
#> 5J08UQZAT4G | DCtR | Has completed yes 
#> 5J08UQZAT4G | DCtr | Clear result
db$disconnect() # Close connection 2
#> 5J08UQZAT4G | Dctr | Database disconnected
db$unloadDriver() # Reset database handling object
#> 5J08UQZAT4G | dctr | Driver unload RPostgres
```

In case you do not want to store the password in the class, you will
need to provide it each time a connection is opened.

``` r
db <- rocker::newDB() # New database handling object
#> 5J08UQZATEG | dctr | Object id 5J08UQZATEG
db$setupDriver( # Setup PostgreSQL database without stored password
  RPostgres::Postgres(),
  host = "127.0.0.1", port = "5432", dbname = "mydb",
  user = "postgres"
)
#> 5J08UQZATEG | Dctr | Driver load RPostgres
db$connect(password = "password") # Open connection 1; Password needs to be provided.
#> 5J08UQZATEG | DCtr | Database connected
output1 <- db$getQuery("SELECT * FROM mtcars;") # Get query 1
#> 5J08UQZATEG | DCtR | Send query 21 characters 
#> 5J08UQZATEG | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> 5J08UQZATEG | DCtR | Rows fetched 32 
#> 5J08UQZATEG | DCtR | Has completed yes 
#> 5J08UQZATEG | DCtr | Clear result
db$disconnect() # Close connection 1
#> 5J08UQZATEG | Dctr | Database disconnected
db$connect(password = "password") # Open connection 2; Password needs to be provided.
#> 5J08UQZATEG | DCtr | Database connected
output2 <- db$getQuery("SELECT * FROM mtcars;") # Get query 2
#> 5J08UQZATEG | DCtR | Send query 21 characters 
#> 5J08UQZATEG | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> 5J08UQZATEG | DCtR | Rows fetched 32 
#> 5J08UQZATEG | DCtR | Has completed yes 
#> 5J08UQZATEG | DCtr | Clear result
db$disconnect() # Close connection 2
#> 5J08UQZATEG | Dctr | Database disconnected
db$unloadDriver() # Reset database handling object
#> 5J08UQZATEG | dctr | Driver unload RPostgres
```

## ‘DBI’ objects

‘rocker’ class encapsulates the ‘DBI’ objects driver, connection and
result. If required, these objects can be directly used with ‘DBI’
functions. **However, it is recommended to use this option with care.
Direct usage of ‘DBI’ functions, may disrupt proper function of ‘rocker’
class. Many ‘DBI’ functions are implemented in ‘rocker’ class. Whenever
possible, use the ‘rocker’ class functions.**

DBIDriver-class

``` r
db <- rocker::newDB() # New database handling object
#> 5J08UQZATJ0 | dctr | Object id 5J08UQZATJ0
db$.drv # Empty driver
#> NULL
db$.con # Empty connection
#> NULL
db$.res # Empty result
#> NULL
db$setupSQLite() # Setup SQLite database
#> 5J08UQZATJ0 | Dctr | Driver load RSQLite
db$.drv # 'DBI' DBIDriver-class
#> <SQLiteDriver>
DBI::dbGetInfo(db$.drv) # Direct usage of 'DBI' function on rocker class
#> $driver.version
#> [1] '2.2.8'
#> 
#> $client.version
#> [1] '3.36.0'
```

DBIConnection-class

``` r
db$connect() # Open connection
#> 5J08UQZATJ0 | DCtr | Database connected
db$.con # 'DBI' DBIConnection-class
#> <SQLiteConnection>
#>   Path: :memory:
#>   Extensions: TRUE
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

DBIResult-class

``` r
db$writeTable("mtcars", mtcars) # Create table for testing
#> 5J08UQZATJ0 | DCtr | Write table mtcars columns mpg, cyl, disp, hp, drat, wt, qsec, vs, am, gear, carb rows 32
db$sendQuery("SELECT * FROM mtcars;") # Send query
#> 5J08UQZATJ0 | DCtR | Send query 21 characters
db$.res # 'DBI' DBIResult-class
#> <SQLiteResult>
#>   SQL  SELECT * FROM mtcars;
#>   ROWS Fetched: 0 [incomplete]
#>        Changed: 0
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
#> 5J08UQZATJ0 | DCtr | Clear result
db$.res # Empty result
#> NULL
db$disconnect() # Close connection
#> 5J08UQZATJ0 | Dctr | Database disconnected
db$.con # Empty connection
#> NULL
db$unloadDriver() # Reset database handling object
#> 5J08UQZATJ0 | dctr | Driver unload RSQLite
db$.drv # Empty driver
#> NULL
```

## Transaction

Setup database and a table with 32 rows.

``` r
db <- rocker::newDB() # New database handling object
#> 5J08UQZATMW | dctr | Object id 5J08UQZATMW
db$setupSQLite() # Setup SQLite database
#> 5J08UQZATMW | Dctr | Driver load RSQLite
db$connect() # Open connection
#> 5J08UQZATMW | DCtr | Database connected
db$writeTable("mtcars", mtcars) # Create table for testing
#> 5J08UQZATMW | DCtr | Write table mtcars columns mpg, cyl, disp, hp, drat, wt, qsec, vs, am, gear, carb rows 32
output <- db$getQuery("SELECT * FROM mtcars;") # Get query -> 32 rows
#> 5J08UQZATMW | DCtR | Send query 21 characters 
#> 5J08UQZATMW | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> 5J08UQZATMW | DCtR | Rows fetched 32 
#> 5J08UQZATMW | DCtR | Has completed yes 
#> 5J08UQZATMW | DCtr | Clear result
db$transaction # Transaction indicator
#> [1] FALSE
```

Starting with a table with 32 rows, begin transaction 1. Delete 15 rows
and commit transaction. Operations results in a table with 17 rows.

``` r
db$begin() # Start transaction 1
#> 5J08UQZATMW | DCTr | Transaction begin
db$transaction # Transaction indicator
#> [1] TRUE
AFFECTED <- db$execute("DELETE FROM mtcars WHERE gear = 3;") # Modify table -> 15 rows
#> 5J08UQZATMW | DCTR | Send statement 34 characters 
#> 5J08UQZATMW | DCTR | Rows affected 15 
#> 5J08UQZATMW | DCTr | Clear result
db$commit() # Commit transaction 1
#> 5J08UQZATMW | DCtr | Transaction commit
db$transaction # Transaction indicator
#> [1] FALSE
output <- db$getQuery("SELECT * FROM mtcars;") # Get query -> 17 rows
#> 5J08UQZATMW | DCtR | Send query 21 characters 
#> 5J08UQZATMW | DCtR | Fetch rows all -> Received 17 rows, 11 columns, 3504 bytes 
#> 5J08UQZATMW | DCtR | Rows fetched 17 
#> 5J08UQZATMW | DCtR | Has completed yes 
#> 5J08UQZATMW | DCtr | Clear result
```

Starting with a table with 17 rows, begin transaction 2. Delete 5 rows
and rollback transaction. Operations results in a table with 17 rows.

``` r
db$begin() # Start transaction 2
#> 5J08UQZATMW | DCTr | Transaction begin
db$transaction # Transaction indicator
#> [1] TRUE
AFFECTED <- db$execute("DELETE FROM mtcars WHERE gear = 5;") # Modify table -> 5 rows
#> 5J08UQZATMW | DCTR | Send statement 34 characters 
#> 5J08UQZATMW | DCTR | Rows affected 5 
#> 5J08UQZATMW | DCTr | Clear result
output <- db$getQuery("SELECT * FROM mtcars;") # Get query -> 12 rows
#> 5J08UQZATMW | DCTR | Send query 21 characters 
#> 5J08UQZATMW | DCTR | Fetch rows all -> Received 12 rows, 11 columns, 3416 bytes 
#> 5J08UQZATMW | DCTR | Rows fetched 12 
#> 5J08UQZATMW | DCTR | Has completed yes 
#> 5J08UQZATMW | DCTr | Clear result
db$rollback() # Rollback transaction 2
#> 5J08UQZATMW | DCtr | Transaction rollback
db$transaction # Transaction indicator
#> [1] FALSE
output <- db$getQuery("SELECT * FROM mtcars;") # Get query -> 17 rows
#> 5J08UQZATMW | DCtR | Send query 21 characters 
#> 5J08UQZATMW | DCtR | Fetch rows all -> Received 17 rows, 11 columns, 3504 bytes 
#> 5J08UQZATMW | DCtR | Rows fetched 17 
#> 5J08UQZATMW | DCtR | Has completed yes 
#> 5J08UQZATMW | DCtr | Clear result
```

Clean up.

``` r
db$disconnect() # Close connection
#> 5J08UQZATMW | Dctr | Database disconnected
db$unloadDriver() # Reset database handling object
#> 5J08UQZATMW | dctr | Driver unload RSQLite
```

## Further help

Please read the documentation of ‘rocker’ class.

``` r
help(rocker)
```

Reading of ‘DBI’ package documentation is also recommended.

-   [CRAN](https://cran.r-project.org/package=DBI)
-   [GitHub](https://github.com/r-dbi/DBI)
