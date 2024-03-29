
test_that("S3 object status error", {
  db <- rocker::newDB(verbose = FALSE)
  # drv -, con -, tra -, res -
  expect_true(is.null(db$info))
  expect_true(is.null(db$.drv))
  expect_true(is.null(db$.con))
  expect_true(isFALSE(db$transaction))
  expect_true(is.null(db$.res))
  # expect_error(rocker::setupDriver(db, RSQLite::SQLite(), dbname = ":memory:"))
  expect_error(rocker::connect(db))
  expect_error(rocker::writeTable(db, "mtcars", mtcars))
  expect_error(rocker::begin(db))
  expect_error(rocker::sendQuery(db, "SELECT * FROM mtcars;"))
  expect_error(rocker::sendStatement(db, "DELETE FROM mtcars WHERE gear = 3;"))
  expect_error(rocker::fetch(db))
  expect_error(rocker::clearResult(db))
  expect_error(rocker::commit(db))
  expect_error(rocker::rollback(db))
  expect_error(rocker::disconnect(db))
  expect_error(rocker::unloadDriver(db))

  rocker::setupDriver(db, RSQLite::SQLite(), dbname = ":memory:")
  # drv +, con -, tra -, res -
  expect_true(!is.null(db$info))
  expect_true(!is.null(db$.drv))
  expect_true(is.null(db$.con))
  expect_true(isFALSE(db$transaction))
  expect_true(is.null(db$.res))
  expect_error(rocker::setupDriver(db, RSQLite::SQLite(), dbname = ":memory:"))
  # expect_error(rocker::connect(db))
  expect_error(rocker::writeTable(db, "mtcars", mtcars))
  expect_error(rocker::begin(db))
  expect_error(rocker::sendQuery(db, "SELECT * FROM mtcars;"))
  expect_error(rocker::sendStatement(db, "DELETE FROM mtcars WHERE gear = 3;"))
  expect_error(rocker::fetch(db))
  expect_error(rocker::clearResult(db))
  expect_error(rocker::commit(db))
  expect_error(rocker::rollback(db))
  expect_error(rocker::disconnect(db))
  # expect_error(rocker::unloadDriver(db))

  rocker::connect(db)
  # drv +, con +, tra -, res -
  expect_true(!is.null(db$info))
  expect_true(!is.null(db$.drv))
  expect_true(!is.null(db$.con))
  expect_true(isFALSE(db$transaction))
  expect_true(is.null(db$.res))
  expect_error(rocker::setupDriver(db, RSQLite::SQLite(), dbname = ":memory:"))
  expect_error(rocker::connect(db))
  # expect_error(rocker::writeTable(db, "mtcars", mtcars))
  # expect_error(rocker::begin(db))
  expect_error(rocker::sendQuery(db, "SELECT * FROM mtcars;"))
  expect_error(rocker::sendStatement(db, "DELETE FROM mtcars WHERE gear = 3;"))
  expect_error(rocker::fetch(db))
  expect_error(rocker::clearResult(db))
  expect_error(rocker::commit(db))
  expect_error(rocker::rollback(db))
  # expect_error(rocker::disconnect(db))
  expect_error(rocker::unloadDriver(db))

  rocker::writeTable(db, "mtcars", mtcars)
  # drv +, con +, tra -, res -
  expect_true(!is.null(db$info))
  expect_true(!is.null(db$.drv))
  expect_true(!is.null(db$.con))
  expect_true(isFALSE(db$transaction))
  expect_true(is.null(db$.res))
  expect_error(rocker::setupDriver(db, RSQLite::SQLite(), dbname = ":memory:"))
  expect_error(rocker::connect(db))
  expect_error(rocker::writeTable(db, "mtcars", mtcars))
  # expect_error(rocker::begin(db))
  # expect_error(rocker::sendQuery(db, "SELECT * FROM mtcars;"))
  # expect_error(rocker::sendStatement(db, "DELETE FROM mtcars WHERE gear = 3;"))
  expect_error(rocker::fetch(db))
  expect_error(rocker::clearResult(db))
  expect_error(rocker::commit(db))
  expect_error(rocker::rollback(db))
  # expect_error(rocker::disconnect(db))
  expect_error(rocker::unloadDriver(db))

  rocker::sendQuery(db, "SELECT * FROM mtcars;")
  # drv +, con +, tra -, res +
  expect_true(!is.null(db$info))
  expect_true(!is.null(db$.drv))
  expect_true(!is.null(db$.con))
  expect_true(isFALSE(db$transaction))
  expect_true(!is.null(db$.res))
  expect_error(rocker::setupDriver(db, RSQLite::SQLite(), dbname = ":memory:"))
  expect_error(rocker::connect(db))
  expect_error(rocker::writeTable(db, "mtcars", mtcars))
  expect_error(rocker::begin(db))
  expect_error(rocker::sendQuery(db, "SELECT * FROM mtcars;"))
  expect_error(rocker::sendStatement(db, "DELETE FROM mtcars WHERE gear = 3;"))
  # expect_error(rocker::fetch(db))
  # expect_error(rocker::clearResult(db))
  expect_error(rocker::commit(db))
  expect_error(rocker::rollback(db))
  expect_error(rocker::disconnect(db))
  expect_error(rocker::unloadDriver(db))

  out <- rocker::fetch(db)
  rm(out)
  # drv +, con +, tra -, res +
  expect_true(!is.null(db$info))
  expect_true(!is.null(db$.drv))
  expect_true(!is.null(db$.con))
  expect_true(isFALSE(db$transaction))
  expect_true(!is.null(db$.res))
  expect_error(rocker::setupDriver(db, RSQLite::SQLite(), dbname = ":memory:"))
  expect_error(rocker::connect(db))
  expect_error(rocker::writeTable(db, "mtcars", mtcars))
  expect_error(rocker::begin(db))
  expect_error(rocker::sendQuery(db, "SELECT * FROM mtcars;"))
  expect_error(rocker::sendStatement(db, "DELETE FROM mtcars WHERE gear = 3;"))
  # expect_error(rocker::fetch(db))
  # expect_error(rocker::clearResult(db))
  expect_error(rocker::commit(db))
  expect_error(rocker::rollback(db))
  expect_error(rocker::disconnect(db))
  expect_error(rocker::unloadDriver(db))

  rocker::clearResult(db)
  # drv +, con +, tra -, res -
  expect_true(!is.null(db$info))
  expect_true(!is.null(db$.drv))
  expect_true(!is.null(db$.con))
  expect_true(isFALSE(db$transaction))
  expect_true(is.null(db$.res))
  expect_error(rocker::setupDriver(db, RSQLite::SQLite(), dbname = ":memory:"))
  expect_error(rocker::connect(db))
  # expect_error(rocker::writeTable(db, "mtcars", mtcars))
  # expect_error(rocker::begin(db))
  # expect_error(rocker::sendQuery(db, "SELECT * FROM mtcars;"))
  # expect_error(rocker::sendStatement(db, "DELETE FROM mtcars WHERE gear = 3;"))
  expect_error(rocker::fetch(db))
  expect_error(rocker::clearResult(db))
  expect_error(rocker::commit(db))
  expect_error(rocker::rollback(db))
  # expect_error(rocker::disconnect(db))
  expect_error(rocker::unloadDriver(db))

  rocker::begin(db)
  # drv +, con +, tra +, res -
  expect_true(!is.null(db$info))
  expect_true(!is.null(db$.drv))
  expect_true(!is.null(db$.con))
  expect_true(!isFALSE(db$transaction))
  expect_true(is.null(db$.res))
  expect_error(rocker::setupDriver(db, RSQLite::SQLite(), dbname = ":memory:"))
  expect_error(rocker::connect(db))
  # expect_error(rocker::writeTable(db, "mtcars", mtcars))
  expect_error(rocker::begin(db))
  # expect_error(rocker::sendQuery(db, "SELECT * FROM mtcars;"))
  # expect_error(rocker::sendStatement(db, "DELETE FROM mtcars WHERE gear = 3;"))
  expect_error(rocker::fetch(db))
  expect_error(rocker::clearResult(db))
  # expect_error(rocker::commit(db))
  # expect_error(rocker::rollback(db))
  expect_error(rocker::disconnect(db))
  expect_error(rocker::unloadDriver(db))

  rocker::sendStatement(db, "DELETE FROM mtcars WHERE gear = 3;")
  # drv +, con +, tra +, res +
  expect_true(!is.null(db$info))
  expect_true(!is.null(db$.drv))
  expect_true(!is.null(db$.con))
  expect_true(!isFALSE(db$transaction))
  expect_true(!is.null(db$.res))
  expect_error(rocker::setupDriver(db, RSQLite::SQLite(), dbname = ":memory:"))
  expect_error(rocker::connect(db))
  expect_error(rocker::writeTable(db, "mtcars", mtcars))
  expect_error(rocker::begin(db))
  expect_error(rocker::sendQuery(db, "SELECT * FROM mtcars;"))
  expect_error(rocker::sendStatement(db, "DELETE FROM mtcars WHERE gear = 3;"))
  # expect_error(rocker::fetch(db))
  # expect_error(rocker::clearResult(db))
  expect_error(rocker::commit(db))
  expect_error(rocker::rollback(db))
  expect_error(rocker::disconnect(db))
  expect_error(rocker::unloadDriver(db))

  rocker::clearResult(db)
  # drv +, con +, tra +, res -
  expect_true(!is.null(db$info))
  expect_true(!is.null(db$.drv))
  expect_true(!is.null(db$.con))
  expect_true(!isFALSE(db$transaction))
  expect_true(is.null(db$.res))
  expect_error(rocker::setupDriver(db, RSQLite::SQLite(), dbname = ":memory:"))
  expect_error(rocker::connect(db))
  # expect_error(rocker::writeTable(db, "mtcars", mtcars))
  expect_error(rocker::begin(db))
  # expect_error(rocker::sendQuery(db, "SELECT * FROM mtcars;"))
  # expect_error(rocker::sendStatement(db, "DELETE FROM mtcars WHERE gear = 3;"))
  expect_error(rocker::fetch(db))
  expect_error(rocker::clearResult(db))
  # expect_error(rocker::commit(db))
  # expect_error(rocker::rollback(db))
  expect_error(rocker::disconnect(db))
  expect_error(rocker::unloadDriver(db))

  rocker::rollback(db)
  # drv +, con +, tra -, res -
  expect_true(!is.null(db$info))
  expect_true(!is.null(db$.drv))
  expect_true(!is.null(db$.con))
  expect_true(isFALSE(db$transaction))
  expect_true(is.null(db$.res))
  expect_error(rocker::setupDriver(db, RSQLite::SQLite(), dbname = ":memory:"))
  expect_error(rocker::connect(db))
  # expect_error(rocker::writeTable(db, "mtcars", mtcars))
  # expect_error(rocker::begin(db))
  # expect_error(rocker::sendQuery(db, "SELECT * FROM mtcars;"))
  # expect_error(rocker::sendStatement(db, "DELETE FROM mtcars WHERE gear = 3;"))
  expect_error(rocker::fetch(db))
  expect_error(rocker::clearResult(db))
  expect_error(rocker::commit(db))
  expect_error(rocker::rollback(db))
  # expect_error(rocker::disconnect(db))
  expect_error(rocker::unloadDriver(db))

  rocker::begin(db)
  # drv +, con +, tra +, res -
  expect_true(!is.null(db$info))
  expect_true(!is.null(db$.drv))
  expect_true(!is.null(db$.con))
  expect_true(!isFALSE(db$transaction))
  expect_true(is.null(db$.res))
  expect_error(rocker::setupDriver(db, RSQLite::SQLite(), dbname = ":memory:"))
  expect_error(rocker::connect(db))
  # expect_error(rocker::writeTable(db, "mtcars", mtcars))
  expect_error(rocker::begin(db))
  # expect_error(rocker::sendQuery(db, "SELECT * FROM mtcars;"))
  # expect_error(rocker::sendStatement(db, "DELETE FROM mtcars WHERE gear = 3;"))
  expect_error(rocker::fetch(db))
  expect_error(rocker::clearResult(db))
  # expect_error(rocker::commit(db))
  # expect_error(rocker::rollback(db))
  expect_error(rocker::disconnect(db))
  expect_error(rocker::unloadDriver(db))

  rocker::sendStatement(db, "DELETE FROM mtcars WHERE gear = 3;")
  # drv +, con +, tra +, res +
  expect_true(!is.null(db$info))
  expect_true(!is.null(db$.drv))
  expect_true(!is.null(db$.con))
  expect_true(!isFALSE(db$transaction))
  expect_true(!is.null(db$.res))
  expect_error(rocker::setupDriver(db, RSQLite::SQLite(), dbname = ":memory:"))
  expect_error(rocker::connect(db))
  expect_error(rocker::writeTable(db, "mtcars", mtcars))
  expect_error(rocker::begin(db))
  expect_error(rocker::sendQuery(db, "SELECT * FROM mtcars;"))
  expect_error(rocker::sendStatement(db, "DELETE FROM mtcars WHERE gear = 3;"))
  # expect_error(rocker::fetch(db))
  # expect_error(rocker::clearResult(db))
  expect_error(rocker::commit(db))
  expect_error(rocker::rollback(db))
  expect_error(rocker::disconnect(db))
  expect_error(rocker::unloadDriver(db))

  rocker::clearResult(db)
  # drv +, con +, tra +, res -
  expect_true(!is.null(db$info))
  expect_true(!is.null(db$.drv))
  expect_true(!is.null(db$.con))
  expect_true(!isFALSE(db$transaction))
  expect_true(is.null(db$.res))
  expect_error(rocker::setupDriver(db, RSQLite::SQLite(), dbname = ":memory:"))
  expect_error(rocker::connect(db))
  # expect_error(rocker::writeTable(db, "mtcars", mtcars))
  expect_error(rocker::begin(db))
  # expect_error(rocker::sendQuery(db, "SELECT * FROM mtcars;"))
  # expect_error(rocker::sendStatement(db, "DELETE FROM mtcars WHERE gear = 3;"))
  expect_error(rocker::fetch(db))
  expect_error(rocker::clearResult(db))
  # expect_error(rocker::commit(db))
  # expect_error(rocker::rollback(db))
  expect_error(rocker::disconnect(db))
  expect_error(rocker::unloadDriver(db))

  rocker::commit(db)
  # drv +, con +, tra -, res -
  expect_true(!is.null(db$info))
  expect_true(!is.null(db$.drv))
  expect_true(!is.null(db$.con))
  expect_true(isFALSE(db$transaction))
  expect_true(is.null(db$.res))
  expect_error(rocker::setupDriver(db, RSQLite::SQLite(), dbname = ":memory:"))
  expect_error(rocker::connect(db))
  # expect_error(rocker::writeTable(db, "mtcars", mtcars))
  # expect_error(rocker::begin(db))
  # expect_error(rocker::sendQuery(db, "SELECT * FROM mtcars;"))
  # expect_error(rocker::sendStatement(db, "DELETE FROM mtcars WHERE gear = 3;"))
  expect_error(rocker::fetch(db))
  expect_error(rocker::clearResult(db))
  expect_error(rocker::commit(db))
  expect_error(rocker::rollback(db))
  # expect_error(rocker::disconnect(db))
  expect_error(rocker::unloadDriver(db))

  rocker::disconnect(db)
  # drv +, con -, tra -, res -
  expect_true(!is.null(db$info))
  expect_true(!is.null(db$.drv))
  expect_true(is.null(db$.con))
  expect_true(isFALSE(db$transaction))
  expect_true(is.null(db$.res))
  expect_error(rocker::setupDriver(db, RSQLite::SQLite(), dbname = ":memory:"))
  # expect_error(rocker::connect(db))
  expect_error(rocker::writeTable(db, "mtcars", mtcars))
  expect_error(rocker::begin(db))
  expect_error(rocker::sendQuery(db, "SELECT * FROM mtcars;"))
  expect_error(rocker::sendStatement(db, "DELETE FROM mtcars WHERE gear = 3;"))
  expect_error(rocker::fetch(db))
  expect_error(rocker::clearResult(db))
  expect_error(rocker::commit(db))
  expect_error(rocker::rollback(db))
  expect_error(rocker::disconnect(db))
  # expect_error(rocker::unloadDriver(db))

  rocker::unloadDriver(db)
  # drv -, con -, tra -, res -
  expect_true(is.null(db$info))
  expect_true(is.null(db$.drv))
  expect_true(is.null(db$.con))
  expect_true(isFALSE(db$transaction))
  expect_true(is.null(db$.res))
  # expect_error(rocker::setupDriver(db, RSQLite::SQLite(), dbname = ":memory:"))
  expect_error(rocker::connect(db))
  expect_error(rocker::writeTable(db, "mtcars", mtcars))
  expect_error(rocker::begin(db))
  expect_error(rocker::sendQuery(db, "SELECT * FROM mtcars;"))
  expect_error(rocker::sendStatement(db, "DELETE FROM mtcars WHERE gear = 3;"))
  expect_error(rocker::fetch(db))
  expect_error(rocker::clearResult(db))
  expect_error(rocker::commit(db))
  expect_error(rocker::rollback(db))
  expect_error(rocker::disconnect(db))
  expect_error(rocker::unloadDriver(db))

  rm(db)
})
