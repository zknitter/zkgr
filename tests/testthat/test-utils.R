# test utility functions within this package
# (used in README.Rmd)



# tests for get_pkg_from_desc() ----

## data type ----
test_that("get_pkg_from_desc returns character when pkg not null", {
  pkg <- create_local_package()

  expect_type(get_pkg_from_desc(pkg), "character")
})


## when pkg argument not null, return expected value ----
test_that("get_pkg_from_desc contains expected pkg name", {
  pkg <- create_local_package()

  expect_true(
    grepl(
      get_pkg_from_desc(pkg),
      pattern = "(zkgr)",
      perl = TRUE
      )
    )
})


## when pkg argument is null, return expected value ----
test_that("get_pkg_from_desc contains expected pkg name when arg is NULL", {
  pkg <- create_local_package()

  expect_true(
    grepl(
      get_pkg_from_desc(),
      pattern = "(zkgr)",
      perl = TRUE
    )
  )
})



# tests for get_maintainer_name() ----

## when pkg argument is null, return expected value ----
test_that("get_maintainer_name contains expected pkg name when arg is NULL", {
  pkg <- create_local_package()

  expect_true(
    grepl(
      get_maintainer_name(),
      pattern = "First Last",
      perl = TRUE
    )
  )
})



# tests for get_maintainer_email() ----

## when pkg argument is null, return expected value ----
test_that("get_maintainer_email contains expected pkg name when arg is NULL", {
  pkg <- create_local_package()

  expect_true(
    grepl(
      get_maintainer_email(),
      pattern = "first.last@example.com",
      perl = TRUE
    )
  )
})



# tests for use_description_field() ----

## when DESCRIPTION field is NULL, set value ----
test_that("use_description_field() alters value when null", {
  pkg <- create_local_package()

  test_url <- "https://www.example.com"
  use_description_field(name = "URL", value = test_url)

  expect_identical(
    desc::desc_get_urls()[1],
    test_url
  )
})

## when DESCRIPTION field is not NULL, require overwrite (FALSE) ----
test_that("use_description_field() does not alter value when exists", {
  pkg <- create_local_package()

  expect_error(
    use_description_field(name = "RoxygenNote", value = "7.2.0")
  )
})


## when DESCRIPTION field is not NULL, require overwrite (TRUE)----
test_that("use_description_field() does not alter value when it exists", {
  pkg <- create_local_package()

  use_description_field(name = "RoxygenNote", value = "7.2.0", overwrite = TRUE)

  expect_identical(desc::desc_get_field(key = "RoxygenNote"), "7.2.0")

})

## when DESCRIPTION field is NULL, show message ----
test_that("use_description_field() alters value when null", {
  pkg <- create_local_package(silent = FALSE)

  test_url <- "https://www.example.com"

  expect_message(
    use_description_field(name = "URL", value = test_url),
    usethis:::ui_bullet(sprintf("Setting URL field in DESCRIPTION to '%s'", test_url))
  )
})


# tests for is_package() ----
test_that("use_description_field() alters value when null", {
  pkg <- create_local_package()

  expect_true(is_package())
})

