#' Use DBHDS documentation standards in your package
#'
#' Does setup necessary to use self-contained DBHDS configurations for pkgdown
#' sites in your package. This includes the following functions:
#' 1. `update_docs()` - used to render a `pkgdown` static site within the
#' installed package, making the documentation available insite the package with
#' each release
#' 2. `docs()` - when called from the package, will open a Web browser window
#' referencing the static HTML files for the `pkgdown` site rendered using
#' `update_docs()`
#' 3. `serve_docs()` - when called from the package, will spin up a server on
#' the user's machine by calling `servr::httd()` to load the `pkgdown` site
#' stored within the package
#'
#' @note This function requires the use roxygen.
#'
#' @export
#'
#' @param package The name of the package to create the documentation in (will
#' default to the current package name using the DESCRIPTION file in the active
#' .Rproj file)
#'
#' @examples
#' \dontrun{
#' use_dbhds_docs()
#' }
#'
#' @seealso `vignette("documentation-functions", package = "zkgr")`

use_dbhds_docs <- function(package = NULL) {

  export <- TRUE

  check_is_package("use_dbhds_docs()")
  check_uses_roxygen("use_dbhds_docs()")

  package <- get_pkg_from_desc(package)

  if (export) {
    #usethis:::use_dependency("magrittr", "Imports")
    use_template("pkgdown-docs-dbhds.R", "R/docs.R", data = list(package = package)) && roxygen_remind()
    return(invisible(TRUE))
  }

  #usethis::use_import_from("magrittr", "%>%")
}


# Code from `usethis/R/roxygen.R` ----

uses_roxygen <- function() {
  desc::desc_has_fields("RoxygenNote", file = usethis::proj_get())
}

roxygen_remind <- function() {
  usethis::ui_todo("Run {usethis::ui_code('devtools::document()')} to update {usethis::ui_path('NAMESPACE')}")
  TRUE
}

# Checkers ----------------------------------------------------------------

check_uses_roxygen <- function(whos_asking) {
  force(whos_asking)

  if (uses_roxygen()) {
    return(invisible())
  }

  usethis::ui_stop(
    "
    Project {ui_value(project_name())} does not use roxygen2.
    {usethis::ui_code(whos_asking)} can not work without it.
    You might just need to run {usethis::ui_code('devtools::document()')} once, then try again.
    "
  )
}
