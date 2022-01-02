
# setupDriver ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Setup database driver and define connection parameters.
#' @param db rocker object
#' @param drv Driver object from suitable package e.g. \code{\link[RPostgres:Postgres]{RPostgres::Postgres()}}, \code{\link[RMariaDB:MariaDBDriver-class]{RMariaDB::MariaDB()}} and \code{\link[RSQLite:SQLite]{RSQLite::SQLite()}}
#' @param ... Suitable parameters passed to \code{\link[DBI:dbConnect]{DBI::dbConnect()}} e.g. host, port, dbname, user and password
#' @param protect Parameters to be hidden
#' @return Invisible self
#' @examples
#' db <- rocker::newDB()
#' rocker::setupDriver(
#'   db,
#'   drv = RSQLite::SQLite(),
#'   dbname = ":memory:"
#' )
#' rocker::unloadDriver(db)
#' @export
setupDriver <- function(db, drv, ..., protect = c("password", "user")) {
  UseMethod("setupDriver", db)
}

#' @export
setupDriver.rocker <- function(db, drv, ..., protect = c("password", "user")) {
  db$setupDriver(drv, ..., protect)
}

# setupPostgreSQL ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Setup database driver and define connection parameters for PostgreSQL using \link[RPostgres:Postgres]{RPostgres} package.
#' Wrapper for setupDriver() function.
#' @param db rocker object
#' @param host Host name or IP number
#' @param port Port number
#' @param dbname Database name
#' @param user User name
#' @param password Password
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbConnect]{DBI::dbConnect()}}
#' @param protect Parameters to be hidden
#' @return Invisible self
#' @examples
#' db <- rocker::newDB()
#' rocker::setupPostgreSQL(
#'   db,
#'   host = "127.0.0.1", port = "5432", dbname = "mydb",
#'   user = "postgres", password = "password"
#' )
#' rocker::unloadDriver(db)
#' @export
setupPostgreSQL <- function(db, host = "127.0.0.1", port = "5432", dbname = "mydb", user = "postgres", password = "password", ..., protect = c("password", "user")) {
  UseMethod("setupPostgreSQL", db)
}

#' @export
setupPostgreSQL.rocker <- function(db, host = "127.0.0.1", port = "5432", dbname = "mydb", user = "postgres", password = "password", ..., protect = c("password", "user")) {
  db$setupPostgreSQL(host, port, dbname, user, password, ..., protect)
}

# setupMariaDB ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Setup database driver and define connection parameters for MariaDB using \link[RMariaDB:RMariaDB-package]{RMariaDB} package.
#' Wrapper for setupDriver() function.
#' @param db rocker object
#' @param host Host name or IP number
#' @param port Port number
#' @param dbname Database name
#' @param user User name
#' @param password Password
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbConnect]{DBI::dbConnect()}}
#' @param protect Parameters to be hidden
#' @return Invisible self
#' @examples
#' db <- rocker::newDB()
#' rocker::setupMariaDB(
#'   db,
#'   host = "127.0.0.1", port = "3306", dbname = "mydb",
#'   user = "root", password = "password"
#' )
#' rocker::unloadDriver(db)
#' @export
setupMariaDB <- function(db, host = "127.0.0.1", port = "3306", dbname = "mydb", user = "root", password = "password", ..., protect = c("password", "user")) {
  UseMethod("setupMariaDB", db)
}

#' @export
setupMariaDB.rocker <- function(db, host = "127.0.0.1", port = "3306", dbname = "mydb", user = "root", password = "password", ..., protect = c("password", "user")) {
  db$setupMariaDB(host, port, dbname, user, password, ..., protect)
}

