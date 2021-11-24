
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rocker <img src='man/figures/logo.png' align="right" height="138" />

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/rocker)](https://cran.r-project.org/package=rocker)
[![GitHub
version](https://img.shields.io/badge/devel%20version-0.1.2.9005-yellow.svg)](https://github.com/nikolaus77/rocker)
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
#> 0d7311b5-e55d-4acd-ab27-e2ae21e3dfa2 | dctr | Object id 0d7311b5-e55d-4acd-ab27-e2ae21e3dfa2
```

Option 2

``` r
db <- rocker::rocker$new() # New database handling object
#> 35e4de23-8d94-4c54-8702-a366cbc62dd6 | dctr | Object id 35e4de23-8d94-4c54-8702-a366cbc62dd6
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
#> b65abb6a-2511-49c7-b52c-1caa972a23fe | dctr | Object id b65abb6a-2511-49c7-b52c-1caa972a23fe
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
#> a53a73b1-95a2-46b5-a5e7-13123596e1a3 | dctr | Object id a53a73b1-95a2-46b5-a5e7-13123596e1a3
db$setupSQLite( # Setup SQLite database
  dbname = ":memory:"
)
#> a53a73b1-95a2-46b5-a5e7-13123596e1a3 | Dctr | Driver load RSQLite
db$unloadDriver() # Reset database handling object
#> a53a73b1-95a2-46b5-a5e7-13123596e1a3 | dctr | Driver unload RSQLite
```

Option 2

``` r
db <- rocker::newDB() # New database handling object
#> 3a97e04f-744d-442d-adc2-b289b4876416 | dctr | Object id 3a97e04f-744d-442d-adc2-b289b4876416
db$setupDriver( # Setup SQLite database
  drv = RSQLite::SQLite(),
  dbname = ":memory:"
)
#> 3a97e04f-744d-442d-adc2-b289b4876416 | Dctr | Driver load RSQLite
db$unloadDriver() # Reset database handling object
#> 3a97e04f-744d-442d-adc2-b289b4876416 | dctr | Driver unload RSQLite
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
#> a127e6d7-2d39-4efc-b929-5507c3ac9338 | dctr | Object id a127e6d7-2d39-4efc-b929-5507c3ac9338
db$setupPostgreSQL( # Setup PostgreSQL database
  host = "127.0.0.1", port = "5432", dbname = "mydb",
  user = "postgres", password = "password"
)
#> a127e6d7-2d39-4efc-b929-5507c3ac9338 | Dctr | Driver load RPostgres
db$unloadDriver() # Reset database handling object
#> a127e6d7-2d39-4efc-b929-5507c3ac9338 | dctr | Driver unload RPostgres
```

Option 2

``` r
db <- rocker::newDB() # New database handling object
#> 9d28b48c-fe70-4d0f-a187-47a67e52beb4 | dctr | Object id 9d28b48c-fe70-4d0f-a187-47a67e52beb4
db$setupDriver( # Setup PostgreSQL database
  drv = RPostgres::Postgres(),
  host = "127.0.0.1", port = "5432", dbname = "mydb",
  user = "postgres", password = "password"
)
#> 9d28b48c-fe70-4d0f-a187-47a67e52beb4 | Dctr | Driver load RPostgres
db$unloadDriver() # Reset database handling object
#> 9d28b48c-fe70-4d0f-a187-47a67e52beb4 | dctr | Driver unload RPostgres
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
#> c91e0608-7825-48a3-8871-01454c1465a2 | dctr | Object id c91e0608-7825-48a3-8871-01454c1465a2
db$setupMariaDB( # Setup MariaDB database
  host = "127.0.0.1", port = "3306", dbname = "mydb",
  user = "root", password = "password"
)
#> c91e0608-7825-48a3-8871-01454c1465a2 | Dctr | Driver load RMariaDB
db$unloadDriver() # Reset database handling object
#> c91e0608-7825-48a3-8871-01454c1465a2 | dctr | Driver unload RMariaDB
```

Option 2

``` r
db <- rocker::newDB() # New database handling object
#> 633c58a3-6358-4ef8-9af3-25726291da4c | dctr | Object id 633c58a3-6358-4ef8-9af3-25726291da4c
db$setupDriver( # Setup MariaDB database
  drv = RMariaDB::MariaDB(),
  host = "127.0.0.1", port = "3306", dbname = "mydb",
  user = "root", password = "password"
)
#> 633c58a3-6358-4ef8-9af3-25726291da4c | Dctr | Driver load RMariaDB
db$unloadDriver() # Reset database handling object
#> 633c58a3-6358-4ef8-9af3-25726291da4c | dctr | Driver unload RMariaDB
```

## Database connection

### About the following examples

Before running the following examples this code block needs to be
executed first. *(pre code block)*

``` r
db <- rocker::newDB() # New database handling object
#> ca1017fa-c06b-48db-b400-7ac94871519d | dctr | Object id ca1017fa-c06b-48db-b400-7ac94871519d
db$setupSQLite(dbname = tempfile()) # Setup SQLite database
#> ca1017fa-c06b-48db-b400-7ac94871519d | Dctr | Driver load RSQLite
db$connect() # Open connection
#> ca1017fa-c06b-48db-b400-7ac94871519d | DCtr | Database connected
db$writeTable("mtcars", mtcars) # Create table for testing
#> ca1017fa-c06b-48db-b400-7ac94871519d | DCtr | Write table mtcars columns mpg, cyl, disp, hp, drat, wt, qsec, vs, am, gear, carb rows 32
db$disconnect() # Close connection
#> ca1017fa-c06b-48db-b400-7ac94871519d | Dctr | Database disconnected
```

After running the following examples this code block needs to be
executed. *(post code block)*

``` r
db$unloadDriver() # Reset database handling object
#> ca1017fa-c06b-48db-b400-7ac94871519d | dctr | Driver unload RSQLite
```

### Different ways to connect and to get data

#### Example 1

Get query with automatic connection / disconnection. *(do also run pre
and post code block)*

``` r
output <- db$getQuery("SELECT * FROM mtcars;") # Get query
#> c955e932-ca6e-47bf-9ad3-2963cd62d69a | DCtr | Database connected 
#> c955e932-ca6e-47bf-9ad3-2963cd62d69a | DCtR | Send query 21 characters 
#> c955e932-ca6e-47bf-9ad3-2963cd62d69a | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> c955e932-ca6e-47bf-9ad3-2963cd62d69a | DCtR | Rows fetched 32 
#> c955e932-ca6e-47bf-9ad3-2963cd62d69a | DCtR | Has completed yes 
#> c955e932-ca6e-47bf-9ad3-2963cd62d69a | DCtr | Clear result 
#> c955e932-ca6e-47bf-9ad3-2963cd62d69a | Dctr | Database disconnected
```

Get query with automatic connection / disconnection. *(full example;
including pre and post code blocks)*

``` r
db <- rocker::newDB() # New database handling object
#> ceef531d-ec59-4ec9-a541-8c007547afca | dctr | Object id ceef531d-ec59-4ec9-a541-8c007547afca
db$setupSQLite(dbname = tempfile()) # Setup SQLite database
#> ceef531d-ec59-4ec9-a541-8c007547afca | Dctr | Driver load RSQLite
db$connect() # Open connection
#> ceef531d-ec59-4ec9-a541-8c007547afca | DCtr | Database connected
db$writeTable("mtcars", mtcars) # Create table for testing
#> ceef531d-ec59-4ec9-a541-8c007547afca | DCtr | Write table mtcars columns mpg, cyl, disp, hp, drat, wt, qsec, vs, am, gear, carb rows 32
db$disconnect() # Close connection
#> ceef531d-ec59-4ec9-a541-8c007547afca | Dctr | Database disconnected
output <- db$getQuery("SELECT * FROM mtcars;") # Get query
#> ceef531d-ec59-4ec9-a541-8c007547afca | DCtr | Database connected 
#> ceef531d-ec59-4ec9-a541-8c007547afca | DCtR | Send query 21 characters 
#> ceef531d-ec59-4ec9-a541-8c007547afca | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> ceef531d-ec59-4ec9-a541-8c007547afca | DCtR | Rows fetched 32 
#> ceef531d-ec59-4ec9-a541-8c007547afca | DCtR | Has completed yes 
#> ceef531d-ec59-4ec9-a541-8c007547afca | DCtr | Clear result 
#> ceef531d-ec59-4ec9-a541-8c007547afca | Dctr | Database disconnected
db$unloadDriver() # Reset database handling object
#> ceef531d-ec59-4ec9-a541-8c007547afca | dctr | Driver unload RSQLite
```

#### Example 2

Get query with manual connection / disconnection. *(do also run pre and
post code block)*

``` r
db$connect() # Open connection
#> 0d9acf8c-3fcd-48f2-938b-a320068f09c9 | DCtr | Database connected
output1 <- db$getQuery("SELECT * FROM mtcars;") # Get query 1
#> 0d9acf8c-3fcd-48f2-938b-a320068f09c9 | DCtR | Send query 21 characters 
#> 0d9acf8c-3fcd-48f2-938b-a320068f09c9 | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> 0d9acf8c-3fcd-48f2-938b-a320068f09c9 | DCtR | Rows fetched 32 
#> 0d9acf8c-3fcd-48f2-938b-a320068f09c9 | DCtR | Has completed yes 
#> 0d9acf8c-3fcd-48f2-938b-a320068f09c9 | DCtr | Clear result
output2 <- db$getQuery("SELECT * FROM mtcars;", 15) # Get query 2
#> 0d9acf8c-3fcd-48f2-938b-a320068f09c9 | DCtR | Send query 21 characters 
#> 0d9acf8c-3fcd-48f2-938b-a320068f09c9 | DCtR | Fetch rows 15 -> Received 15 rows, 11 columns, 3416 bytes 
#> 0d9acf8c-3fcd-48f2-938b-a320068f09c9 | DCtR | Rows fetched 15 
#> 0d9acf8c-3fcd-48f2-938b-a320068f09c9 | DCtR | Has completed no 
#> 0d9acf8c-3fcd-48f2-938b-a320068f09c9 | DCtR | Fetch rows 15 -> Received 15 rows, 11 columns, 3416 bytes 
#> 0d9acf8c-3fcd-48f2-938b-a320068f09c9 | DCtR | Rows fetched 30 
#> 0d9acf8c-3fcd-48f2-938b-a320068f09c9 | DCtR | Has completed no 
#> 0d9acf8c-3fcd-48f2-938b-a320068f09c9 | DCtR | Fetch rows 15 -> Received 2 rows, 11 columns, 2184 bytes 
#> 0d9acf8c-3fcd-48f2-938b-a320068f09c9 | DCtR | Rows fetched 32 
#> 0d9acf8c-3fcd-48f2-938b-a320068f09c9 | DCtR | Has completed yes 
#> 0d9acf8c-3fcd-48f2-938b-a320068f09c9 | DCtr | Clear result
db$disconnect() # Close connection
#> 0d9acf8c-3fcd-48f2-938b-a320068f09c9 | Dctr | Database disconnected
```

#### Example 3

Function getQuery() is a combination of functions sendQuery(), fetch()
and clearResult(). *(do also run pre and post code block)*

``` r
db$connect() # Open connection
#> 1ab65e6e-49e2-4003-adec-1ee3fd31791e | DCtr | Database connected
db$sendQuery("SELECT * FROM mtcars;") # Send query
#> 1ab65e6e-49e2-4003-adec-1ee3fd31791e | DCtR | Send query 21 characters
output <- db$fetch() # Fetch result
#> 1ab65e6e-49e2-4003-adec-1ee3fd31791e | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes
db$clearResult() # Clean up result
#> 1ab65e6e-49e2-4003-adec-1ee3fd31791e | DCtr | Clear result
db$disconnect() # Close connection
#> 1ab65e6e-49e2-4003-adec-1ee3fd31791e | Dctr | Database disconnected
```

## Password storage

Some efforts were undertaken to encrypt and to protect the password in
the private area of the class. The class stores the password hidden and
inaccessible. **Please let me know, in case you discover a way how to
access the password!**

``` r
db <- rocker::newDB() # New database handling object
#> ab7fec0b-3d4d-401e-8756-4909ceda8761 | dctr | Object id ab7fec0b-3d4d-401e-8756-4909ceda8761
db$setupDriver( # Setup PostgreSQL database with stored password (password and user are hidden - default behavior)
  RPostgres::Postgres(),
  host = "127.0.0.1", port = "5432", dbname = "mydb",
  user = "postgres", password = "password",
  protect = c("password", "user")
)
#> ab7fec0b-3d4d-401e-8756-4909ceda8761 | Dctr | Driver load RPostgres
db$connect() # Open connection 1; Password is stored in the class and does not need to be provided.
#> ab7fec0b-3d4d-401e-8756-4909ceda8761 | DCtr | Database connected
output1 <- db$getQuery("SELECT * FROM mtcars;") # Get query 1
#> ab7fec0b-3d4d-401e-8756-4909ceda8761 | DCtR | Send query 21 characters 
#> ab7fec0b-3d4d-401e-8756-4909ceda8761 | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> ab7fec0b-3d4d-401e-8756-4909ceda8761 | DCtR | Rows fetched 32 
#> ab7fec0b-3d4d-401e-8756-4909ceda8761 | DCtR | Has completed yes 
#> ab7fec0b-3d4d-401e-8756-4909ceda8761 | DCtr | Clear result
db$disconnect() # Close connection 1
#> ab7fec0b-3d4d-401e-8756-4909ceda8761 | Dctr | Database disconnected
db$connect() # Open connection 2; Password is stored in the class and does not need to be provided.
#> ab7fec0b-3d4d-401e-8756-4909ceda8761 | DCtr | Database connected
output2 <- db$getQuery("SELECT * FROM mtcars;") # Get query 2
#> ab7fec0b-3d4d-401e-8756-4909ceda8761 | DCtR | Send query 21 characters 
#> ab7fec0b-3d4d-401e-8756-4909ceda8761 | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> ab7fec0b-3d4d-401e-8756-4909ceda8761 | DCtR | Rows fetched 32 
#> ab7fec0b-3d4d-401e-8756-4909ceda8761 | DCtR | Has completed yes 
#> ab7fec0b-3d4d-401e-8756-4909ceda8761 | DCtr | Clear result
db$disconnect() # Close connection 2
#> ab7fec0b-3d4d-401e-8756-4909ceda8761 | Dctr | Database disconnected
db$unloadDriver() # Reset database handling object
#> ab7fec0b-3d4d-401e-8756-4909ceda8761 | dctr | Driver unload RPostgres
```

In case you do not want to store the password in the class, you will
need to provide it each time a connection is opened.

``` r
db <- rocker::newDB() # New database handling object
#> 02731d51-de7b-4f2e-82fd-81b3aea39df7 | dctr | Object id 02731d51-de7b-4f2e-82fd-81b3aea39df7
db$setupDriver( # Setup PostgreSQL database without stored password
  RPostgres::Postgres(),
  host = "127.0.0.1", port = "5432", dbname = "mydb",
  user = "postgres"
)
#> 02731d51-de7b-4f2e-82fd-81b3aea39df7 | Dctr | Driver load RPostgres
db$connect(password = "password") # Open connection 1; Password needs to be provided.
#> 02731d51-de7b-4f2e-82fd-81b3aea39df7 | DCtr | Database connected
output1 <- db$getQuery("SELECT * FROM mtcars;") # Get query 1
#> 02731d51-de7b-4f2e-82fd-81b3aea39df7 | DCtR | Send query 21 characters 
#> 02731d51-de7b-4f2e-82fd-81b3aea39df7 | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> 02731d51-de7b-4f2e-82fd-81b3aea39df7 | DCtR | Rows fetched 32 
#> 02731d51-de7b-4f2e-82fd-81b3aea39df7 | DCtR | Has completed yes 
#> 02731d51-de7b-4f2e-82fd-81b3aea39df7 | DCtr | Clear result
db$disconnect() # Close connection 1
#> 02731d51-de7b-4f2e-82fd-81b3aea39df7 | Dctr | Database disconnected
db$connect(password = "password") # Open connection 2; Password needs to be provided.
#> 02731d51-de7b-4f2e-82fd-81b3aea39df7 | DCtr | Database connected
output2 <- db$getQuery("SELECT * FROM mtcars;") # Get query 2
#> 02731d51-de7b-4f2e-82fd-81b3aea39df7 | DCtR | Send query 21 characters 
#> 02731d51-de7b-4f2e-82fd-81b3aea39df7 | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> 02731d51-de7b-4f2e-82fd-81b3aea39df7 | DCtR | Rows fetched 32 
#> 02731d51-de7b-4f2e-82fd-81b3aea39df7 | DCtR | Has completed yes 
#> 02731d51-de7b-4f2e-82fd-81b3aea39df7 | DCtr | Clear result
db$disconnect() # Close connection 2
#> 02731d51-de7b-4f2e-82fd-81b3aea39df7 | Dctr | Database disconnected
db$unloadDriver() # Reset database handling object
#> 02731d51-de7b-4f2e-82fd-81b3aea39df7 | dctr | Driver unload RPostgres
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
#> 5ea8db4c-a7ed-48cc-ac22-daaf424ddfe3 | dctr | Object id 5ea8db4c-a7ed-48cc-ac22-daaf424ddfe3
db$.drv # Empty driver
#> NULL
db$.con # Empty connection
#> NULL
db$.res # Empty result
#> NULL
db$setupSQLite() # Setup SQLite database
#> 5ea8db4c-a7ed-48cc-ac22-daaf424ddfe3 | Dctr | Driver load RSQLite
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
#> 5ea8db4c-a7ed-48cc-ac22-daaf424ddfe3 | DCtr | Database connected
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
#> 5ea8db4c-a7ed-48cc-ac22-daaf424ddfe3 | DCtr | Write table mtcars columns mpg, cyl, disp, hp, drat, wt, qsec, vs, am, gear, carb rows 32
db$sendQuery("SELECT * FROM mtcars;") # Send query
#> 5ea8db4c-a7ed-48cc-ac22-daaf424ddfe3 | DCtR | Send query 21 characters
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
#> 5ea8db4c-a7ed-48cc-ac22-daaf424ddfe3 | DCtr | Clear result
db$.res # Empty result
#> NULL
db$disconnect() # Close connection
#> 5ea8db4c-a7ed-48cc-ac22-daaf424ddfe3 | Dctr | Database disconnected
db$.con # Empty connection
#> NULL
db$unloadDriver() # Reset database handling object
#> 5ea8db4c-a7ed-48cc-ac22-daaf424ddfe3 | dctr | Driver unload RSQLite
db$.drv # Empty driver
#> NULL
```

## Transaction

Setup database and a table with 32 rows.

``` r
db <- rocker::newDB() # New database handling object
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | dctr | Object id b45d4560-c6e3-4ac6-8466-81ac262b00fb
db$setupSQLite() # Setup SQLite database
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | Dctr | Driver load RSQLite
db$connect() # Open connection
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCtr | Database connected
db$writeTable("mtcars", mtcars) # Create table for testing
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCtr | Write table mtcars columns mpg, cyl, disp, hp, drat, wt, qsec, vs, am, gear, carb rows 32
output <- db$getQuery("SELECT * FROM mtcars;") # Get query -> 32 rows
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCtR | Send query 21 characters 
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCtR | Rows fetched 32 
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCtR | Has completed yes 
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCtr | Clear result
db$transaction # Transaction indicator
#> [1] FALSE
```

Starting with a table with 32 rows, begin transaction 1. Delete 15 rows
and commit transaction. Operations results in a table with 17 rows.

``` r
db$begin() # Start transaction 1
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCTr | Transaction begin
db$transaction # Transaction indicator
#> [1] TRUE
AFFECTED <- db$execute("DELETE FROM mtcars WHERE gear = 3;") # Modify table -> 15 rows
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCTR | Send statement 34 characters 
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCTR | Rows affected 15 
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCTr | Clear result
db$commit() # Commit transaction 1
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCtr | Transaction commit
db$transaction # Transaction indicator
#> [1] FALSE
output <- db$getQuery("SELECT * FROM mtcars;") # Get query -> 17 rows
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCtR | Send query 21 characters 
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCtR | Fetch rows all -> Received 17 rows, 11 columns, 3504 bytes 
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCtR | Rows fetched 17 
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCtR | Has completed yes 
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCtr | Clear result
```

Starting with a table with 17 rows, begin transaction 2. Delete 5 rows
and rollback transaction. Operations results in a table with 17 rows.

``` r
db$begin() # Start transaction 2
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCTr | Transaction begin
db$transaction # Transaction indicator
#> [1] TRUE
AFFECTED <- db$execute("DELETE FROM mtcars WHERE gear = 5;") # Modify table -> 5 rows
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCTR | Send statement 34 characters 
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCTR | Rows affected 5 
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCTr | Clear result
output <- db$getQuery("SELECT * FROM mtcars;") # Get query -> 12 rows
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCTR | Send query 21 characters 
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCTR | Fetch rows all -> Received 12 rows, 11 columns, 3416 bytes 
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCTR | Rows fetched 12 
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCTR | Has completed yes 
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCTr | Clear result
db$rollback() # Rollback transaction 2
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCtr | Transaction rollback
db$transaction # Transaction indicator
#> [1] FALSE
output <- db$getQuery("SELECT * FROM mtcars;") # Get query -> 17 rows
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCtR | Send query 21 characters 
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCtR | Fetch rows all -> Received 17 rows, 11 columns, 3504 bytes 
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCtR | Rows fetched 17 
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCtR | Has completed yes 
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | DCtr | Clear result
```

Clean up.

``` r
db$disconnect() # Close connection
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | Dctr | Database disconnected
db$unloadDriver() # Reset database handling object
#> b45d4560-c6e3-4ac6-8466-81ac262b00fb | dctr | Driver unload RSQLite
```

## Further help

Please read the documentation of ‘rocker’ class.

``` r
help(rocker)
```

Reading of ‘DBI’ package documentation is also recommended.

-   [CRAN](https://cran.r-project.org/package=DBI)
-   [GitHub](https://github.com/r-dbi/DBI)
