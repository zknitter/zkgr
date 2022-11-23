# tests that DBHDS README.Rmd will be created properly

# test that file is created when no README.Rmd exists ----

## snapshot test for console output ----
test_that("use_dbhds_readme() works", {
  pkg <- create_local_package(silent = FALSE)

  expect_snapshot(use_dbhds_readme(pkg))

})

## test within empty local package context ----

### verify file is created ----
test_that("use_dbhds_readme() creates README.Rmd", {
  #silence_usethis()
  pkg <- create_local_package()

  use_dbhds_readme(pkg)

  expect_true(fs::file_exists("README.Rmd"))
})

### verify non-interactive use ----
# test_that("use_dbhds_readme() works in non-interactive context", {
#   silence_usethis()
#
#   pkg <- create_local_package()
#   rlang::with_interactive(use_dbhds_readme(pkg), value = FALSE)
#
#   expect_true(fs::file_exists("README.Rmd"))
# })
#
# ### verify interative use ----
# test_that("use_dbhds_readme() works in interactive context", {
#   silence_usethis()
#
#   pkg <- create_local_package()
#   rlang::with_interactive(use_dbhds_readme(pkg), value = TRUE)
#
#   expect_true(fs::file_exists("README.Rmd"))
# })

# test that file is not automatically created when README.Rmd exists ----

test_that("use_dbhds_readme() does not overwrite existing file", {
  pkg <- create_local_package()

  fs::file_create("README.Rmd")

  expect_snapshot(use_dbhds_readme(pkg))
})