# setupSQLite ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Setup database driver and define connection parameters for SQLite using \link[RSQLite:SQLite]{RSQLite} package.
#' Wrapper for setupDriver() function.
#' @param db rocker object
#' @param dbname Database name
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbConnect]{DBI::dbConnect()}}
#' @param protect Parameters to be hidden
#' @return Invisible self
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(
#'   db,
#'   dbname = ":memory:"
#' )
#' rocker::unloadDriver(db)
#' @export
setupSQLite <- function(db, dbname = ":memory:", ..., protect = c("password", "user")) {
  UseMethod("setupSQLite", db)
}

#' @export
setupSQLite.rocker <- function(db, dbname = ":memory:", ..., protect = c("password", "user")) {
  db$setupSQLite(dbname, ..., protect)
}

# unloadDriver ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Reset database driver and connection parameters.
#' @param db rocker object
#' @param ... Optional, suitable parameters passed to \code{\link[DBI:dbDriver]{DBI::dbUnloadDriver()}}
#' @return Invisible self
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::unloadDriver(db)
#' @export
unloadDriver <- function(db, ...) {
  UseMethod("unloadDriver", db)
}

#' @export
unloadDriver.rocker <- function(db, ...) {
  db$unloadDriver(...)
}

# canConnect ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Test connection parameters.
#' @param db rocker object
#' @param ... Optional, suitable parameters passed to \code{\link[DBI:dbCanConnect]{DBI::dbCanConnect()}}
#' @return TRUE or FALSE
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::canConnect(db)
#' rocker::unloadDriver(db)
#' @export
canConnect <- function(db, ...) {
  UseMethod("canConnect", db)
}

#' @export
canConnect.rocker <- function(db, ...) {
  db$canConnect(...)
}

# connect ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Establish database connection using stored parameters.
#' @param db rocker object
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbConnect]{DBI::dbConnect()}}
#' @return Invisible self
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
connect <- function(db, ...) {
  UseMethod("connect", db)
}

#' @export
connect.rocker <- function(db, ...) {
  db$connect(...)
}

# disconnect ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Disconnect database.
#' @param db rocker object
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbDisconnect]{DBI::dbDisconnect()}}
#' @return Invisible self
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
disconnect <- function(db, ...) {
  UseMethod("disconnect", db)
}

#' @export
disconnect.rocker <- function(db, ...) {
  db$disconnect(...)
}

# sendQuery ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Send SQL query to database.
#' @param db rocker object
#' @param statement SQL query (\code{SELECT})
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbSendQuery]{DBI::dbSendQuery()}}
#' @return Invisible self
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::writeTable(db, "mtcars", mtcars)
#' rocker::sendQuery(db, "SELECT * FROM mtcars;")
#' output <- rocker::fetch(db)
#' rocker::clearResult(db)
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
sendQuery <- function(db, statement, ...) {
  UseMethod("sendQuery", db)
}

#' @export
sendQuery.rocker <- function(db, statement, ...) {
  db$sendQuery(statement, ...)
}

# getQuery ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Retrieve SQL query from database.
#' Combination of functions sendQuery(), fetch() and clearResult().
#' If required, database is automatically connected and disconnected.
#' @param db rocker object
#' @param statement SQL query (\code{SELECT})
#' @param n Number of record to be fetched at once. All records will be fetched.
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbSendQuery]{DBI::dbSendQuery()}}
#' @return Records
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::writeTable(db, "mtcars", mtcars)
#' output <- rocker::getQuery(db, "SELECT * FROM mtcars;")
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
getQuery <- function(db, statement, n = -1, ...) {
  UseMethod("getQuery", db)
}

#' @export
getQuery.rocker <- function(db, statement, n = -1, ...) {
  db$getQuery(statement, n, ...)
}

# sendStatement ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Send SQL statement to database.
#' @param db rocker object
#' @param statement SQL statement (\code{UPDATE, DELETE, INSERT INTO, ...})
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbSendStatement]{DBI::dbSendStatement()}}
#' @return Invisible self
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::writeTable(db, "mtcars", mtcars)
#' rocker::sendStatement(db, "DELETE FROM mtcars WHERE gear = 3;")
#' rocker::clearResult(db)
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
sendStatement <- function(db, statement, ...) {
  UseMethod("sendStatement", db)
}

#' @export
sendStatement.rocker <- function(db, statement, ...) {
  db$sendStatement(statement, ...)
}

# execute ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Execute SQL statement in database.
#' Combination of functions execute and clearResult.
#' If required, database is automatically connected and disconnected.
#' @param db rocker object
#' @param statement SQL statement (\code{UPDATE, DELETE, INSERT INTO, ...})
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbSendStatement]{DBI::dbSendStatement()}}
#' @return Number of affected rows
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::writeTable(db, "mtcars", mtcars)
#' rocker::execute(db, "DELETE FROM mtcars WHERE gear = 3;")
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
execute <- function(db, statement, ...) {
  UseMethod("execute", db)
}

#' @export
execute.rocker <- function(db, statement, ...) {
  db$execute(statement, ...)
}

