
-   [*rocker* – *R6* database interface class wrapping
    *DBI*](#rocker--r6-database-interface-class-wrapping-dbi)
-   [Installation](#installation)
-   [New *rocker* class object](#new-rocker-class-object)
-   [Additional packages and database
    types](#additional-packages-and-database-types)
    -   [*RSQLite* package](#rsqlite-package)
    -   [*RPostgres* package](#rpostgres-package)
    -   [*RMariaDB* package](#rmariadb-package)
    -   [*crayon* package](#crayon-package)
-   [Database connection](#database-connection)
-   [Password storage](#password-storage)
-   [*DBI* objects](#dbi-objects)
    -   [DBIDriver-class](#dbidriver-class)
    -   [DBIConnection-class](#dbiconnection-class)
    -   [DBIResult-class](#dbiresult-class)
-   [*DBI* functions in *rocker*](#dbi-functions-in-rocker)
    -   [List of functions](#list-of-functions)
-   [Transaction](#transaction)
-   [Usage of S3 and R6 functions](#usage-of-s3-and-r6-functions)
-   [Further help](#further-help)

<!-- README.md is generated from README.Rmd. Please edit that file -->

# *rocker* – *R6* database interface class wrapping *DBI*

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/rocker)](https://cran.r-project.org/package=rocker)
[![GitHub
version](https://img.shields.io/badge/devel%20version-GitHub-yellow.svg)](https://github.com/nikolaus77/rocker)
[![R-CMD-check](https://github.com/nikolaus77/rocker/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/nikolaus77/rocker/actions/workflows/check-standard.yaml)
[![codecov](https://codecov.io/gh/nikolaus77/rocker/branch/main/graph/badge.svg)](https://app.codecov.io/gh/nikolaus77/rocker)
[![License:
MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
<!-- badges: end -->

[*R6*](https://github.com/r-lib/R6) class interface for handling
relational database connections using
[*DBI*](https://github.com/r-dbi/DBI) package as backend. The class
allows handling of connections to
e.g. [PostgreSQL](https://www.postgresql.org),
[MariaDB](https://mariadb.org) and
[SQLite](https://www.sqlite.org/index.html). The purpose is having an
intuitive object allowing straightforward handling of SQL databases.

# Installation

Installation of current released version from CRAN

``` r
install.packages("rocker")
```

Installation of current development version from GitHub

``` r
install.packages("devtools")
devtools::install_github("nikolaus77/rocker")
```

# New *rocker* class object

Create new *rocker* database handling object

Option 1

``` r
db <- rocker::newDB() # New database handling object
#> dctr | New object
```

Option 2

``` r
db <- rocker::rocker$new() # New database handling object
#> dctr | New object
```

**Terminal output**

Controlling terminal output

``` r
db <- rocker::newDB(verbose = TRUE) # New database handling object
#> dctr | New object
db$setupPostgreSQL()
#> Dctr | Driver load RPostgres
db$unloadDriver()
#> dctr | Driver unload RPostgres
```

``` r
db$verbose <- FALSE # Terminal output off
db$setupPostgreSQL()
db$unloadDriver()
```

``` r
db$verbose <- TRUE # Terminal output on (default)
db$setupPostgreSQL()
#> Dctr | Driver load RPostgres
db$unloadDriver()
#> dctr | Driver unload RPostgres
```

Structure of terminal output

    Dctr | Driver load RSQLite
    D                          = Driver     (D = loaded,    d = not set)
     c                         = Connection (C = opened,    c = closed)
      t                        = Transation (T = active,    t = no tranastion)
       r                       = Result     (R = available, r = no result)
           Driver load RSQLite = Message text

**Optional object ID**

Optionally, rocker object can be labeled with an ID. This can be helpful
in case terminal output of multiple rocker objects need to be
distinguished.

``` r
db1 <- rocker::newDB(id = "myDB 1") # New database handling object with ID
#> myDB 1 | dctr | New object id myDB 1
db2 <- rocker::newDB(id = "myDB 2") # New database handling object with ID
#> myDB 2 | dctr | New object id myDB 2
db1$setupPostgreSQL()
#> myDB 1 | Dctr | Driver load RPostgres
db2$setupMariaDB()
#> myDB 2 | Dctr | Driver load RMariaDB
db1$unloadDriver()
#> myDB 1 | dctr | Driver unload RPostgres
db2$unloadDriver()
#> myDB 2 | dctr | Driver unload RMariaDB
```

``` r
db1$id <- NULL # Remove ID
db1$setupSQLite()
#> Dctr | Driver load RSQLite
db1$unloadDriver()
#> dctr | Driver unload RSQLite
```

``` r
db1$id <- "newID 1" # Add new ID
db1$setupSQLite()
#> newID 1 | Dctr | Driver load RSQLite
db1$unloadDriver()
#> newID 1 | dctr | Driver unload RSQLite
```

**Object properties**

Object properties are stored in the info field and can be displayed by
print function.

``` r
db <- rocker::newDB() # New database handling object
#> dctr | New object
db$setupPostgreSQL()
#> Dctr | Driver load RPostgres
db$info
#> $package
#> [1] "RPostgres"
#> 
#> $host
#> [1] "127.0.0.1"
#> 
#> $port
#> [1] "5432"
#> 
#> $dbname
#> [1] "mydb"
```

``` r
db
#> id          null
#> package     RPostgres
#> host        127.0.0.1
#> port        5432
#> dbname      mydb
#> driver      true
#> connection  false
#> transaction false
#> result      false
#> verbose     true
```

``` r
db$print()
#> id          null
#> package     RPostgres
#> host        127.0.0.1
#> port        5432
#> dbname      mydb
#> driver      true
#> connection  false
#> transaction false
#> result      false
#> verbose     true
```

``` r
print(db)
#> id          null
#> package     RPostgres
#> host        127.0.0.1
#> port        5432
#> dbname      mydb
#> driver      true
#> connection  false
#> transaction false
#> result      false
#> verbose     true
```

``` r
db$unloadDriver()
#> dctr | Driver unload RPostgres
```

# Additional packages and database types

The listed packages are required for some functions of *rocker*.

## *RSQLite* package

[*RSQLite*](https://github.com/r-dbi/RSQLite) package for handling of
SQLite database connections. It is required for the setupSQLite()
function of *rocker* class.

``` r
install.packages("RSQLite")
```

**Setup database**

Option 1

``` r
db <- rocker::newDB() # New database handling object
#> dctr | New object
db$setupSQLite( # Setup SQLite database
  dbname = ":memory:"
)
#> Dctr | Driver load RSQLite
db$unloadDriver() # Reset database handling object
#> dctr | Driver unload RSQLite
```

Option 2

``` r
db <- rocker::newDB() # New database handling object
#> dctr | New object
db$setupDriver( # Setup SQLite database
  drv = RSQLite::SQLite(),
  dbname = ":memory:"
)
#> Dctr | Driver load RSQLite
db$unloadDriver() # Reset database handling object
#> dctr | Driver unload RSQLite
```

## *RPostgres* package

[*RPostgres*](https://github.com/r-dbi/RPostgres) package for handling
of PostgreSQL database connections. It is required for the
setupPostgreSQL() function of *rocker* class.

``` r
install.packages("RPostgres")
```

**Setup database**

Option 1

``` r
db <- rocker::newDB() # New database handling object
#> dctr | New object
db$setupPostgreSQL( # Setup PostgreSQL database
  host = "127.0.0.1", port = "5432", dbname = "mydb",
  user = "postgres", password = "password"
)
#> Dctr | Driver load RPostgres
db$unloadDriver() # Reset database handling object
#> dctr | Driver unload RPostgres
```

Option 2

``` r
db <- rocker::newDB() # New database handling object
#> dctr | New object
db$setupDriver( # Setup PostgreSQL database
  drv = RPostgres::Postgres(),
  host = "127.0.0.1", port = "5432", dbname = "mydb",
  user = "postgres", password = "password"
)
#> Dctr | Driver load RPostgres
db$unloadDriver() # Reset database handling object
#> dctr | Driver unload RPostgres
```

## *RMariaDB* package

[*RMariaDB*](https://github.com/r-dbi/RMariaDB) package for handling of
MariaDB and MySQL database connections. It is required for the
setupMariaDB() function of *rocker* class.

``` r
install.packages("RMariaDB")
```

**Setup database**

Option 1

``` r
db <- rocker::newDB() # New database handling object
#> dctr | New object
db$setupMariaDB( # Setup MariaDB database
  host = "127.0.0.1", port = "3306", dbname = "mydb",
  user = "root", password = "password"
)
#> Dctr | Driver load RMariaDB
db$unloadDriver() # Reset database handling object
#> dctr | Driver unload RMariaDB
```

Option 2

``` r
db <- rocker::newDB() # New database handling object
#> dctr | New object
db$setupDriver( # Setup MariaDB database
  drv = RMariaDB::MariaDB(),
  host = "127.0.0.1", port = "3306", dbname = "mydb",
  user = "root", password = "password"
)
#> Dctr | Driver load RMariaDB
db$unloadDriver() # Reset database handling object
#> dctr | Driver unload RMariaDB
```

## *crayon* package

The [*crayon*](https://github.com/r-lib/crayon) package is required for
colored terminal output. If missing terminal output is monochrome.

``` r
install.packages("crayon")
```

# Database connection

There are different ways to open a connection and to get data.

Prepare database with a table

``` r
db <- rocker::newDB() # New database handling object
#> dctr | New object
db$setupSQLite(dbname = tempfile()) # Setup SQLite database
#> Dctr | Driver load RSQLite
db$connect() # Open connection
#> DCtr | Database connected
db$writeTable("mtcars", mtcars) # Create table for testing
#> DCtr | Write table mtcars columns mpg, cyl, disp, hp, drat, wt, qsec, vs, am, gear, carb rows 32
db$disconnect() # Close connection
#> Dctr | Database disconnected
```

**Example 1**

Get query with automatic connection / disconnection

``` r
output <- db$getQuery("SELECT * FROM mtcars;") # Get query
#> DCtr | Database connected 
#> DCtR | Send query 21 characters 
#> DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> DCtR | Rows fetched 32 
#> DCtR | Has completed yes 
#> DCtr | Clear result 
#> Dctr | Database disconnected
```

**Example 2**

Get query with manual connection / disconnection

``` r
db$connect() # Open connection
#> DCtr | Database connected
output1 <- db$getQuery("SELECT * FROM mtcars;") # Get query 1
#> DCtR | Send query 21 characters 
#> DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> DCtR | Rows fetched 32 
#> DCtR | Has completed yes 
#> DCtr | Clear result
output2 <- db$getQuery("SELECT * FROM mtcars;", 15) # Get query 2
#> DCtR | Send query 21 characters 
#> DCtR | Fetch rows 15 -> Received 15 rows, 11 columns, 3416 bytes 
#> DCtR | Rows fetched 15 
#> DCtR | Has completed no 
#> DCtR | Fetch rows 15 -> Received 15 rows, 11 columns, 3416 bytes 
#> DCtR | Rows fetched 30 
#> DCtR | Has completed no 
#> DCtR | Fetch rows 15 -> Received 2 rows, 11 columns, 2184 bytes 
#> DCtR | Rows fetched 32 
#> DCtR | Has completed yes 
#> DCtr | Clear result
db$disconnect() # Close connection
#> Dctr | Database disconnected
```

**Example 3**

Function getQuery() is a combination of functions sendQuery(), fetch()
and clearResult().

``` r
db$connect() # Open connection
#> DCtr | Database connected
db$sendQuery("SELECT * FROM mtcars;") # Send query
#> DCtR | Send query 21 characters
output <- db$fetch() # Fetch result
#> DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes
db$clearResult() # Clean up result
#> DCtr | Clear result
db$disconnect() # Close connection
#> Dctr | Database disconnected
```

Clean up

``` r
db$unloadDriver() # Reset database handling object
#> dctr | Driver unload RSQLite
```

# Password storage

Some efforts were undertaken to encrypt and to protect the password in
the private area of the class. The class stores the password hidden and
inaccessible. **Please let me know, in case you discover a way how to
access the password!**

``` r
db <- rocker::newDB() # New database handling object
#> dctr | New object
db$setupDriver( # Setup PostgreSQL database with stored password (password and user are hidden - default behavior)
  RPostgres::Postgres(),
  host = "127.0.0.1", port = "5432", dbname = "mydb",
  user = "postgres", password = "password",
  protect = c("password", "user")
)
#> Dctr | Driver load RPostgres
```

``` r
db$connect() # Open connection 1; Password is stored in the class and does not need to be provided.
#> DCtr | Database connected
output1 <- db$getQuery("SELECT * FROM mtcars;") # Get query 1
#> DCtR | Send query 21 characters 
#> DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> DCtR | Rows fetched 32 
#> DCtR | Has completed yes 
#> DCtr | Clear result
db$disconnect() # Close connection 1
#> Dctr | Database disconnected
```

``` r
db$connect() # Open connection 2; Password is stored in the class and does not need to be provided.
#> DCtr | Database connected
output2 <- db$getQuery("SELECT * FROM mtcars;") # Get query 2
#> DCtR | Send query 21 characters 
#> DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> DCtR | Rows fetched 32 
#> DCtR | Has completed yes 
#> DCtr | Clear result
db$disconnect() # Close connection 2
#> Dctr | Database disconnected
```

``` r
db$unloadDriver() # Reset database handling object
#> dctr | Driver unload RPostgres
```

In case you do not want to store the password in the class, you will
need to provide it each time a connection is opened.

``` r
db <- rocker::newDB() # New database handling object
#> dctr | New object
db$setupDriver( # Setup PostgreSQL database without stored password
  RPostgres::Postgres(),
  host = "127.0.0.1", port = "5432", dbname = "mydb",
  user = "postgres"
)
#> Dctr | Driver load RPostgres
```

``` r
db$connect(password = "password") # Open connection 1; Password needs to be provided.
#> DCtr | Database connected
output1 <- db$getQuery("SELECT * FROM mtcars;") # Get query 1
#> DCtR | Send query 21 characters 
#> DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> DCtR | Rows fetched 32 
#> DCtR | Has completed yes 
#> DCtr | Clear result
db$disconnect() # Close connection 1
#> Dctr | Database disconnected
```

``` r
db$connect(password = "password") # Open connection 2; Password needs to be provided.
#> DCtr | Database connected
output2 <- db$getQuery("SELECT * FROM mtcars;") # Get query 2
#> DCtR | Send query 21 characters 
#> DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> DCtR | Rows fetched 32 
#> DCtR | Has completed yes 
#> DCtr | Clear result
db$disconnect() # Close connection 2
#> Dctr | Database disconnected
```

``` r
db$unloadDriver() # Reset database handling object
#> dctr | Driver unload RPostgres
```

# *DBI* objects

*rocker* class encapsulates the *DBI* objects driver, connection and
result. If required, these objects can be directly used with *DBI*
functions. **However, it is recommended to use this option with care!**
Direct usage of *DBI* functions, may disrupt proper function of *rocker*
class. Many *DBI* functions are implemented in *rocker* class. Whenever
possible, use the *rocker* class functions.

Prepare object

``` r
db <- rocker::newDB() # New database handling object
#> dctr | New object
db$.drv # Empty driver
#> NULL
db$.con # Empty connection
#> NULL
db$.res # Empty result
#> NULL
```

## DBIDriver-class

``` r
db$setupSQLite() # Setup SQLite database
#> Dctr | Driver load RSQLite
db$.drv # 'DBI' DBIDriver-class
#> <SQLiteDriver>
```

``` r
db$getInfoDrv() # 'rocker' class function
#> Dctr | Driver info 2.2.9 (driver.version), 3.37.0 (client.version)
#> $driver.version
#> [1] '2.2.9'
#> 
#> $client.version
#> [1] '3.37.0'
```

``` r
DBI::dbGetInfo(db$.drv) # Direct usage of 'DBI' function on 'rocker' class
#> $driver.version
#> [1] '2.2.9'
#> 
#> $client.version
#> [1] '3.37.0'
```

``` r
RSQLite::dbGetInfo(db$.drv) # Direct usage of driver package, 'RSQLite', function on 'rocker' class
#> $driver.version
#> [1] '2.2.9'
#> 
#> $client.version
#> [1] '3.37.0'
```

## DBIConnection-class

``` r
db$connect() # Open connection
#> DCtr | Database connected
db$.con # 'DBI' DBIConnection-class
#> <SQLiteConnection>
#>   Path: :memory:
#>   Extensions: TRUE
```

``` r
db$getInfoCon() # 'rocker' class function
#> DCtr | Connection info 3.37.0 (db.version), :memory: (dbname), NA (username), NA (host), NA (port)
#> $db.version
#> [1] "3.37.0"
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

``` r
DBI::dbGetInfo(db$.con) # Direct usage of 'DBI' function on 'rocker' class
#> $db.version
#> [1] "3.37.0"
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

``` r
RSQLite::dbGetInfo(db$.con) # Direct usage of driver package, 'RSQLite', function on 'rocker' class
#> $db.version
#> [1] "3.37.0"
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
#> DCtr | Write table mtcars columns mpg, cyl, disp, hp, drat, wt, qsec, vs, am, gear, carb rows 32
```

## DBIResult-class

``` r
db$sendQuery("SELECT * FROM mtcars;") # Send query
#> DCtR | Send query 21 characters
db$.res # 'DBI' DBIResult-class
#> <SQLiteResult>
#>   SQL  SELECT * FROM mtcars;
#>   ROWS Fetched: 0 [incomplete]
#>        Changed: 0
```

``` r
db$getInfoRes() # 'rocker' class function
#> DCtR | Result info SELECT * FROM mtcars; (statement), 0 (row.count), 0 (rows.affected), FALSE (has.completed)
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

``` r
DBI::dbGetInfo(db$.res) # Direct usage of 'DBI' function on 'rocker' class
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

``` r
RSQLite::dbGetInfo(db$.res) # Direct usage of driver package, 'RSQLite', function on 'rocker' class
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
#> DCtr | Clear result
db$.res # Empty result
#> NULL
db$disconnect() # Close connection
#> Dctr | Database disconnected
db$.con # Empty connection
#> NULL
db$unloadDriver() # Reset database handling object
#> dctr | Driver unload RSQLite
db$.drv # Empty driver
#> NULL
```

# *DBI* functions in *rocker*

Generally, *rocker* function names are related to *DBI* function names.
In *rocker* functions, the leading **db** is removed.

In *DBI* most functions need to be supplied with a driver
<sup>(drv)</sup>, connection <sup>(conn)</sup> or result
<sup>(res)</sup> object. In *rocker*, functions automatically access the
corresponding objects <sup>(.drv,</sup> <sup>.con</sup> <sup>and</sup>
<sup>.res)</sup> stored in the class.

***DBI* example**

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

***rocker* example**

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

## List of functions

| *rocker* function | Corresponding *DBI* function                             | *DBI* object used                 | Comment                                                                                           |
|-------------------|----------------------------------------------------------|-----------------------------------|---------------------------------------------------------------------------------------------------|
| initialize()      | *none*                                                   | *none*                            |                                                                                                   |
| print()           | *none*                                                   | *none*                            |                                                                                                   |
| setupDriver()     | *none*                                                   | *driver from appropriate package* | Usually, parameters provided to dbConnect() in *DBI* are provided to setupDriver() in *rocker*    |
| setupPostgreSQL() | *none*                                                   | *none*                            | RPostgres::Postgres() is used with *rocker* function setupDriver()                                |
| setupMariaDB()    | *none*                                                   | *none*                            | RMariaDB::MariaDB() is used with *rocker* function setupDriver()                                  |
| setupSQLite()     | *none*                                                   | *none*                            | RSQLite::SQLite() is used with *rocker* function setupDriver()                                    |
| unloadDriver()    | dbUnloadDriver()                                         | driver                            |                                                                                                   |
| canConnect()      | dbCanConnect()                                           | driver                            | Usually, parameters provided to dbCanConnect() in *DBI* are provided to setupDriver() in *rocker* |
| connect()         | dbConnect()                                              | driver                            | Usually, parameters provided to dbConnect() in *DBI* are provided to setupDriver() in *rocker*    |
| disconnect()      | dbDisconnect()                                           | connection                        |                                                                                                   |
| sendQuery()       | dbSendQuery()                                            | connection                        |                                                                                                   |
| getQuery()        | Is **not** using dbGetQuery(), but has the same function | connection                        | Especially, combination of *rocker* functions sendQuery(), fetch() and clearResult()              |
| sendStatement()   | dbSendStatement()                                        | connection                        |                                                                                                   |
| execute()         | Is **not** using dbExecute(), but has the same function  | connection                        | Especially, combination of *rocker* functions sendStatement() and clearResult()                   |
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

# Transaction

Setup database and a table with 32 rows.

``` r
db <- rocker::newDB() # New database handling object
#> dctr | New object
db$setupSQLite() # Setup SQLite database
#> Dctr | Driver load RSQLite
db$connect() # Open connection
#> DCtr | Database connected
db$writeTable("mtcars", mtcars) # Create table for testing
#> DCtr | Write table mtcars columns mpg, cyl, disp, hp, drat, wt, qsec, vs, am, gear, carb rows 32
output <- db$getQuery("SELECT * FROM mtcars;") # Get query -> 32 rows
#> DCtR | Send query 21 characters 
#> DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes 
#> DCtR | Rows fetched 32 
#> DCtR | Has completed yes 
#> DCtr | Clear result
db$transaction # Transaction indicator
#> [1] FALSE
```

Starting with a table with 32 rows, begin transaction 1. Delete 15 rows
and commit transaction. Operations results in a table with 17 rows.

``` r
db$begin() # Start transaction 1
#> DCTr | Transaction begin
db$transaction # Transaction indicator
#> [1] TRUE
AFFECTED <- db$execute("DELETE FROM mtcars WHERE gear = 3;") # Modify table -> 15 rows
#> DCTR | Send statement 34 characters 
#> DCTR | Rows affected 15 
#> DCTr | Clear result
db$commit() # Commit transaction 1
#> DCtr | Transaction commit
db$transaction # Transaction indicator
#> [1] FALSE
output <- db$getQuery("SELECT * FROM mtcars;") # Get query -> 17 rows
#> DCtR | Send query 21 characters 
#> DCtR | Fetch rows all -> Received 17 rows, 11 columns, 3504 bytes 
#> DCtR | Rows fetched 17 
#> DCtR | Has completed yes 
#> DCtr | Clear result
```

Starting with a table with 17 rows, begin transaction 2. Delete 5 rows
and rollback transaction. Operations results in a table with 17 rows.

``` r
db$begin() # Start transaction 2
#> DCTr | Transaction begin
db$transaction # Transaction indicator
#> [1] TRUE
AFFECTED <- db$execute("DELETE FROM mtcars WHERE gear = 5;") # Modify table -> 5 rows
#> DCTR | Send statement 34 characters 
#> DCTR | Rows affected 5 
#> DCTr | Clear result
output <- db$getQuery("SELECT * FROM mtcars;") # Get query -> 12 rows
#> DCTR | Send query 21 characters 
#> DCTR | Fetch rows all -> Received 12 rows, 11 columns, 3416 bytes 
#> DCTR | Rows fetched 12 
#> DCTR | Has completed yes 
#> DCTr | Clear result
db$rollback() # Rollback transaction 2
#> DCtr | Transaction rollback
db$transaction # Transaction indicator
#> [1] FALSE
output <- db$getQuery("SELECT * FROM mtcars;") # Get query -> 17 rows
#> DCtR | Send query 21 characters 
#> DCtR | Fetch rows all -> Received 17 rows, 11 columns, 3504 bytes 
#> DCtR | Rows fetched 17 
#> DCtR | Has completed yes 
#> DCtr | Clear result
```

Clean up

``` r
db$disconnect() # Close connection
#> Dctr | Database disconnected
db$unloadDriver() # Reset database handling object
#> dctr | Driver unload RSQLite
```

# Usage of S3 and R6 functions

Although *rocker* is a *R6* class, functions can be also accesses in
classical S3 way.

**S3 example**

``` r
library(rocker)
db <- newDB()
#> dctr | New object
setupDriver(db, drv = RSQLite::SQLite(), dbname = ":memory:")
#> Dctr | Driver load RSQLite
connect(db)
#> DCtr | Database connected
writeTable(db, "mtcars", mtcars)
#> DCtr | Write table mtcars columns mpg, cyl, disp, hp, drat, wt, qsec, vs, am, gear, carb rows 32
sendQuery(db, "SELECT * FROM mtcars;")
#> DCtR | Send query 21 characters
output <- fetch(db)
#> DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes
clearResult(db)
#> DCtr | Clear result
disconnect(db)
#> Dctr | Database disconnected
unloadDriver(db)
#> dctr | Driver unload RSQLite
```

**R6 example**

``` r
db <- rocker::newDB()
#> dctr | New object
db$setupDriver(drv = RSQLite::SQLite(), dbname = ":memory:")
#> Dctr | Driver load RSQLite
db$connect()
#> DCtr | Database connected
db$writeTable("mtcars", mtcars)
#> DCtr | Write table mtcars columns mpg, cyl, disp, hp, drat, wt, qsec, vs, am, gear, carb rows 32
db$sendQuery("SELECT * FROM mtcars;")
#> DCtR | Send query 21 characters
output <- db$fetch()
#> DCtR | Fetch rows all -> Received 32 rows, 11 columns, 4824 bytes
db$clearResult()
#> DCtr | Clear result
db$disconnect()
#> Dctr | Database disconnected
db$unloadDriver()
#> dctr | Driver unload RSQLite
```

# Further help

Please read the documentation of *rocker* class.

``` r
help(rocker)
```

Reading of *DBI* package documentation is recommended.

-   [CRAN](https://cran.r-project.org/package=DBI)
-   [GitHub](https://github.com/r-dbi/DBI)
