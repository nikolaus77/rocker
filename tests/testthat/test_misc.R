
test_that("Setup driver", {
  db <- rocker::newDB(verbose = FALSE)
  expect_true(is.null(db$.drv))

  db$setupSQLite()
  expect_true(!is.null(db$.drv))
  db$unloadDriver()
  expect_true(is.null(db$.drv))
  rocker::setupSQLite(db)
  expect_true(!is.null(db$.drv))
  rocker::unloadDriver(db)
  expect_true(is.null(db$.drv))

  db$setupPostgreSQL()
  expect_true(!is.null(db$.drv))
  db$unloadDriver()
  expect_true(is.null(db$.drv))
  rocker::setupPostgreSQL(db)
  expect_true(!is.null(db$.drv))
  rocker::unloadDriver(db)
  expect_true(is.null(db$.drv))

  db$setupMariaDB()
  expect_true(!is.null(db$.drv))
  db$unloadDriver()
  expect_true(is.null(db$.drv))
  rocker::setupMariaDB(db)
  expect_true(!is.null(db$.drv))
  rocker::unloadDriver(db)
  expect_true(is.null(db$.drv))

  rm(db)
})

test_that("Read only", {
  db <- rocker::newDB(verbose = FALSE)
  expect_error(db$.drv <- "test")
  expect_error(db$.con <- "test")
  expect_error(db$.res <- "test")
  expect_error(db$transaction <- "test")
  expect_error(db$info <- "test")
  rm(db)
})

test_that("Verbose", {
  expect_output(db <- rocker::newDB())
  expect_error(db$verbose <- "test")
  db$verbose <- FALSE
  expect_false(db$verbose)
  db$verbose <- TRUE
  expect_true(db$verbose)
  expect_output(db$print())
  rm(db)
})

test_that("Auto connect", {
  db <- rocker::newDB(verbose = FALSE)
  db$setupSQLite(dbname = tempfile())
  expect_output(db$print())
  db$connect()
  db$writeTable("mtcars", mtcars)
  db$disconnect()

  out <- db$getQuery("SELECT * FROM mtcars;", 3)
  expect_equal(nrow(out), 32)
  rm(out)

  db$verbose <- TRUE
  expect_output(out <- db$getQuery("SELECT * FROM mtcars;", 3))
  expect_equal(nrow(out), 32)
  rm(out)
  db$verbose <- FALSE

  out <- db$execute("DELETE FROM mtcars WHERE gear = 4;")
  expect_equal(out, 12)
  rm(out)

  db$unloadDriver()
  rm(db)
})

test_that("id", {
  db <- rocker::newDB(verbose = FALSE, id = "test")
  expect_identical(db$id, "test")
  db$id <- " \t \r \n "
  expect_null(db$id)
  db$id <- "test"
  expect_identical(db$id, "test")
  db$id <- NULL
  expect_null(db$id)
  db$id <- " test "
  expect_identical(db$id, "test")

  db$verbose <- TRUE
  expect_output(db$setupSQLite())
  expect_output(db$unloadDriver())

  expect_output(db$print())

  rm(db)
})

test_that("functions", {
  expect_error(error("test"))
  expect_error(error("test", FALSE))
  expect_warning(error("test", TRUE))

  testParameter(list(a = 1, b = 2, c = 3))
  testParameter(list(a = 1, b = 2, c = 3), FORBIDDEN = c("d"))
  testParameter(list(a = 1, b = 2, c = 3), FORBIDDEN = c("d", "e"))
  testParameter(list(a = 1, b = 2, c = 3), OBLIGATORY = c("a"))
  testParameter(list(a = 1, b = 2, c = 3), OBLIGATORY = c("a", "b"))
  testParameter(list(a = 1, b = 2, c = 3), FORBIDDEN = c("d", "e"), OBLIGATORY = c("a", "b"))
  expect_error(testParameter(list(a = 1, b = 2, c = 3), FORBIDDEN = c("a")))
  expect_error(testParameter(list(a = 1, b = 2, c = 3), FORBIDDEN = c("a", "d")))
  expect_error(testParameter(list(a = 1, b = 2, c = 3), OBLIGATORY = c("d")))
  expect_error(testParameter(list(a = 1, b = 2, c = 3), OBLIGATORY = c("d", "a")))
  expect_error(testParameter(list(a = 1, b = 2, c = 3), FORBIDDEN = c("a", "d"), OBLIGATORY = c("a", "b")))
  expect_error(testParameter(list(a = 1, b = 2, c = 3), FORBIDDEN = c("d", "e"), OBLIGATORY = c("d", "a")))
  expect_error(testParameter(list(a = 1, b = 2, c = 3), FORBIDDEN = c("a", "d"), OBLIGATORY = c("d", "a")))
})

test_that("encryption", {
  LST <- list(a = 1, b = 2, abc = "abc")
  KEY <- generateKey()
  TMP <- encrypt(LST, KEY)
  expect_identical(LST, decrypt(TMP, KEY))
  rm(LST, KEY, TMP)
})