# fetch ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Fetch SQL query result from database.
#' @param db rocker object
#' @param n Number of record to be fetched
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbFetch]{DBI::dbFetch()}}
#' @return Records
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::writeTable(db, "mtcars", mtcars)
#' rocker::sendQuery(db, "SELECT * FROM mtcars;")
#' output <- rocker::fetch(db)
#' rocker::clearResult(db)
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
fetch <- function(db, n = -1, ...) {
  UseMethod("fetch", db)
}

#' @export
fetch.rocker <- function(db, n = -1, ...) {
  db$fetch(n, ...)
}

# hasCompleted ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Information whether all records were retrieved.
#' @param db rocker object
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbHasCompleted]{DBI::dbHasCompleted()}}
#' @return TRUE or FALSE
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::writeTable(db, "mtcars", mtcars)
#' rocker::sendQuery(db, "SELECT * FROM mtcars;")
#' output <- rocker::fetch(db, 5)
#' rocker::hasCompleted(db)
#' rocker::clearResult(db)
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
hasCompleted <- function(db, ...) {
  UseMethod("hasCompleted", db)
}

#' @export
hasCompleted.rocker <- function(db, ...) {
  db$hasCompleted(...)
}

# getRowsAffected ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Information on number of affected rows.
#' @param db rocker object
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbGetRowsAffected]{DBI::dbGetRowsAffected()}}
#' @return Number of affected rows
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::writeTable(db, "mtcars", mtcars)
#' rocker::sendStatement(db, "DELETE FROM mtcars WHERE gear = 3;")
#' rocker::getRowsAffected(db)
#' rocker::clearResult(db)
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
getRowsAffected <- function(db, ...) {
  UseMethod("getRowsAffected", db)
}

#' @export
getRowsAffected.rocker <- function(db, ...) {
  db$getRowsAffected(...)
}

# getRowCount ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Information on number of retrieved rows.
#' @param db rocker object
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbGetRowCount]{DBI::dbGetRowCount()}}
#' @return Number of retrieved rows
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::writeTable(db, "mtcars", mtcars)
#' rocker::sendQuery(db, "SELECT * FROM mtcars;")
#' output <- rocker::fetch(db)
#' rocker::getRowCount(db)
#' rocker::clearResult(db)
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
getRowCount <- function(db, ...) {
  UseMethod("getRowCount", db)
}

#' @export
getRowCount.rocker <- function(db, ...) {
  db$getRowCount(...)
}

# columnInfo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Information on query result columns.
#' @param db rocker object
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbColumnInfo]{DBI::dbColumnInfo()}}
#' @return Information table
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::writeTable(db, "mtcars", mtcars)
#' rocker::sendQuery(db, "SELECT * FROM mtcars;")
#' rocker::columnInfo(db)
#' rocker::clearResult(db)
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
columnInfo <- function(db, ...) {
  UseMethod("columnInfo", db)
}

#' @export
columnInfo.rocker <- function(db, ...) {
  db$columnInfo(...)
}

# getStatement ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Information on sent statement.
#' @param db rocker object
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbGetStatement]{DBI::dbGetStatement()}}
#' @return Statement text
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::writeTable(db, "mtcars", mtcars)
#' rocker::sendQuery(db, "SELECT * FROM mtcars;")
#' rocker::getStatement(db)
#' rocker::clearResult(db)
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
getStatement <- function(db, ...) {
  UseMethod("getStatement", db)
}

#' @export
getStatement.rocker <- function(db, ...) {
  db$getStatement(...)
}

# clearResult ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Clear query or statement result.
#' @param db rocker object
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbClearResult]{DBI::dbClearResult()}}
#' @return Invisible self
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::writeTable(db, "mtcars", mtcars)
#' rocker::sendQuery(db, "SELECT * FROM mtcars;")
#' output <- rocker::fetch(db)
#' rocker::clearResult(db)
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
clearResult <- function(db, ...) {
  UseMethod("clearResult", db)
}

#' @export
clearResult.rocker <- function(db, ...) {
  db$clearResult(...)
}

# begin ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Begin transaction.
#' @param db rocker object
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:transactions]{DBI::dbBegin()}}
#' @return Invisible self
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::writeTable(db, "mtcars", mtcars)
#' rocker::begin(db)
#' rocker::sendStatement(db, "DELETE FROM mtcars WHERE gear = 3;")
#' rocker::clearResult(db)
#' rocker::commit(db)
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
begin <- function(db, ...) {
  UseMethod("begin", db)
}

