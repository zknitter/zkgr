# test `use_dbhds_logo()` function

# test that logo is copied ----
test_that("use_dbhds_logo() properly copies logo", {
  pkg <- create_local_package()
  use_dbhds_logo()

  expect_true(fs::file_exists("man/figures/logo.svg"))
})

# test that logo is not overwritten unintentionally ----
test_that("use_dbhds_logo() does not overwrite contents when false and shows message", {
  pkg <- create_local_package()
  use_dbhds_logo()

  expect_message(
    use_dbhds_logo(.overwrite = FALSE),
    rlang::inform(c(x = "Nothing to copy"))
  )
})

# test that logo is overwritten intentionally ----
test_that("use_dbhds_logo() overwrites logo when it already exists", {
  pkg <- create_local_package()
  use_dbhds_logo()

  expect_message(
    use_dbhds_logo(.overwrite = TRUE),
    rlang::inform(c(v = "Resources copied locally."))
  )
})
