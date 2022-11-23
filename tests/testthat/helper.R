# These test helpers are copied from usethis
# https://github.com/r-lib/usethis/blob/main/tests/testthat/helper.R

# test fixture copied from testthat vignette
# https://testthat.r-lib.org/articles/test-fixtures.html?q=packa#package

silence_usethis <- function(env = parent.frame()){
  withr::local_options(list(usethis.quiet = TRUE), .local_envir = env)
}


create_local_package <- function(
  dir = fs::file_temp("zkgr"),
  env = parent.frame(),
  silent = TRUE
  ) {

  if(silent) silence_usethis(env)

  old_project <- usethis:::proj_get()            # --- Record starting state ---

  withr::defer({                        # --- Defer The Undoing ---
    usethis::proj_set(old_project, force = TRUE) # restore active usethis project (-C)
    setwd(old_project)                  # restore working directory      (-B)
    fs::dir_delete(dir)                 # delete the temporary package   (-A)
  }, envir = env)
  # --- Do The Doing ---
  usethis::create_package(dir, open = FALSE)  # create new folder and package (A)
  setwd(dir)                            # change working directory       (B)
  usethis::proj_set(dir)                # switch to new usethis project  (C)
  invisible(dir)
}




## If session temp directory appears to be, or be within, a project, there
## will be large scale, spurious test failures.
## The IDE sometimes leaves .Rproj files behind in session temp directory or
## one of its parents.
## Delete such files manually.

# session_temp_proj <- proj_find(path_temp())
# if (!is.null(session_temp_proj)) {
#   Rproj_files <- fs::dir_ls(session_temp_proj, glob = "*.Rproj")
#   usethis::ui_line(c(
#     "Rproj file(s) found at or above session temp dir:",
#     paste0("* ", Rproj_files),
#     "Expect this to cause spurious test failures."
#   ))
# }
#
# create_local_package <- function(dir = file_temp(pattern = "testpkg"),
#                                  env = parent.frame(),
#                                  rstudio = FALSE) {
#   create_local_thing(dir, env, rstudio, "package")
# }
#
# create_local_project <- function(dir = file_temp(pattern = "testproj"),
#                                  env = parent.frame(),
#                                  rstudio = FALSE) {
#   create_local_thing(dir, env, rstudio, "project")
# }
#
# create_local_thing <- function(dir = file_temp(pattern = pattern),
#                                env = parent.frame(),
#                                rstudio = FALSE,
#                                thing = c("package", "project")) {
#   thing <- match.arg(thing)
#   if (fs::dir_exists(dir)) {
#     usethis::ui_stop("Target {usethis::ui_code('dir')} {usethis::ui_path(dir)} already exists.")
#   }
#
#   old_project <- usethis::proj_get_() # this could be `NULL`, i.e. no active project
#   old_wd <- getwd()          # not necessarily same as `old_project`
#
#   withr::defer(
#     {
#       usethis::ui_done("Deleting temporary project: {usethis::ui_path(dir)}")
#       fs::dir_delete(dir)
#     },
#     envir = env
#   )
#   usethis::ui_silence(
#     switch(
#       thing,
#       package = usethis::create_package(dir, rstudio = rstudio, open = FALSE, check_name = FALSE),
#       project = usethis::create_project(dir, rstudio = rstudio, open = FALSE)
#     )
#   )
#
#   withr::defer(usethis::proj_set(old_project, force = TRUE), envir = env)
#   usethis::proj_set(dir)
#
#   withr::defer(
#     {
#       usethis::ui_done("Restoring original working directory: {ui_path(old_wd)}")
#       setwd(old_wd)
#     },
#     envir = env
#   )
#   setwd(usethis::proj_get())
#
#   invisible(usethis::proj_get())
# }




# scrub_testpkg <- function(message) {
#   gsub("testpkg[a-zA-Z0-9]+", "{TESTPKG}", message, perl = TRUE)
# }
#
# toggle_rlang_interactive <- function() {
#   # TODO: consider setting options(rlang_backtrace_on_error = "reminder") when
#   # in non-interactive mode, to suppress full backtraces
#   before <- getOption("rlang_interactive")
#   after <- if (identical(before, FALSE)) TRUE else FALSE
#   options(rlang_interactive = after)
#   usethis::ui_line(glue::glue("rlang_interactive: {before %||% '<unset>'} --> {after}"))
#   invisible()
# }
#
# skip_if_not_ci <- function() {
#   ci_providers <- c("GITHUB_ACTIONS", "TRAVIS", "APPVEYOR")
#   ci <- any(toupper(Sys.getenv(ci_providers)) == "TRUE")
#   if (ci) {
#     return(invisible(TRUE))
#   }
#   skip("Not on GitHub Actions, Travis, or Appveyor")
# }
#
# skip_if_no_git_user <- function() {
#   user_name <- git_cfg_get("user.name")
#   user_email <- git_cfg_get("user.email")
#   user_name_exists <- !is.null(user_name)
#   user_email_exists <- !is.null(user_email)
#   if (user_name_exists && user_email_exists) {
#     return(invisible(TRUE))
#   }
#   skip("No Git user configured")
# }
#
# # CRAN's mac builder sets $HOME to a read-only ram disk, so tests can fail if
# # you even tickle something that might try to lock its own config file during
# # the operation (e.g. git) or if you simply test for writeability
# skip_on_cran_macos <- function() {
#   sysname <- tolower(Sys.info()[["sysname"]])
#   on_cran <- !identical(Sys.getenv("NOT_CRAN"), "true")
#   if (on_cran && sysname == "darwin") {
#     skip("On CRAN and on macOS")
#   }
#   invisible(TRUE)
# }
#
# # with_mock <- function(..., .parent = parent.frame()) {
# #   mockr::with_mock(..., .parent = .parent, .env = "usethis")
# # }
#
# expect_usethis_error <- function(...) {
#   expect_error(..., class = "usethis_error")
# }
#
# expect_error_free <- function(...) {
#   expect_error(..., regexp = NA)
# }
#
# is_build_ignored <- function(pattern, ..., base_path = proj_get()) {
#   lines <- read_utf8(path(base_path, ".Rbuildignore"))
#   length(grep(pattern, x = lines, fixed = TRUE, ...)) > 0
# }
#
# test_file <- function(fname) testthat::test_path("ref", fname)
#
# expect_proj_file <- function(...) expect_true(file_exists(proj_path(...)))
# expect_proj_dir <- function(...) expect_true(dir_exists(proj_path(...)))



# helper function to show functions exported by package ----
pkg_exports <- function(pkg = NULL){
  pkgload::parse_ns_file(pkg)$exports
}

