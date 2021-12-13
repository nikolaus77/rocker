
test_that("Password hidden", {
  db <- rocker::newDB(verbose = FALSE)
  expect_true(is.environment(db$.__enclos_env__))
  expect_true(is.environment(db$.__enclos_env__$private))
  expect_identical(db$.__enclos_env__$private$key, NULL)
  expect_identical(db$.__enclos_env__$private$settings, NULL)

  db$setupSQLite()
  expect_identical(db$.__enclos_env__, NULL)
  expect_identical(db$.__enclos_env__$private, NULL)
  expect_identical(db$.__enclos_env__$private$key, NULL)
  expect_identical(db$.__enclos_env__$private$settings, NULL)

  db$unloadDriver()
  expect_true(is.environment(db$.__enclos_env__))
  expect_true(is.environment(db$.__enclos_env__$private))
  expect_identical(db$.__enclos_env__$private$key, NULL)
  expect_identical(db$.__enclos_env__$private$settings, NULL)

  rm(db)
})
