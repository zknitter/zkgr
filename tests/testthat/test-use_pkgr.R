test_that("use_pkgr does not require user input when run in batch mode", {
  # configure test package
  pkg <- create_local_package()
  fake_url <- sprintf(
    "https://dev.azure.com/dbhds-virginia/ProjectName/_git/%s",
    pkgload::pkg_name(pkg)
  )
  desc::desc_add_urls(urls = fake_url)

  # call function
  use_pkgr(copyright_holder = "Epidemiology and Health Analytics")

  # run tests
  expect_true(fs::file_exists("_pkgdown.yml")) # creates _pkgdown.yml
  # _pkgdown.yml contains proper URLs
  expect_identical(
    yaml::yaml.load_file("_pkgdown.yml")$repo$url$source,
    sprintf("%s?path=/", fake_url)
    )
  expect_identical(
    yaml::yaml.load_file("_pkgdown.yml")$home$links[[1]]$href,
    fake_url
  )
  # test that documentation functions are added to package namespace
  expect_true("docs" %in% pkg_exports(pkg))
  expect_true("serve_docs" %in% pkg_exports(pkg))
})



test_that("use_pkgr throws error when there is no URL in the description", {
  # configure test package
  pkg <- create_local_package()

  use_pkgr(copyright_holder = "Epidemiology and Health Analytics")

  # run tests
  expect_false("docs" %in% pkg_exports(pkg))
  expect_false("serve_docs" %in% pkg_exports(pkg))
})


