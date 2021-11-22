
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rocker <img src='man/figures/logo.png' align="right" height="138" />

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/rocker)](https://cran.r-project.org/package=rocker)
[![GitHub
version](https://img.shields.io/badge/devel%20version-0.1.2.9004-yellow.svg)](https://github.com/nikolaus77/rocker)
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
#> b1281cce-6582-496a-9ce6-82bb70b8877b | dctr | Object id b1281cce-6582-496a-9ce6-82bb70b8877b
```

Option 2

``` r
db <- rocker::rocker$new() # New database handling object
#> d985e5da-c205-46d1-a850-c273e01384ad | dctr | Object id d985e5da-c205-46d1-a850-c273e01384ad
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
#> 2bf5d627-5a1f-47e7-bb0e-ef45b66a4f16 | dctr | Object id 2bf5d627-5a1f-47e7-bb0e-ef45b66a4f16
db$verbose <- FALSE # Terminal output off
db$verbose <- TRUE # Terminal output on (default)
```

Structure of terminal output.

    587a904a-1027-4717-b4a8-ed8e4b26f2b5 | Dctr | Driver load RSQLite

    587a904a-1027-4717-b4a8-ed8e4b26f2b5
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
#> 182d733d-97b4-4aa4-aa2c-29322f354c84 | dctr | Object id 182d733d-97b4-4aa4-aa2c-29322f354c84
db$setupSQLite( # Setup SQLite database
  dbname = ":memory:"
)
#> 182d733d-97b4-4aa4-aa2c-29322f354c84 | Dctr | Driver load RSQLite
db$unloadDriver() # Reset database handling object
#> 182d733d-97b4-4aa4-aa2c-29322f354c84 | dctr | Driver unload RSQLite
```

Option 2

``` r
db <- rocker::newDB() # New database handling object
#> 44683daf-a91c-4baa-a488-7d7656ee09f3 | dctr | Object id 44683daf-a91c-4baa-a488-7d7656ee09f3
db$setupDriver( # Setup SQLite database
  drv = RSQLite::SQLite(),
  dbname = ":memory:"
)
#> 44683daf-a91c-4baa-a488-7d7656ee09f3 | Dctr | Driver load RSQLite
db$unloadDriver() # Reset database handling object
#> 44683daf-a91c-4baa-a488-7d7656ee09f3 | dctr | Driver unload RSQLite
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
#> ed04e14c-cf24-4b3e-85f0-b8747787eec2 | dctr | Object id ed04e14c-cf24-4b3e-85f0-b8747787eec2
db$setupPostgreSQL( # Setup PostgreSQL database
  host = "127.0.0.1", port = "5432", dbname = "mydb",
  user = "postgres", password = "password"
)
#> ed04e14c-cf24-4b3e-85f0-b8747787eec2 | Dctr | Driver load RPostgres
db$unloadDriver() # Reset database handling object
#> ed04e14c-cf24-4b3e-85f0-b8747787eec2 | dctr | Driver unload RPostgres
```

Option 2

``` r
db <- rocker::newDB() # New database handling object
#> 4e0a1cec-526a-42bb-a57e-498133956c5c | dctr | Object id 4e0a1cec-526a-42bb-a57e-498133956c5c
db$setupDriver( # Setup PostgreSQL database
  drv = RPostgres::Postgres(),
  host = "127.0.0.1", port = "5432", dbname = "mydb",
  user = "postgres", password = "password"
)
#> 4e0a1cec-526a-42bb-a57e-498133956c5c | Dctr | Driver load RPostgres
db$unloadDriver() # Reset database handling object
#> 4e0a1cec-526a-42bb-a57e-498133956c5c | dctr | Driver unload RPostgres
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
#> c4af1db7-f6d7-46b6-84e5-94a67ea8abb1 | dctr | Object id c4af1db7-f6d7-46b6-84e5-94a67ea8abb1
db$setupMariaDB( # Setup MariaDB database
  host = "127.0.0.1", port = "3306", dbname = "mydb",
  user = "root", password = "password"
)
#> c4af1db7-f6d7-46b6-84e5-94a67ea8abb1 | Dctr | Driver load RMariaDB
db$unloadDriver() # Reset database handling object
#> c4af1db7-f6d7-46b6-84e5-94a67ea8abb1 | dctr | Driver unload RMariaDB
```

Option 2

``` r
db <- rocker::newDB() # New database handling object
#> 390611e5-6bcb-4c77-8b0b-37e1d4684e0b | dctr | Object id 390611e5-6bcb-4c77-8b0b-37e1d4684e0b
db$setupDriver( # Setup MariaDB database
  drv = RMariaDB::MariaDB(),
  host = "127.0.0.1", port = "3306", dbname = "mydb",
  user = "root", password = "password"
)
#> 390611e5-6bcb-4c77-8b0b-37e1d4684e0b | Dctr | Driver load RMariaDB
db$unloadDriver() # Reset database handling object
#> 390611e5-6bcb-4c77-8b0b-37e1d4684e0b | dctr | Driver unload RMariaDB
```

## Database connection

### About the following examples

Before running the following examples this code block needs to be
executed first. *(pre code block)*

``` r
db <- rocker::newDB() # New database handling object
#> dd3a559d-a64e-4706-a118-318475ce2011 | dctr | Object id dd3a559d-a64e-4706-a118-318475ce2011
db$setupSQLite(dbname = tempfile()) # Setup SQLite database
#> dd3a559d-a64e-4706-a118-318475ce2011 | Dctr | Driver load RSQLite
db$connect() # Open connection
#> dd3a559d-a64e-4706-a118-318475ce2011 | DCtr | Database connected
db$writeTable("mtcars", mtcars) # Create table for testing
#> dd3a559d-a64e-4706-a118-318475ce2011 | DCtr | Write table mtcars columns mpg, cyl, disp, hp, drat, wt, qsec, vs, am, gear, carb rows 32
db$disconnect() # Close connection
#> dd3a559d-a64e-4706-a118-318475ce2011 | Dctr | Database disconnected
```

After running the following examples this code block needs to be
executed. *(post code block)*

``` r
db$unloadDriver() # Reset database handling object
#> dd3a559d-a64e-4706-a118-318475ce2011 | dctr | Driver unload RSQLite
```

### Different ways to connect and to get data

#### Example 1

Get query with automatic connection / disconnection. *(do also run pre
and post code block)*

``` r
output <- db$getQuery("SELECT * FROM mtcars;") # Get query
#> 09952785-5e47-4115-8e90-1f1e85fc4ae2 | DCtr | Database connected 
#> 09952785-5e47-4115-8e90-1f1e85fc4ae2 | DCtR | Send query 21 characters 
#> 09952785-5e47-4115-8e90-1f1e85fc4ae2 | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> 09952785-5e47-4115-8e90-1f1e85fc4ae2 | DCtR | Rows fetched 32 
#> 09952785-5e47-4115-8e90-1f1e85fc4ae2 | DCtR | Has completed yes 
#> 09952785-5e47-4115-8e90-1f1e85fc4ae2 | DCtr | Clear result 
#> 09952785-5e47-4115-8e90-1f1e85fc4ae2 | Dctr | Database disconnected
```

Get query with automatic connection / disconnection. *(full example;
including pre and post code blocks)*

``` r
db <- rocker::newDB() # New database handling object
#> 18daded4-aa77-46a4-8891-5b5a0f51342f | dctr | Object id 18daded4-aa77-46a4-8891-5b5a0f51342f
db$setupSQLite(dbname = tempfile()) # Setup SQLite database
#> 18daded4-aa77-46a4-8891-5b5a0f51342f | Dctr | Driver load RSQLite
db$connect() # Open connection
#> 18daded4-aa77-46a4-8891-5b5a0f51342f | DCtr | Database connected
db$writeTable("mtcars", mtcars) # Create table for testing
#> 18daded4-aa77-46a4-8891-5b5a0f51342f | DCtr | Write table mtcars columns mpg, cyl, disp, hp, drat, wt, qsec, vs, am, gear, carb rows 32
db$disconnect() # Close connection
#> 18daded4-aa77-46a4-8891-5b5a0f51342f | Dctr | Database disconnected
output <- db$getQuery("SELECT * FROM mtcars;") # Get query
#> 18daded4-aa77-46a4-8891-5b5a0f51342f | DCtr | Database connected 
#> 18daded4-aa77-46a4-8891-5b5a0f51342f | DCtR | Send query 21 characters 
#> 18daded4-aa77-46a4-8891-5b5a0f51342f | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> 18daded4-aa77-46a4-8891-5b5a0f51342f | DCtR | Rows fetched 32 
#> 18daded4-aa77-46a4-8891-5b5a0f51342f | DCtR | Has completed yes 
#> 18daded4-aa77-46a4-8891-5b5a0f51342f | DCtr | Clear result 
#> 18daded4-aa77-46a4-8891-5b5a0f51342f | Dctr | Database disconnected
db$unloadDriver() # Reset database handling object
#> 18daded4-aa77-46a4-8891-5b5a0f51342f | dctr | Driver unload RSQLite
```

#### Example 2

Get query with manual connection / disconnection. *(do also run pre and
post code block)*

``` r
db$connect() # Open connection
#> 7459a250-5cb5-48c6-9a8c-40d2e9d48b23 | DCtr | Database connected
output1 <- db$getQuery("SELECT * FROM mtcars;") # Get query 1
#> 7459a250-5cb5-48c6-9a8c-40d2e9d48b23 | DCtR | Send query 21 characters 
#> 7459a250-5cb5-48c6-9a8c-40d2e9d48b23 | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> 7459a250-5cb5-48c6-9a8c-40d2e9d48b23 | DCtR | Rows fetched 32 
#> 7459a250-5cb5-48c6-9a8c-40d2e9d48b23 | DCtR | Has completed yes 
#> 7459a250-5cb5-48c6-9a8c-40d2e9d48b23 | DCtr | Clear result
output2 <- db$getQuery("SELECT * FROM mtcars;", 60) # Get query 2
#> 7459a250-5cb5-48c6-9a8c-40d2e9d48b23 | DCtR | Send query 21 characters 
#> 7459a250-5cb5-48c6-9a8c-40d2e9d48b23 | DCtR | Fetch rows 60 -> Received 32 rows, 11 columns, 4824 bytes 
#> 7459a250-5cb5-48c6-9a8c-40d2e9d48b23 | DCtR | Rows fetched 32 
#> 7459a250-5cb5-48c6-9a8c-40d2e9d48b23 | DCtR | Has completed yes 
#> 7459a250-5cb5-48c6-9a8c-40d2e9d48b23 | DCtr | Clear result
db$disconnect() # Close connection
#> 7459a250-5cb5-48c6-9a8c-40d2e9d48b23 | Dctr | Database disconnected
```

#### Example 3

Function getQuery() is a combination of functions sendQuery(), fetch()
and clearResult(). *(do also run pre and post code block)*

``` r
db$connect() # Open connection
#> a0ee1585-d8f5-4aab-bf13-0b67098b08c0 | DCtr | Database connected
db$sendQuery("SELECT * FROM mtcars;") # Send query
#> a0ee1585-d8f5-4aab-bf13-0b67098b08c0 | DCtR | Send query 21 characters
output <- db$fetch() # Fetch result
#> a0ee1585-d8f5-4aab-bf13-0b67098b08c0 | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes
db$clearResult() # Clean up result
#> a0ee1585-d8f5-4aab-bf13-0b67098b08c0 | DCtr | Clear result
db$disconnect() # Close connection
#> a0ee1585-d8f5-4aab-bf13-0b67098b08c0 | Dctr | Database disconnected
```

## Password storage

Some efforts were undertaken to encrypt and to protect the password in
the private area of the class. The class stores the password hidden and
inaccessible. **Please let me know, in case you discover a way how to
access the password!**

``` r
db <- rocker::newDB() # New database handling object
#> 84d73fd0-ba62-42ad-be5e-776c7999681c | dctr | Object id 84d73fd0-ba62-42ad-be5e-776c7999681c
db$setupDriver( # Setup PostgreSQL database with stored password (password and user are hidden - default behavior)
  RPostgres::Postgres(),
  host = "127.0.0.1", port = "5432", dbname = "mydb",
  user = "postgres", password = "password",
  protect = c("password", "user")
)
#> 84d73fd0-ba62-42ad-be5e-776c7999681c | Dctr | Driver load RPostgres
db$connect() # Open connection 1; Password is stored in the class and does not need to be provided.
#> 84d73fd0-ba62-42ad-be5e-776c7999681c | DCtr | Database connected
output1 <- db$getQuery("SELECT * FROM mtcars;") # Get query 1
#> 84d73fd0-ba62-42ad-be5e-776c7999681c | DCtR | Send query 21 characters 
#> 84d73fd0-ba62-42ad-be5e-776c7999681c | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> 84d73fd0-ba62-42ad-be5e-776c7999681c | DCtR | Rows fetched 32 
#> 84d73fd0-ba62-42ad-be5e-776c7999681c | DCtR | Has completed yes 
#> 84d73fd0-ba62-42ad-be5e-776c7999681c | DCtr | Clear result
db$disconnect() # Close connection 1
#> 84d73fd0-ba62-42ad-be5e-776c7999681c | Dctr | Database disconnected
db$connect() # Open connection 2; Password is stored in the class and does not need to be provided.
#> 84d73fd0-ba62-42ad-be5e-776c7999681c | DCtr | Database connected
output2 <- db$getQuery("SELECT * FROM mtcars;") # Get query 2
#> 84d73fd0-ba62-42ad-be5e-776c7999681c | DCtR | Send query 21 characters 
#> 84d73fd0-ba62-42ad-be5e-776c7999681c | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> 84d73fd0-ba62-42ad-be5e-776c7999681c | DCtR | Rows fetched 32 
#> 84d73fd0-ba62-42ad-be5e-776c7999681c | DCtR | Has completed yes 
#> 84d73fd0-ba62-42ad-be5e-776c7999681c | DCtr | Clear result
db$disconnect() # Close connection 2
#> 84d73fd0-ba62-42ad-be5e-776c7999681c | Dctr | Database disconnected
db$unloadDriver() # Reset database handling object
#> 84d73fd0-ba62-42ad-be5e-776c7999681c | dctr | Driver unload RPostgres
```

In case you do not want to store the password in the class, you will
need to provide it each time a connection is opened.

``` r
db <- rocker::newDB() # New database handling object
#> fe45993c-5bd2-4d47-b597-f05bf8ce652e | dctr | Object id fe45993c-5bd2-4d47-b597-f05bf8ce652e
db$setupDriver( # Setup PostgreSQL database without stored password
  RPostgres::Postgres(),
  host = "127.0.0.1", port = "5432", dbname = "mydb",
  user = "postgres"
)
#> fe45993c-5bd2-4d47-b597-f05bf8ce652e | Dctr | Driver load RPostgres
db$connect(password = "password") # Open connection 1; Password needs to be provided.
#> fe45993c-5bd2-4d47-b597-f05bf8ce652e | DCtr | Database connected
output1 <- db$getQuery("SELECT * FROM mtcars;") # Get query 1
#> fe45993c-5bd2-4d47-b597-f05bf8ce652e | DCtR | Send query 21 characters 
#> fe45993c-5bd2-4d47-b597-f05bf8ce652e | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> fe45993c-5bd2-4d47-b597-f05bf8ce652e | DCtR | Rows fetched 32 
#> fe45993c-5bd2-4d47-b597-f05bf8ce652e | DCtR | Has completed yes 
#> fe45993c-5bd2-4d47-b597-f05bf8ce652e | DCtr | Clear result
db$disconnect() # Close connection 1
#> fe45993c-5bd2-4d47-b597-f05bf8ce652e | Dctr | Database disconnected
db$connect(password = "password") # Open connection 2; Password needs to be provided.
#> fe45993c-5bd2-4d47-b597-f05bf8ce652e | DCtr | Database connected
output2 <- db$getQuery("SELECT * FROM mtcars;") # Get query 2
#> fe45993c-5bd2-4d47-b597-f05bf8ce652e | DCtR | Send query 21 characters 
#> fe45993c-5bd2-4d47-b597-f05bf8ce652e | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> fe45993c-5bd2-4d47-b597-f05bf8ce652e | DCtR | Rows fetched 32 
#> fe45993c-5bd2-4d47-b597-f05bf8ce652e | DCtR | Has completed yes 
#> fe45993c-5bd2-4d47-b597-f05bf8ce652e | DCtr | Clear result
db$disconnect() # Close connection 2
#> fe45993c-5bd2-4d47-b597-f05bf8ce652e | Dctr | Database disconnected
db$unloadDriver() # Reset database handling object
#> fe45993c-5bd2-4d47-b597-f05bf8ce652e | dctr | Driver unload RPostgres
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
#> 9c6c0647-1dc9-4516-b531-3e62129e7012 | dctr | Object id 9c6c0647-1dc9-4516-b531-3e62129e7012
db$.drv # Empty driver
#> NULL
db$.con # Empty connection
#> NULL
db$.res # Empty result
#> NULL
db$setupSQLite() # Setup SQLite database
#> 9c6c0647-1dc9-4516-b531-3e62129e7012 | Dctr | Driver load RSQLite
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
#> 9c6c0647-1dc9-4516-b531-3e62129e7012 | DCtr | Database connected
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
#> 9c6c0647-1dc9-4516-b531-3e62129e7012 | DCtr | Write table mtcars columns mpg, cyl, disp, hp, drat, wt, qsec, vs, am, gear, carb rows 32
db$sendQuery("SELECT * FROM mtcars;") # Send query
#> 9c6c0647-1dc9-4516-b531-3e62129e7012 | DCtR | Send query 21 characters
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
#> 9c6c0647-1dc9-4516-b531-3e62129e7012 | DCtr | Clear result
db$.res # Empty result
#> NULL
db$disconnect() # Close connection
#> 9c6c0647-1dc9-4516-b531-3e62129e7012 | Dctr | Database disconnected
db$.con # Empty connection
#> NULL
db$unloadDriver() # Reset database handling object
#> 9c6c0647-1dc9-4516-b531-3e62129e7012 | dctr | Driver unload RSQLite
db$.drv # Empty driver
#> NULL
```

## Transaction

Setup database and a table with 32 rows.

``` r
db <- rocker::newDB() # New database handling object
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | dctr | Object id 82a0f0d9-1696-4a69-a256-59b15ae3475f
db$setupSQLite() # Setup SQLite database
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | Dctr | Driver load RSQLite
db$connect() # Open connection
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCtr | Database connected
db$writeTable("mtcars", mtcars) # Create table for testing
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCtr | Write table mtcars columns mpg, cyl, disp, hp, drat, wt, qsec, vs, am, gear, carb rows 32
output <- db$getQuery("SELECT * FROM mtcars;") # Get query -> 32 rows
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCtR | Send query 21 characters 
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCtR | Rows fetched 32 
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCtR | Has completed yes 
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCtr | Clear result
db$transaction # Transaction indicator
#> [1] FALSE
```

Starting with a table with 32 rows, begin transaction 1. Delete 15 rows
and commit transaction. Operations results in a table with 17 rows.

``` r
db$begin() # Start transaction 1
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCTr | Transaction begin
db$transaction # Transaction indicator
#> [1] TRUE
AFFECTED <- db$execute("DELETE FROM mtcars WHERE gear = 3;") # Modify table -> 15 rows
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCTR | Send statement 34 characters 
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCTR | Rows affected 15 
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCTr | Clear result
db$commit() # Commit transaction 1
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCtr | Transaction commit
db$transaction # Transaction indicator
#> [1] FALSE
output <- db$getQuery("SELECT * FROM mtcars;") # Get query -> 17 rows
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCtR | Send query 21 characters 
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCtR | Fetch rows all -> Received 17 rows, 11 columns, 3504 bytes 
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCtR | Rows fetched 17 
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCtR | Has completed yes 
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCtr | Clear result
```

Starting with a table with 17 rows, begin transaction 2. Delete 5 rows
and rollback transaction. Operations results in a table with 17 rows.

``` r
db$begin() # Start transaction 2
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCTr | Transaction begin
db$transaction # Transaction indicator
#> [1] TRUE
AFFECTED <- db$execute("DELETE FROM mtcars WHERE gear = 5;") # Modify table -> 5 rows
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCTR | Send statement 34 characters 
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCTR | Rows affected 5 
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCTr | Clear result
output <- db$getQuery("SELECT * FROM mtcars;") # Get query -> 12 rows
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCTR | Send query 21 characters 
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCTR | Fetch rows all -> Received 12 rows, 11 columns, 3416 bytes 
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCTR | Rows fetched 12 
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCTR | Has completed yes 
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCTr | Clear result
db$rollback() # Rollback transaction 2
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCtr | Transaction rollback
db$transaction # Transaction indicator
#> [1] FALSE
output <- db$getQuery("SELECT * FROM mtcars;") # Get query -> 17 rows
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCtR | Send query 21 characters 
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCtR | Fetch rows all -> Received 17 rows, 11 columns, 3504 bytes 
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCtR | Rows fetched 17 
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCtR | Has completed yes 
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | DCtr | Clear result
```

Clean up.

``` r
db$disconnect() # Close connection
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | Dctr | Database disconnected
db$unloadDriver() # Reset database handling object
#> 82a0f0d9-1696-4a69-a256-59b15ae3475f | dctr | Driver unload RSQLite
```

## Further help

Please read the documentation of ‘rocker’ class.

``` r
help(rocker)
```

Reading of ‘DBI’ package documentation is also recommended.

-   [CRAN](https://cran.r-project.org/package=DBI)
-   [GitHub](https://github.com/r-dbi/DBI)
