#' Use DBHDS README.Rmd template
#'
#' Creates an Rmarkdown file to be rendered as the package
#' README.md file. Importantly, the file must be knit as a standard markdown
#' file using `devtools::build_readme()`.
#'
#' An R package is required to contain a README.md file. That file is a
#' standard markdown document with a `.md` extension. Using Rmarkdown,
#' it is possible to make a more engaging and visually appealing README file.
#'
#' A basic README.Rmd file can be created within the package root directory by
#' calling `usethis::use_readme_rmd()`. The README.Rmd file created using `zkgr`
#' includes additional details and formatting aligned to DBHDS standards.
#'
#' @param package The package name. If `null`, defaults to the current package
#' from the description file
#'
#' @return `null` The file README.Rmd will be created in the package
#' directory root
#'
#' @export
#'
#' @examples
#' \dontrun{
#'    use_dbhds_readme()
#' }

use_dbhds_readme <- function(package = NULL) {

  check_is_package("use_dbhds_readme()")
  check_uses_roxygen("use_dbhds_readme()")

  pkg <- get_pkg_from_desc(package)

  use_template(
    "README.Rmd",
    data = list(
      package = pkg,
      maintainer_name  = get_maintainer_name(),
      maintainer_email = get_maintainer_email()
      )) && roxygen_remind()
  usethis::edit_file("README.Rmd")
  invisible(TRUE)
}