#' @export
begin.rocker <- function(db, ...) {
  db$begin(...)
}

# commit ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Commit transaction.
#' @param db rocker object
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:transactions]{DBI::dbCommit()}}
#' @return Invisible self
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::writeTable(db, "mtcars", mtcars)
#' rocker::begin(db)
#' rocker::sendStatement(db, "DELETE FROM mtcars WHERE gear = 3;")
#' rocker::clearResult(db)
#' rocker::commit(db)
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
commit <- function(db, ...) {
  UseMethod("commit", db)
}

#' @export
commit.rocker <- function(db, ...) {
  db$commit(...)
}

# rollback ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Rollback transaction.
#' @param db rocker object
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:transactions]{DBI::dbRollback()}}
#' @return Invisible self
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::writeTable(db, "mtcars", mtcars)
#' rocker::begin(db)
#' rocker::sendStatement(db, "DELETE FROM mtcars WHERE gear = 3;")
#' rocker::clearResult(db)
#' rocker::rollback(db)
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
rollback <- function(db, ...) {
  UseMethod("rollback", db)
}

#' @export
rollback.rocker <- function(db, ...) {
  db$rollback(...)
}

# getInfoDrv ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Information on driver object.
#' @param db rocker object
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbGetInfo]{DBI::dbGetInfo()}}
#' @return Information list
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::getInfoDrv(db)
#' rocker::unloadDriver(db)
#' @export
getInfoDrv <- function(db, ...) {
  UseMethod("getInfoDrv", db)
}

#' @export
getInfoDrv.rocker <- function(db, ...) {
  db$getInfoDrv(...)
}

# getInfoCon ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Information on connection object.
#' @param db rocker object
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbGetInfo]{DBI::dbGetInfo()}}
#' @return Information list
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::getInfoCon(db)
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
getInfoCon <- function(db, ...) {
  UseMethod("getInfoCon", db)
}

#' @export
getInfoCon.rocker <- function(db, ...) {
  db$getInfoCon(...)
}

# getInfoRes ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Information on result object.
#' @param db rocker object
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbGetInfo]{DBI::dbGetInfo()}}
#' @return Information list
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::writeTable(db, "mtcars", mtcars)
#' rocker::sendQuery(db, "SELECT * FROM mtcars;")
#' rocker::getInfoRes(db)
#' rocker::clearResult(db)
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
getInfoRes <- function(db, ...) {
  UseMethod("getInfoRes", db)
}

#' @export
getInfoRes.rocker <- function(db, ...) {
  db$getInfoRes(...)
}

# isValidDrv ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Check driver object.
#' @param db rocker object
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbIsValid]{DBI::dbIsValid()}}
#' @return TRUE of FALSE
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::isValidDrv(db)
#' rocker::unloadDriver(db)
#' @export
isValidDrv <- function(db, ...) {
  UseMethod("isValidDrv", db)
}

#' @export
isValidDrv.rocker <- function(db, ...) {
  db$isValidDrv(...)
}

# isValidCon ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Check connection object.
#' @param db rocker object
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbIsValid]{DBI::dbIsValid()}}
#' @return TRUE of FALSE
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::isValidCon(db)
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
isValidCon <- function(db, ...) {
  UseMethod("isValidCon", db)
}

#' @export
isValidCon.rocker <- function(db, ...) {
  db$isValidCon(...)
}

# validateCon ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Check if an earlier opened connection is still open.
#' @param db rocker object
#' @param statement Optional SQL statement. If not set default validateQuery will be used.
#' @param ... Not used yet
#' @return TRUE of FALSE
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::validateCon(db)
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
validateCon <- function(db, statement = NULL, ...) {
  UseMethod("validateCon", db)
}

#' @export
validateCon.rocker <- function(db, statement = NULL, ...) {
  db$validateCon(statement, ...)
}

# isValidRes ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Check result object.
#' @param db rocker object
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbIsValid]{DBI::dbIsValid()}}
#' @return TRUE of FALSE
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::writeTable(db, "mtcars", mtcars)
#' rocker::sendQuery(db, "SELECT * FROM mtcars;")
#' rocker::isValidRes(db)
#' rocker::clearResult(db)
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
isValidRes <- function(db, ...) {
  UseMethod("isValidRes", db)
}

#' @export
isValidRes.rocker <- function(db, ...) {
  db$isValidRes(...)
}

