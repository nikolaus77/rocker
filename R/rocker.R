
#' Database Interface Class
#'
#' @description
#' \link{R6} class interface for handling database connections using \link{DBI} package as backend. The class allows handling of connections to e.g. PostgreSQL, MariaDB and SQLite.
#' @format \link[R6:R6Class]{R6Class}
#' @examples
#' # New database handling object
#' db <- rocker::newDB()
#'
#' # Setup SQLite database
#' db$setupSQLite()
#'
#' # Open connection
#' db$connect()
#'
#' # Write table
#' db$writeTable("mtcars", mtcars)
#'
#' # Get query
#' output <- db$getQuery("SELECT * FROM mtcars;")
#'
#' # Close connection
#' db$disconnect()
#'
#' # Reset database handling object
#' db$unloadDriver()
#' @export
rocker <- R6::R6Class(

  class = FALSE,
  cloneable = FALSE,
  lock_class = TRUE,
  lock_objects = TRUE,

  # public ---------------------------------------------------------------------
  public = list(

    # general ------------------------------------------------------------------

    #' @description
    #' Generate new instance of class.
    #' @param ... Not used yet
    #' @return New instance of class
    initialize = function(...)
      private$packages <- testPackages(c("crayon", "RMariaDB", "RPostgres", "RSQLite")),

    #' @description
    #' Print object information.
    #' @return Invisible self
    print = function() {
      TXT <- NULL
      for (i in names(private$.info))
        TXT <- rbind(TXT, c(i, ifelse(is.null(private$.info[[i]]), private$textColor(2, "null"), private$textColor(1, private$.info[[i]]))))
      TXT <- rbind(
        TXT,
        c("driver", ifelse(is.null(private$..drv), private$textColor(2, "false"), private$textColor(3, "true"))),
        c("connection", ifelse(is.null(private$..con), private$textColor(2, "false"), private$textColor(3, "true"))),
        c("transaction", ifelse(private$.transaction, private$textColor(3, "true"), private$textColor(2, "false"))),
        c("result", ifelse(is.null(private$..res), private$textColor(2, "false"), private$textColor(3, "true"))),
        # c("settings", ifelse(is.null(private$settings), private$textColor(2, "false"), private$textColor(3, "true"))),
        c("verbose", ifelse(private$.verbose, private$textColor(3, "true"), private$textColor(2, "false")))
      )
      LEN <- max(nchar(TXT[,1]))
      for (i in 1:nrow(TXT))
        cat(TXT[i,1], paste(rep(" ", LEN - nchar(TXT[i,1]) + 1), collapse = ""), TXT[i,2], "\n", sep = "")
      return(invisible(self))
    },

    # driver -------------------------------------------------------------------

    #' @description
    #' Setup database driver and define connection parameters.
    #' @param drv Driver object from suitable package e.g. \code{\link[RPostgres:Postgres]{RPostgres::Postgres()}}, \code{\link[RMariaDB:MariaDBDriver-class]{RMariaDB::MariaDB()}} and \code{\link[RSQLite:SQLite]{RSQLite::SQLite()}}
    #' @param ... Suitable parameters passed to \code{\link[DBI:dbConnect]{DBI::dbConnect()}} e.g. host, port, dbname, user and password
    #' @param protect Parameters to be hidden
    #' @return Invisible self
    setupDriver = function(drv, ..., protect = c("password", "user")) {
      private$check("drv", FALSE)
      private$..drv <- drv
      private$check("drv", TRUE)
      SETTINGS <- list(...)
      private$enclosEnvProtect()
      private$settingsWrite(SETTINGS)
      SETTINGS <- SETTINGS[!(names(SETTINGS) %in% protect)]
      private$.info <- c(list(package = attr(class(private$..drv), "package")), SETTINGS)
      private$note(sprintf("Driver load %s", private$textColor(1, private$.info$package)))
      private$functions <- testPackageFunction(private$.info$package, c(
        "dbUnloadDriver",
        "dbCanConnect",
        "dbConnect",
        "dbDisconnect",
        "dbSendQuery",
        "dbSendStatement",
        "dbFetch",
        "dbHasCompleted",
        "dbGetRowsAffected",
        "dbGetRowCount",
        "dbColumnInfo",
        "dbGetStatement",
        "dbClearResult",
        "dbBegin",
        "dbCommit",
        "dbRollback",
        "dbGetInfo",
        "dbIsValid",
        "dbCreateTable",
        "dbAppendTable",
        "dbWriteTable",
        "dbReadTable",
        "dbRemoveTable",
        "dbExistsTable",
        "dbListFields",
        "dbListObjects",
        "dbListTables"
      ))
      if (!all(unlist(private$functions))) error(sprintf("Package %s is not providing all functions: %s", private$.info$package, paste(names(private$functions)[!unlist(private$functions)], collapse = ", ")), TRUE)
      return(invisible(self))
    },

    #' @description
    #' Setup database driver and define connection parameters for PostgreSQL using \link[RPostgres:Postgres]{RPostgres} package.
    #' Wrapper for setupDriver() function.
    #' @param host Host name or IP number
    #' @param port Port number
    #' @param dbname Database name
    #' @param user User name
    #' @param password Password
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbConnect]{DBI::dbConnect()}}
    #' @param protect Parameters to be hidden
    #' @return Invisible self
    setupPostgreSQL = function(host = "127.0.0.1", port = "5432", dbname = "mydb", user = "postgres", password = "password", ..., protect = c("password", "user")) {
      if (!private$packages$RPostgres)
        error("Package RPostgres not installed")
      testParameter(list(...), "drv")
      return(self$setupDriver(RPostgres::Postgres(), host = host, port = port, dbname = dbname, user = user, password = password, ..., protect = protect))
    },

    #' @description
    #' Setup database driver and define connection parameters for MariaDB using \link[RMariaDB:RMariaDB-package]{RMariaDB} package.
    #' Wrapper for setupDriver() function.
    #' @param host Host name or IP number
    #' @param port Port number
    #' @param dbname Database name
    #' @param user User name
    #' @param password Password
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbConnect]{DBI::dbConnect()}}
    #' @param protect Parameters to be hidden
    #' @return Invisible self
    setupMariaDB = function(host = "127.0.0.1", port = "3306", dbname = "mydb", user = "root", password = "password", ..., protect = c("password", "user")) {
      if (!private$packages$RMariaDB)
        error("Package RMariaDB not installed")
      testParameter(list(...), "drv")
      return(self$setupDriver(RMariaDB::MariaDB(), host = host, port = port, dbname = dbname, user = user, password = password, ..., protect = protect))
    },

    #' @description
    #' Setup database driver and define connection parameters for SQLite using \link[RSQLite:SQLite]{RSQLite} package.
    #' Wrapper for setupDriver() function.
    #' @param dbname Database name
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbConnect]{DBI::dbConnect()}}
    #' @param protect Parameters to be hidden
    #' @return Invisible self
    setupSQLite = function(dbname = ":memory:", ..., protect = c("password", "user")){
      if (!private$packages$RSQLite)
        error("Package RSQLite not installed")
      testParameter(list(...), "drv")
      return(self$setupDriver(RSQLite::SQLite(), dbname = dbname, ..., protect = protect))
    },

    #' @description
    #' Reset database driver and connection parameters.
    #' @param ... Optional, suitable parameters passed to \code{\link[DBI:dbDriver]{DBI::dbUnloadDriver()}}
    #' @return Invisible self
    unloadDriver = function(...) {
      private$check("con", FALSE)
      private$check("drv", TRUE)
      testParameter(list(...), "drv")
      if (private$functions$dbUnloadDriver)
        DBI::dbUnloadDriver(private$..drv, ...)
      private$..drv <- NULL
      private$key <- NULL
      private$settings <- NULL
      private$functions <- NULL
      private$enclosEnvRestore()
      private$note(sprintf("Driver unload %s", private$textColor(1, private$.info$package)))
      private$.info <- NULL
      return(invisible(self))
    },

    # connection ---------------------------------------------------------------

    #' @description
    #' Test connection parameters.
    #' @param ... Optional, suitable parameters passed to \code{\link[DBI:dbCanConnect]{DBI::dbCanConnect()}}
    #' @return TRUE or FALSE
    canConnect = function(...) {
      private$check("con", FALSE)
      private$check("drv", TRUE)
      testParameter(list(...), "drv")
      SETTINGS <- c(list(drv = private$..drv), private$settingsRead(), list(...))
      return(do.call(DBI::dbCanConnect, SETTINGS))
    },

    #' @description
    #' Establish database connection using stored parameters.
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbConnect]{DBI::dbConnect()}}
    #' @return Invisible self
    connect = function(...) {
      private$check("con", FALSE)
      private$check("drv", TRUE)
      testParameter(list(...), "drv")
      SETTINGS <- c(list(drv = private$..drv), private$settingsRead(), list(...))
      private$..con <- do.call(DBI::dbConnect, SETTINGS)
      private$check("con", TRUE)
      private$note("Database connected")
      return(invisible(self))
    },

    #' @description
    #' Disconnect database.
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbDisconnect]{DBI::dbDisconnect()}}
    #' @return Invisible self
    disconnect = function(...) {
      private$check("tra", FALSE)
      private$check("res", FALSE)
      private$check("con", TRUE)
      testParameter(list(...), "conn")
      DBI::dbDisconnect(private$..con, ...)
      private$..con <- NULL
      private$note("Database disconnected")
      return(invisible(self))
    },

    # result -------------------------------------------------------------------

    #' @description
    #' Send SQL query to database.
    #' @param statement SQL query (\code{SELECT})
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbSendQuery]{DBI::dbSendQuery()}}
    #' @return Invisible self
    sendQuery = function(statement, ...) {
      private$check("res", FALSE)
      private$check("con", TRUE)
      testParameter(list(...), "conn")
      private$..res <- DBI::dbSendQuery(private$..con, statement, ...)
      private$check("res", TRUE)
      private$note(sprintf("Send query %s characters", private$textColor(1, as.character(nchar(statement)))))
      return(invisible(self))
    },

    #' @description
    #' Retrieve SQL query from database.
    #' Combination of functions sendQuery(), fetch() and clearResult().
    #' If required, database is automatically connected and disconnected.
    #' @param statement SQL query (\code{SELECT})
    #' @param n Number of record to be fetched at once. All records will be fetched.
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbSendQuery]{DBI::dbSendQuery()}}
    #' @return Records
    getQuery = function(statement, n = -1, ...) {
      if (is.null(private$..con)) {
        self$connect()
        AUTOCONNECT <- TRUE
      } else {
        AUTOCONNECT <- FALSE
      }
      testParameter(list(...), "conn")
      self$sendQuery(statement, ...)
      OUTPUT <- self$fetch(n)
      if (private$.verbose & private$functions$dbGetRowCount)
        TOTAL <- self$getRowCount()
      while (!self$hasCompleted()) {
        OUTPUT <- rbind(OUTPUT, self$fetch(n))
        if (private$.verbose & private$functions$dbGetRowCount)
          TOTAL <- self$getRowCount()
      }
      self$clearResult()
      if (AUTOCONNECT)
        self$disconnect()
      return(OUTPUT)
    },

    #' @description
    #' Send SQL statement to database.
    #' @param statement SQL statement (\code{UPDATE, DELETE, INSERT INTO, ...})
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbSendStatement]{DBI::dbSendStatement()}}
    #' @return Invisible self
    sendStatement = function(statement, ...) {
      private$check("res", FALSE)
      private$check("con", TRUE)
      testParameter(list(...), "conn")
      private$..res <- DBI::dbSendStatement(private$..con, statement, ...)
      private$check("res", TRUE)
      private$note(sprintf("Send statement %s characters", private$textColor(1, as.character(nchar(statement)))))
      return(invisible(self))
    },

    #' @description
    #' Execute SQL statement in database.
    #' Combination of functions execute and clearResult.
    #' If required, database is automatically connected and disconnected.
    #' @param statement SQL statement (\code{UPDATE, DELETE, INSERT INTO, ...})
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbSendStatement]{DBI::dbSendStatement()}}
    #' @return Number of affected rows
    execute = function(statement, ...) {
      if (is.null(private$..con)) {
        self$connect()
        AUTOCONNECT <- TRUE
      } else {
        AUTOCONNECT <- FALSE
      }
      testParameter(list(...), "conn")
      self$sendStatement(statement, ...)
      ROWS <- self$getRowsAffected()
      self$clearResult()
      if (AUTOCONNECT)
        self$disconnect()
      return(ROWS)
    },

    #' @description
    #' Fetch SQL query result from database.
    #' @param n Number of record to be fetched
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbFetch]{DBI::dbFetch()}}
    #' @return Records
    fetch = function(n = -1, ...) {
      private$check("res", TRUE)
      testParameter(list(...), "res")
      OUTPUT <- DBI::dbFetch(private$..res, n, ...)
      private$note(sprintf("Fetch rows %s -> Received %s rows, %s columns, %s bytes", private$textColor(1, ifelse(n == -1, "all", as.character(n))), private$textColor(1, as.character(nrow(OUTPUT))), private$textColor(1, as.character(ncol(OUTPUT))), private$textColor(1, as.character(as.numeric(object.size(OUTPUT))))))
      return(OUTPUT)
    },

    #' @description
    #' Information whether all records were retrieved.
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbHasCompleted]{DBI::dbHasCompleted()}}
    #' @return TRUE or FALSE
    hasCompleted = function(...) {
      private$check("res", TRUE)
      testParameter(list(...), "res")
      COMPLETED <- DBI::dbHasCompleted(private$..res, ...)
      private$note(sprintf("Has completed %s", private$textColor(1, ifelse(COMPLETED, "yes", "no"))))
      return(COMPLETED)
    },

    #' @description
    #' Information on number of affected rows.
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbGetRowsAffected]{DBI::dbGetRowsAffected()}}
    #' @return Number of affected rows
    getRowsAffected = function(...) {
      private$check("res", TRUE)
      testParameter(list(...), "res")
      ROWS <- DBI::dbGetRowsAffected(private$..res, ...)
      private$note(sprintf("Rows affected %s", private$textColor(1, as.character(ROWS))))
      return(ROWS)
    },

    #' @description
    #' Information on number of retrieved rows.
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbGetRowCount]{DBI::dbGetRowCount()}}
    #' @return Number of retrieved rows
    getRowCount = function(...) {
      private$check("res", TRUE)
      testParameter(list(...), "res")
      ROWS <- DBI::dbGetRowCount(private$..res, ...)
      private$note(sprintf("Rows fetched %s", private$textColor(1, as.character(ROWS))))
      return(ROWS)
    },

    #' @description
    #' Information on query result columns.
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbColumnInfo]{DBI::dbColumnInfo()}}
    #' @return Information table
    columnInfo = function(...) {
      private$check("res", TRUE)
      testParameter(list(...), "res")
      return(DBI::dbColumnInfo(private$..res, ...))
    },

    #' @description
    #' Information on sent statement.
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbGetStatement]{DBI::dbGetStatement()}}
    #' @return Statement text
    getStatement = function(...) {
      private$check("res", TRUE)
      testParameter(list(...), "res")
      return(DBI::dbGetStatement(private$..res, ...))
    },

    #' @description
    #' Clear query or statement result.
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbClearResult]{DBI::dbClearResult()}}
    #' @return Invisible self
    clearResult = function(...) {
      private$check("res", TRUE)
      testParameter(list(...), "res")
      DBI::dbClearResult(private$..res, ...)
      private$..res <- NULL
      private$note("Clear result")
      return(invisible(self))
    },

    # transaction --------------------------------------------------------------

    #' @description
    #' Begin transaction.
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:transactions]{DBI::dbBegin()}}
    #' @return Invisible self
    begin = function(...) {
      private$check("tra", FALSE)
      private$check("res", FALSE)
      private$check("con", TRUE)
      testParameter(list(...), "conn")
      OUTPUT <- DBI::dbBegin(private$..con, ...)
      if (!OUTPUT)
        error("Begin failed")
      private$.transaction <- TRUE
      private$note("Transaction begin")
      return(invisible(self))
    },

    #' @description
    #' Commit transaction.
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:transactions]{DBI::dbCommit()}}
    #' @return Invisible self
    commit = function(...) {
      private$check("tra", TRUE)
      private$check("res", FALSE)
      private$check("con", TRUE)
      testParameter(list(...), "conn")
      OUTPUT <- DBI::dbCommit(private$..con, ...)
      if (!OUTPUT)
        error("Commit failed")
      private$.transaction <- FALSE
      private$note("Transaction commit")
      return(invisible(self))
    },

    #' @description
    #' Rollback transaction.
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:transactions]{DBI::dbRollback()}}
    #' @return Invisible self
    rollback = function(...) {
      private$check("tra", TRUE)
      private$check("res", FALSE)
      private$check("con", TRUE)
      testParameter(list(...), "conn")
      OUTPUT <- DBI::dbRollback(private$..con, ...)
      if (!OUTPUT)
        error("Rollback failed")
      private$.transaction <- FALSE
      private$note("Transaction rollback")
      return(invisible(self))
    },

    # info ---------------------------------------------------------------------

    #' @description
    #' Information on driver object.
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbGetInfo]{DBI::dbGetInfo()}}
    #' @return Information list
    getInfoDrv = function(...) {
      private$check("drv", TRUE)
      testParameter(list(...), "dbObj")
      return(DBI::dbGetInfo(private$..drv, ...))
    },

    #' @description
    #' Information on connection object.
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbGetInfo]{DBI::dbGetInfo()}}
    #' @return Information list
    getInfoCon = function(...) {
      private$check("con", TRUE)
      testParameter(list(...), "dbObj")
      return(DBI::dbGetInfo(private$..con, ...))
    },

    #' @description
    #' Information on result object.
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbGetInfo]{DBI::dbGetInfo()}}
    #' @return Information list
    getInfoRes = function(...) {
      private$check("res", TRUE)
      testParameter(list(...), "dbObj")
      return(DBI::dbGetInfo(private$..res, ...))
    },

    #' @description
    #' Check driver object.
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbIsValid]{DBI::dbIsValid()}}
    #' @return TRUE of FALSE
    isValidDrv = function(...) {
      if (!is.null(private$..drv)) {
        testParameter(list(...), "dbObj")
        OUTPUT <- DBI::dbIsValid(private$..drv, ...)
        if (!OUTPUT) {
          private$..drv <- NULL
          error("Driver lost", TRUE)
        }
      } else {
        OUTPUT <- FALSE
      }
      return(OUTPUT)
    },

    #' @description
    #' Check connection object.
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbIsValid]{DBI::dbIsValid()}}
    #' @return TRUE of FALSE
    isValidCon = function(...) {
      if (!is.null(private$..con)) {
        testParameter(list(...), "dbObj")
        OUTPUT <- DBI::dbIsValid(private$..con, ...)
        if (!OUTPUT) {
          private$..con <- NULL
          error("Connection lost", TRUE)
        }
      } else {
        OUTPUT <- FALSE
      }
      return(OUTPUT)
    },

    #' @description
    #' Check result object.
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbIsValid]{DBI::dbIsValid()}}
    #' @return TRUE of FALSE
    isValidRes = function(...) {
      if (!is.null(private$..res)) {
        testParameter(list(...), "dbObj")
        OUTPUT <- DBI::dbIsValid(private$..res, ...)
        if (!OUTPUT) {
          private$..res <- NULL
          error("Result lost", TRUE)
        }
      } else {
        OUTPUT <- FALSE
      }
      return(OUTPUT)
    },

    # table --------------------------------------------------------------------

    #' @description
    #' Create empty formatted table.
    #' @param name Table name
    #' @param fields Template data.frame
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbCreateTable]{DBI::dbCreateTable()}}
    #' @return Invisible self
    createTable = function(name, fields, ...) {
      private$check("con", TRUE)
      private$check("res", FALSE)
      testParameter(list(...), "conn")
      DBI::dbCreateTable(private$..con, name, fields, ...)
      return(invisible(self))
    },

    #' @description
    #' Append data to table.
    #' @param name Table name
    #' @param value Values data.frame
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbAppendTable]{DBI::dbAppendTable()}}
    #' @return Number of appended rows invisibly
    appendTable = function(name, value, ...) {
      private$check("con", TRUE)
      private$check("res", FALSE)
      testParameter(list(...), "conn")
      ROWS <- DBI::dbAppendTable(private$..con, name, value, ...)
      return(invisible(ROWS))
    },

    #' @description
    #' Write data to table.
    #' @param name Table name
    #' @param value Values data.frame
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbWriteTable]{DBI::dbWriteTable()}}
    #' @return Invisible self
    writeTable = function(name, value, ...) {
      private$check("con", TRUE)
      private$check("res", FALSE)
      testParameter(list(...), "conn")
      DBI::dbWriteTable(private$..con, name, value, ...)
      return(invisible(self))
    },

    #' @description
    #' Read table.
    #' @param name Table name
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbReadTable]{DBI::dbReadTable()}}
    #' @return Table
    readTable = function(name, ...) {
      private$check("con", TRUE)
      private$check("res", FALSE)
      testParameter(list(...), "conn")
      TAB <- DBI::dbReadTable(private$..con, name, ...)
      return(TAB)
    },

    #' @description
    #' Remove table.
    #' @param name Table name
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbRemoveTable]{DBI::dbRemoveTable()}}
    #' @return Invisible self
    removeTable = function(name, ...) {
      private$check("con", TRUE)
      private$check("res", FALSE)
      testParameter(list(...), "conn")
      DBI::dbRemoveTable(private$..con, name, ...)
      return(invisible(self))
    },

    #' @description
    #' Check if table exists.
    #' @param name Table name
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbExistsTable]{DBI::dbExistsTable()}}
    #' @return TRUE or FALSE
    existsTable = function(name, ...) {
      private$check("con", TRUE)
      private$check("res", FALSE)
      testParameter(list(...), "conn")
      EXISTS <- DBI::dbExistsTable(private$..con, name, ...)
      return(EXISTS)
    },

    # list ---------------------------------------------------------------------

    #' @description
    #' List table column names.
    #' @param name Table name
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbListFields]{DBI::dbListFields()}}
    #' @return Column names
    listFields = function(name, ...) {
      private$check("con", TRUE)
      private$check("res", FALSE)
      testParameter(list(...), "conn")
      COLUMNS <- DBI::dbListFields(private$..con, name, ...)
      return(COLUMNS)
    },

    #' @description
    #' List database objects.
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbListObjects]{DBI::dbListObjects()}}
    #' @return List of objects
    listObjects = function(...) {
      private$check("con", TRUE)
      private$check("res", FALSE)
      testParameter(list(...), "conn")
      OBJECTS <- DBI::dbListObjects(private$..con, ...)
      return(OBJECTS)
    },

    #' @description
    #' List database tables.
    #' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbListTables]{DBI::dbListTables()}}
    #' @return List of objects
    listTables = function(...) {
      private$check("con", TRUE)
      private$check("res", FALSE)
      testParameter(list(...), "conn")
      TABLES <- DBI::dbListTables(private$..con, ...)
      return(TABLES)
    }

  ),

  # active ---------------------------------------------------------------------
  active = list(

    # DBI ----------------------------------------------------------------------

    #' @field .drv
    #' Read only \link[DBI:DBIDriver-class]{DBI::DBIDriver-class} object or NULL.
    #' It is recommended not to use this object!
    #' For advanced user, object can be used for direct execution of functions from DBI package.
    .drv = function(VALUE)
      return(private$readOnly(".drv", VALUE)),

    #' @field .con
    #' Read only \link[DBI:DBIConnection-class]{DBI::DBIConnection-class} object or NULL.
    #' It is recommended not to use this object!
    #' For advanced user, object can be used for direct execution of functions from DBI package.
    .con = function(VALUE)
      return(private$readOnly(".con", VALUE)),

    #' @field .res
    #' Read only \link[DBI:DBIResult-class]{DBI::DBIResult-class} object or NULL.
    #' It is recommended not to use this object!
    #' For advanced user, object can be used for direct execution of functions from DBI package.
    .res = function(VALUE)
      return(private$readOnly(".res", VALUE)),

    # other --------------------------------------------------------------------

    #' @field transaction
    #' Read only TRUE or FALSE.
    #' Information on pending transaction.
    transaction = function(VALUE)
      return(private$readOnly("transaction", VALUE)),

    #' @field info
    #' Read only driver package and connection parameter information list.
    info = function(VALUE)
      return(private$readOnly("info", VALUE)),

    #' @field verbose
    #' TRUE or FALSE. Switch text output on / off.
    verbose = function(VALUE) {
      if (missing(VALUE))
        return(private$.verbose)
      if (isTRUE(VALUE)) {
        private$.verbose <- TRUE
      } else if (isFALSE(VALUE)) {
        private$.verbose <- FALSE
      } else {
        error("verbose is boolean")
      }
    }

  ),

  # private --------------------------------------------------------------------
  private = list(

    # fields -------------------------------------------------------------------

    ..drv = NULL,
    ..con = NULL,
    ..res = NULL,

    .transaction = FALSE,
    .info = NULL,
    .verbose = TRUE,

    packages = NULL,
    functions = NULL,
    key = NULL,
    settings = NULL,
    enclosEnvBackup = NULL,

    # general ------------------------------------------------------------------

    # finalize = function() {},

    readOnly = function(FIELD, VALUE) {
      if (!missing(VALUE))
        error(paste0(FIELD, " is read only"))
      return(private[[paste0(".", FIELD)]])
    },

    # comm ---------------------------------------------------------------------

    note = function(TEXT) {
      if (private$.verbose) {
        INFO <- private$textColor(4, paste0("[", paste(private$.info, collapse = " | ") ,"]"))
        STATUS <- paste0(
          ifelse(is.null(private$..drv), private$textColor(2, "d"), private$textColor(3, "D")),
          ifelse(is.null(private$..con), private$textColor(2, "c"), private$textColor(3, "C")),
          ifelse(private$.transaction, private$textColor(3, "T"), private$textColor(2, "t")),
          ifelse(is.null(private$..res), private$textColor(2, "r"), private$textColor(3, "R"))
        )
        cat(INFO, STATUS, TEXT, "\n")
      }
    },

    textColor = function(COLOR, TEXT) {
      if (private$packages$crayon) {
        if (COLOR == 1) { # text variable
          TEXT <- crayon::blue(TEXT)
        } else if (COLOR == 2) { # negative
          TEXT <- crayon::red(TEXT)
        } else if (COLOR == 3) { # positive
          TEXT <- crayon::green(TEXT)
        } else if (COLOR == 4) { # note db info
          TEXT <- crayon::cyan(TEXT)
        }
      }
      return(TEXT)
    },

    # check --------------------------------------------------------------------

    check = function(PAR, STATUS, WARNING = FALSE) {
      TEST <- TRUE
      if (PAR == "drv") {
        if (self$isValidDrv() != STATUS) {
          error(ifelse(is.null(private$..drv), "Driver not set", "Driver set"), WARNING)
          TEST <- FALSE
        }
      } else if (PAR == "con") {
        if (self$isValidCon() != STATUS) {
          error(ifelse(is.null(private$..con), "Connection not opened", "Connection opened"), WARNING)
          TEST <- FALSE
        }
      } else if (PAR == "res") {
        if (self$isValidRes() != STATUS) {
          error(ifelse(is.null(private$..res), "No result", "Result pending"), WARNING)
          TEST <- FALSE
        }
      } else if (PAR == "tra") {
        if (private$.transaction != STATUS) {
          error(ifelse(private$.transaction, "Transaction pending", "No transaction"), WARNING)
          TEST <- FALSE
        }
      }
      return(invisible(TEST))
    },

    # settings -----------------------------------------------------------------

    settingsWrite = function(SETTINGS) {
      private$key <- generateKey()
      private$settings <- encrypt(SETTINGS, private$key)
    },

    settingsRead = function() {
      SETTINGS <- decrypt(private$settings, private$key)
      private$key <- generateKey()
      private$settings <- encrypt(SETTINGS, private$key)
      return(SETTINGS)
    },

    # protect ------------------------------------------------------------------

    enclosEnvProtect = function() {
      if (is.null(private$enclosEnvBackup) & !is.null(self$.__enclos_env__)) {
        private$enclosEnvBackup <- self$.__enclos_env__
        self$.__enclos_env__ <- NULL
      }
    },

    enclosEnvRestore = function() {
      if (!is.null(private$enclosEnvBackup) & is.null(self$.__enclos_env__)) {
        self$.__enclos_env__ <- private$enclosEnvBackup
        private$enclosEnvBackup <- NULL
      }
    }

  )

)
