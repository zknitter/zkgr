# test pkgr_yaml()

# test .Rbuildignore changes ----
## changes present when URL already set in DESCRIPTION----
test_that("use_pkgr_yaml() adds fields to .Rbuildignore", {
  pkg <- create_local_package() # package with no URL in description
  # set URL in description
  desc::desc_add_urls("https://dev.azure.com/dbhds-virginia/EHA_Projects/EHA_Test")

  use_pkgr_yaml()
  build_ignore <- read_utf8(".Rbuildignore")

  bi_matches    <- sum(as.integer(grepl("(pkgdown)", build_ignore)))
  expect_true(bi_matches == 2)
})


## changes present when URL absent and strict=FALSE ----
test_that("use_pkgr_yaml() does not require URL to proceed when strict=FALSE", {
  pkg <- create_local_package() # package with no URL in description

  use_pkgr_yaml(strict = FALSE) # disable to allow batch use
  build_ignore <- read_utf8(".Rbuildignore")

  bi_matches    <- sum(as.integer(grepl("(pkgdown)", build_ignore)))
  expect_true(bi_matches == 2)
})


# Check URL-based arguments ----

## verify utility function works as expected ----
test_that("is_devops_url() works",{
  expect_false(is_devops_url("www.example.com"))
  expect_false(is_devops_url("https://dev.azure.com/dbhds-virginia/_git/dbhds.pkg"))
  expect_false(is_devops_url("https://dev.azure.com/dbhds-virginia//_git/dbhds.pkg"))
  expect_false(is_devops_url("dev.azure.com/dbhds-virginia/"))
  expect_false(is_devops_url("https://dev.azure.com/dbhds-virginia/ /_git/dbhds.pkg"))
  expect_false(is_devops_url("https://dev.azure.com/dbhds-virginia/e/_git/"))
  expect_true(is_devops_url("https://dev.azure.com/dbhds-virginia/p/_git/p"))
  expect_true(is_devops_url("https://dev.azure.com/dbhds-virginia/EHA%20Packages/_git/dbhds.pkg"))
})

## error thrown when URL absent and strict=TRUE ----
test_that("use_pkgr_yaml() throws expected error", {
  pkg <- create_local_package() # package with no URL in description

  expect_error(use_pkgr_yaml(strict=TRUE))
})