# createTable ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Create empty formatted table.
#' @param db rocker object
#' @param name Table name
#' @param fields Template data.frame
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbCreateTable]{DBI::dbCreateTable()}}
#' @return Invisible self
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::createTable(db, "mtcars", mtcars)
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
createTable <- function(db, name, fields, ...) {
  UseMethod("createTable", db)
}

#' @export
createTable.rocker <- function(db, name, fields, ...) {
  db$createTable(name, fields, ...)
}

# appendTable ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Append data to table.
#' @param db rocker object
#' @param name Table name
#' @param value Values data.frame
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbAppendTable]{DBI::dbAppendTable()}}
#' @return Number of appended rows invisibly
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::createTable(db, "mtcars", mtcars)
#' rocker::appendTable(db, "mtcars", mtcars)
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
appendTable <- function(db, name, value, ...) {
  UseMethod("appendTable", db)
}

#' @export
appendTable.rocker <- function(db, name, value, ...) {
  db$appendTable(name, value, ...)
}

# writeTable ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Write data to table.
#' @param db rocker object
#' @param name Table name
#' @param value Values data.frame
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbWriteTable]{DBI::dbWriteTable()}}
#' @return Invisible self
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::writeTable(db, "mtcars", mtcars)
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
writeTable <- function(db, name, value, ...) {
  UseMethod("writeTable", db)
}

#' @export
writeTable.rocker <- function(db, name, value, ...) {
  db$writeTable(name, value, ...)
}

# readTable ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Read table.
#' @param db rocker object
#' @param name Table name
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbReadTable]{DBI::dbReadTable()}}
#' @return Table
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::writeTable(db, "mtcars", mtcars)
#' output <- rocker::readTable(db, "mtcars")
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
readTable <- function(db, name, ...) {
  UseMethod("readTable", db)
}

#' @export
readTable.rocker <- function(db, name, ...) {
  db$readTable(name, ...)
}

# removeTable ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Remove table.
#' @param db rocker object
#' @param name Table name
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbRemoveTable]{DBI::dbRemoveTable()}}
#' @return Invisible self
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::writeTable(db, "mtcars", mtcars)
#' rocker::removeTable(db, "mtcars")
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
removeTable <- function(db, name, ...) {
  UseMethod("removeTable", db)
}

#' @export
removeTable.rocker <- function(db, name, ...) {
  db$removeTable(name, ...)
}

# existsTable ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' Check if table exists.
#' @param db rocker object
#' @param name Table name
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbExistsTable]{DBI::dbExistsTable()}}
#' @return TRUE or FALSE
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::writeTable(db, "mtcars", mtcars)
#' rocker::existsTable(db, "mtcars")
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
existsTable <- function(db, name, ...) {
  UseMethod("existsTable", db)
}

#' @export
existsTable.rocker <- function(db, name, ...) {
  db$existsTable(name, ...)
}

# listFields ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' List table column names.
#' @param db rocker object
#' @param name Table name
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbListFields]{DBI::dbListFields()}}
#' @return Column names
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::writeTable(db, "mtcars", mtcars)
#' rocker::listFields(db, "mtcars")
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
listFields <- function(db, name, ...) {
  UseMethod("listFields", db)
}

#' @export
listFields.rocker <- function(db, name, ...) {
  db$listFields(name, ...)
}

# listObjects ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' List database objects.
#' @param db rocker object
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbListObjects]{DBI::dbListObjects()}}
#' @return List of objects
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::writeTable(db, "mtcars", mtcars)
#' rocker::listObjects(db)
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
listObjects <- function(db, ...) {
  UseMethod("listObjects", db)
}

#' @export
listObjects.rocker <- function(db, ...) {
  db$listObjects(...)
}

# listTables ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' List database tables.
#' @param db rocker object
#' @param ... Optional, additional suitable parameters passed to \code{\link[DBI:dbListTables]{DBI::dbListTables()}}
#' @return List of objects
#' @examples
#' db <- rocker::newDB()
#' rocker::setupSQLite(db)
#' rocker::connect(db)
#' rocker::writeTable(db, "mtcars", mtcars)
#' rocker::listTables(db)
#' rocker::disconnect(db)
#' rocker::unloadDriver(db)
#' @export
listTables <- function(db, ...) {
  UseMethod("listTables", db)
}

#' @export
listTables.rocker <- function(db, ...) {
  db$listTables(...)
}
