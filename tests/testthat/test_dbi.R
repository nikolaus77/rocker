
test_that("DBI functions", {
  # setupDriver ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  drv <- RSQLite::SQLite()
  db6 <- rocker::rocker$new(verbose = FALSE, id = "R6")
  db6$setupDriver(RSQLite::SQLite(), dbname = ":memory:")
  db3 <- rocker::newDB(verbose = FALSE, id = "S3")
  rocker::setupDriver(db3, RSQLite::SQLite(), dbname = ":memory:")

  # isValidDrv ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbIsValid(drv)
  out6 <- db6$isValidDrv()
  out3 <- rocker::isValidDrv(db3)
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # getInfoDrv ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbGetInfo(drv)
  out6 <- db6$getInfoDrv()
  out3 <- rocker::getInfoDrv(db3)
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # canConnect ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbCanConnect(drv, dbname = ":memory:")
  out6 <- db6$canConnect()
  out3 <- rocker::canConnect(db3)
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # connect ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  con <- DBI::dbConnect(drv, dbname = ":memory:")
  db6$connect()
  rocker::connect(db3)

  # isValidCon ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbIsValid(con)
  out6 <- db6$isValidCon()
  out3 <- rocker::isValidCon(db3)
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # getInfoCon ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbGetInfo(con)
  out6 <- db6$getInfoCon()
  out3 <- rocker::getInfoCon(db3)
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # writeTable ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  DBI::dbWriteTable(con, "mtcars", mtcars)
  db6$writeTable("mtcars", mtcars)
  rocker::writeTable(db3, "mtcars", mtcars)

  # get query ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbGetQuery(con, "SELECT * FROM mtcars;")
  out6 <- db6$getQuery("SELECT * FROM mtcars;")
  out3 <- rocker::getQuery(db3, "SELECT * FROM mtcars;")
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # createTable ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  DBI::dbCreateTable(con, "mtcars2", mtcars)
  db6$createTable("mtcars2", mtcars)
  rocker::createTable(db3, "mtcars2", mtcars)

  # get query ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbGetQuery(con, "SELECT * FROM mtcars2;")
  out6 <- db6$getQuery("SELECT * FROM mtcars2;")
  out3 <- rocker::getQuery(db3, "SELECT * FROM mtcars2;")
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # appendTable ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbAppendTable(con, "mtcars2", mtcars)
  out6 <- db6$appendTable("mtcars2", mtcars)
  out3 <- rocker::appendTable(db3, "mtcars2", mtcars)
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # get query ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbGetQuery(con, "SELECT * FROM mtcars2;")
  out6 <- db6$getQuery("SELECT * FROM mtcars2;")
  out3 <- rocker::getQuery(db3, "SELECT * FROM mtcars2;")
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # listObjects ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbListObjects(con)
  out6 <- db6$listObjects()
  out3 <- rocker::listObjects(db3)
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # listTables ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbListTables(con)
  out6 <- db6$listTables()
  out3 <- rocker::listTables(db3)
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # existsTable ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbExistsTable(con, "mtcars2")
  out6 <- db6$existsTable("mtcars2")
  out3 <- rocker::existsTable(db3, "mtcars2")
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # removeTable ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbRemoveTable(con, "mtcars2")
  rm(out)
  db6$removeTable("mtcars2")
  rocker::removeTable(db3, "mtcars2")

  # existsTable ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbExistsTable(con, "mtcars2")
  out6 <- db6$existsTable("mtcars2")
  out3 <- rocker::existsTable(db3, "mtcars2")
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # listObjects ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbListObjects(con)
  out6 <- db6$listObjects()
  out3 <- rocker::listObjects(db3)
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # listTables ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbListTables(con)
  out6 <- db6$listTables()
  out3 <- rocker::listTables(db3)
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # listFields ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbListFields(con, "mtcars")
  out6 <- db6$listFields("mtcars")
  out3 <- rocker::listFields(db3, "mtcars")
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # send query ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  res <- DBI::dbSendQuery(con, "SELECT * FROM mtcars;")
  db6$sendQuery("SELECT * FROM mtcars;")
  rocker::sendQuery(db3, "SELECT * FROM mtcars;")

  # isValidRes ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbIsValid(res)
  out6 <- db6$isValidRes()
  out3 <- rocker::isValidRes(db3)
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # getInfoRes ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbGetInfo(res)
  out6 <- db6$getInfoRes()
  out3 <- rocker::getInfoRes(db3)
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # fetch ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::fetch(res, 2)
  out6 <- db6$fetch(2)
  out3 <- rocker::fetch(db3, 2)
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # hasCompleted ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbHasCompleted(res)
  out6 <- db6$hasCompleted()
  out3 <- rocker::hasCompleted(db3)
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # getRowCount ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbGetRowCount(res)
  out6 <- db6$getRowCount()
  out3 <- rocker::getRowCount(db3)
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # fetch ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::fetch(res)
  out6 <- db6$fetch()
  out3 <- rocker::fetch(db3)
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # hasCompleted ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbHasCompleted(res)
  out6 <- db6$hasCompleted()
  out3 <- rocker::hasCompleted(db3)
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # getRowCount ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbGetRowCount(res)
  out6 <- db6$getRowCount()
  out3 <- rocker::getRowCount(db3)
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # clearResult ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  DBI::dbClearResult(res)
  db6$clearResult()
  rocker::clearResult(db3)

  # isValidRes ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbIsValid(res)
  out6 <- db6$isValidRes()
  out3 <- rocker::isValidRes(db3)
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # sendStatement ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  res <- DBI::dbSendStatement(con, "DELETE FROM mtcars WHERE gear = 3;")
  db6$sendStatement("DELETE FROM mtcars WHERE gear = 3;")
  rocker::sendStatement(db3, "DELETE FROM mtcars WHERE gear = 3;")

  # isValidRes ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbIsValid(res)
  out6 <- db6$isValidRes()
  out3 <- rocker::isValidRes(db3)
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # getRowsAffected ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbGetRowsAffected(res)
  out6 <- db6$getRowsAffected()
  out3 <- rocker::getRowsAffected(db3)
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # fetch ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  expect_warning(out <- DBI::fetch(res))
  expect_warning(out6 <- db6$fetch())
  expect_warning(out3 <- rocker::fetch(db3))
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # clearResult ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  DBI::dbClearResult(res)
  db6$clearResult()
  rocker::clearResult(db3)

  # isValidRes ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbIsValid(res)
  out6 <- db6$isValidRes()
  out3 <- rocker::isValidRes(db3)
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # get query ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbGetQuery(con, "SELECT * FROM mtcars;")
  out6 <- db6$getQuery("SELECT * FROM mtcars;")
  out3 <- rocker::getQuery(db3, "SELECT * FROM mtcars;")
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # execute ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbExecute(con, "DELETE FROM mtcars WHERE gear = 4;")
  out6 <- db6$execute("DELETE FROM mtcars WHERE gear = 4;")
  out3 <- rocker::execute(db3, "DELETE FROM mtcars WHERE gear = 4;")
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # get query ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbGetQuery(con, "SELECT * FROM mtcars;")
  out6 <- db6$getQuery("SELECT * FROM mtcars;")
  out3 <- rocker::getQuery(db3, "SELECT * FROM mtcars;")
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # disconnect ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  DBI::dbDisconnect(con)
  db6$disconnect()
  rocker::disconnect(db3)

  # isValidCon ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out <- DBI::dbIsValid(con)
  out6 <- db6$isValidCon()
  out3 <- rocker::isValidCon(db3)
  expect_identical(out, out6)
  expect_identical(out, out3)
  rm(out, out6, out3)

  # unloadDriver ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  drv <- DBI::dbUnloadDriver(drv)
  db6$unloadDriver()
  rocker::unloadDriver(db3)

  # isValidDrv ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  out6 <- db6$isValidDrv()
  out3 <- rocker::isValidDrv(db3)
  expect_identical(out6, out3)
  rm(out6, out3)

  rm(con, drv, db6, db3)
})
