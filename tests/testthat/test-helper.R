# These tests verify that the create_local_package() test helper
#  works without issues. This is a prerequisite for multiple tests to operate
#  as expected.


test_that("create_local_package helper has identical DESCRIPTION", {
  pkg <- create_local_package()

  expect_identical(
    desc::desc_get("Package", pkg),
    desc::desc_get("Package", pkg)
  )
})


test_that("create_local_package helper has identical Author", {
  pkg <- create_local_package()

  expect_identical(
    desc::desc_get("Author", pkg),
    desc::desc_get("Author", pkg)
  )
})


test_that("create_local_package helper has identical Author", {
  pkg <- create_local_package()

  expect_identical(
    desc::desc_get_author(pkg),
    desc::desc_get_author(pkg)
  )
})


test_that("create_local_package helper returns expected author class", {
  pkg <- create_local_package()

  expect_s3_class(
    desc::desc_get_author(pkg),
    "person",
    exact = TRUE
  )
})


test_that("create_local_package helper returns author as character", {
  pkg <- create_local_package()

  expect_type(desc::desc_get("Author", pkg), "character")
})
