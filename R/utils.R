# Utility functions - not exported from package

# retrieve NULL package name from DESCRIPTION file ----
#' @noRd
get_pkg_from_desc <- function(package = NULL){
  if(is.null(package)){
    pkgload::pkg_name()
  } else {
    package
  }
}

# package maintainer information ----
#' @keywords internal
get_maintainer_name <- function(package = "."){
  stringr::str_extract(desc::desc_get_maintainer(package), pattern = "^.+(?= <)")
}

#' @keywords internal
get_maintainer_email <- function(package = "."){
  stringr::str_extract(desc::desc_get_maintainer(package), pattern = "(?<=<).+(?=>)")
}


# read UTF file----
#' @noRd
read_utf8 <- function(path, n = -1L) {
  base::readLines(path, n = n, encoding = "UTF-8", warn = FALSE)
}


# read data from description field `usethis` ----

#' @noRd
use_description_field <- function(name, value, overwrite = FALSE) {
  # account for `value`s produced via `glue::glue()`
  value <- as.character(value)
  curr <- desc::desc_get(name, file = usethis::proj_get())[[1]]
  curr <- gsub("^\\s*|\\s*$", "", curr)

  if (identical(curr, value)) {
    return(invisible())
  }

  if (!is.na(curr) && !overwrite) {
    usethis::ui_stop(
      "{usethis::ui_field(name)} has a different value in DESCRIPTION. \\
      Use {usethis::ui_code('overwrite = TRUE')} to overwrite."
    )
  }

  usethis::ui_done("Setting {usethis::ui_field(name)} field in DESCRIPTION to {usethis::ui_value(value)}")
  desc::desc_set(name, value, file = usethis::proj_get())
  invisible()
}


# Project utilities copied from `usethis`----

#' @noRd
is_package <- function(base_path = usethis::proj_get()) {
  res <- tryCatch(
    rprojroot::find_package_root_file(path = base_path),
    error = function(e) NULL
  )
  !is.null(res)
}

#' @noRd
check_is_package <- function(whos_asking = NULL) {
  if (is_package()) {
    return(invisible())
  }

  message <- "Project {usethis::ui_value(project_name())} is not an R package."
  if (!is.null(whos_asking)) {
    message <- c(
      "{usethis::ui_code(whos_asking)} is designed to work with packages.",
      message
    )
  }
  usethis::ui_stop(message)
}


# project utilities ----

proj_find <- function(path = ".") {
  tryCatch(
    rprojroot::find_root(proj_crit(), path = path),
    error = function(e) NULL
  )
}

proj_crit <- function() {
  rprojroot::has_file(".here") |
    rprojroot::is_rstudio_project |
    rprojroot::is_r_package |
    rprojroot::is_git_root |
    rprojroot::is_remake_project |
    rprojroot::is_projectile_project
}


# general utilities ----

year <- function() format(Sys.Date(), "%Y")

is_online <- function(host) {
  bare_host <- sub("^https?://(.*)$", "\\1", host)
  !is.null(curl::nslookup(bare_host, error = FALSE))
}

is_windows <- function() {
  .Platform$OS.type == "windows"
}
