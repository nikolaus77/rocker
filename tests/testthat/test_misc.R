
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

test_that("validateQuery", {
  db <- rocker::newDB(verbose = FALSE)
  expect_identical(db$validateQuery, "SELECT 1")
  db$validateQuery <- " \t \r \n "
  expect_identical(db$validateQuery, "SELECT 1")
  db$validateQuery <- "test"
  expect_identical(db$validateQuery, "test")
  db$validateQuery <- NULL
  expect_identical(db$validateQuery, "SELECT 1")
  db$validateQuery <- " test "
  expect_identical(db$validateQuery, "test")
  rm(db)
})

test_that("functions", {
  expect_error(error("test"))
  expect_error(error("test", FALSE))
  expect_warning(error("test", TRUE))

  testParameterNames(list(a = 1, b = 2, c = 3))
  testParameterNames(list(a = 1, b = 2, c = 3), FORBIDDEN = c("d"))
  testParameterNames(list(a = 1, b = 2, c = 3), FORBIDDEN = c("d", "e"))
  testParameterNames(list(a = 1, b = 2, c = 3), OBLIGATORY = c("a"))
  testParameterNames(list(a = 1, b = 2, c = 3), OBLIGATORY = c("a", "b"))
  testParameterNames(list(a = 1, b = 2, c = 3), FORBIDDEN = c("d", "e"), OBLIGATORY = c("a", "b"))
  expect_error(testParameterNames(list(a = 1, b = 2, c = 3), FORBIDDEN = c("a")))
  expect_error(testParameterNames(list(a = 1, b = 2, c = 3), FORBIDDEN = c("a", "d")))
  expect_error(testParameterNames(list(a = 1, b = 2, c = 3), OBLIGATORY = c("d")))
  expect_error(testParameterNames(list(a = 1, b = 2, c = 3), OBLIGATORY = c("d", "a")))
  expect_error(testParameterNames(list(a = 1, b = 2, c = 3), FORBIDDEN = c("a", "d"), OBLIGATORY = c("a", "b")))
  expect_error(testParameterNames(list(a = 1, b = 2, c = 3), FORBIDDEN = c("d", "e"), OBLIGATORY = c("d", "a")))
  expect_error(testParameterNames(list(a = 1, b = 2, c = 3), FORBIDDEN = c("a", "d"), OBLIGATORY = c("d", "a")))

  testParameterString("abc")
  testParameterString(c("abc", "def"), NA)
  expect_error(testParameterString(c("abc", "def")))
  expect_error(testParameterString(1))
  expect_error(testParameterString(TRUE))
  expect_error(testParameterString(NA))
  expect_error(testParameterString(NULL))

  testParameterWholeNumber(1)
  testParameterWholeNumber(c(-1, 0, 1), NA)
  expect_error(testParameterWholeNumber(c(-1, 0, 1)))
  expect_error(testParameterWholeNumber(1.1))
  expect_error(testParameterWholeNumber("abc"))
  expect_error(testParameterWholeNumber(TRUE))
  expect_error(testParameterWholeNumber(NA))
  expect_error(testParameterWholeNumber(NULL))

  testParameterStringWholeNumber(1)
  testParameterStringWholeNumber("abc")
  testParameterStringWholeNumber(c("abc", "def"), NA)
  testParameterStringWholeNumber(c(-1, 0, 1), NA)
  expect_error(testParameterStringWholeNumber(c("abc", "def")))
  expect_error(testParameterStringWholeNumber(c(-1, 0, 1)))
  expect_error(testParameterStringWholeNumber(1.1))
  expect_error(testParameterStringWholeNumber(TRUE))
  expect_error(testParameterStringWholeNumber(NA))
  expect_error(testParameterStringWholeNumber(NULL))

  testParameterBoolean(TRUE)
  testParameterBoolean(c(TRUE, FALSE), NA)
  expect_error(testParameterBoolean(0))
  expect_error(testParameterBoolean(1))
  expect_error(testParameterBoolean("TRUE"))
  expect_error(testParameterBoolean("FALSE"))
  expect_error(testParameterBoolean(NA))
  expect_error(testParameterBoolean(c(TRUE, NA), NA))
  expect_error(testParameterBoolean(NULL))

  testParameterDataFrame(mtcars)
  expect_error(testParameterDataFrame(as.matrix(mtcars)))
  expect_error(testParameterDataFrame(1))
  expect_error(testParameterDataFrame("abc"))
  expect_error(testParameterDataFrame(TRUE))
  expect_error(testParameterDataFrame(NA))
  expect_error(testParameterDataFrame(NULL))
  expect_error(testParameterDataFrame(1:3))
  expect_error(testParameterDataFrame(list(a = 1, b = 2, c = "abc")))

  testParameterObject(RSQLite::SQLite())
  expect_error(testParameterObject(1))
  expect_error(testParameterObject("abc"))
  expect_error(testParameterObject(TRUE))
  expect_error(testParameterObject(NA))
  expect_error(testParameterObject(NULL))
  expect_error(testParameterObject(mtcars))

})

test_that("encryption", {
  LST <- list(a = 1, b = 2, abc = "abc")
  KEY <- generateKey()
  TMP <- encrypt(LST, KEY)
  expect_identical(LST, decrypt(TMP, KEY))
  rm(LST, KEY, TMP)
})
