
test_that("Password hidden", {
  db <- rocker::newDB(verbose = FALSE)
  expect_true(is.environment(db$.__enclos_env__))
  expect_true(is.environment(db$.__enclos_env__$private))
  expect_null(db$.__enclos_env__$private$key)
  expect_null(db$.__enclos_env__$private$settings)

  db$setupSQLite()
  expect_null(db$.__enclos_env__)
  expect_null(db$.__enclos_env__$private)
  expect_null(db$.__enclos_env__$private$key)
  expect_null(db$.__enclos_env__$private$settings)

  db$unloadDriver()
  expect_true(is.environment(db$.__enclos_env__))
  expect_true(is.environment(db$.__enclos_env__$private))
  expect_null(db$.__enclos_env__$private$key)
  expect_null(db$.__enclos_env__$private$settings)

  rm(db)
})
