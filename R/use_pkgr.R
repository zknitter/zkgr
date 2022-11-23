#' Use all default styles for DBHDS R packages
#'
#' @description `use_pkgr` is a wrapper function for all functions within
#' the `zkgr` package. It allows the user to rapidly adopt the default
#' DBHDS package license, pkgdown template, and agency logo.
#'
#' The command
#' ```R
#' use_pkgr("Office of Epidemiology and Health Analytics")
#' ```
#' is equivalent to calling the following functions in order:
#'
#' ```R
#' usethis::use_roxygen_md()   # enable markdown in package .Rd files
#' use_dbhds_license("Office of Epidemiology and Health Analytics")
#' devtools::document()        # build package metadata for first time
#' use_dbhds_docs()
#' use_pkgr_yaml()
#' use_dbhds_logo()
#' devtools::document()
#' use_dbhds_readme()
#' devtools::build_readme()
#' ```
#' Most users of this package will find this single function to be the only one
#' they need to use for this package.
#'
#' @param copyright_holder `character` the office who holds the proprietary
#' license within DBHDS
#' @param config_file `character` the YAML file used to customize the
#' pkgdown documentation site
#' @param destdir `character` the directory where pkgdown static files
#' will be rendered
#' @param logo_overwrite `logical` whether to overwrite an existing logo file
#'
#' @return NULL
#' @export
#'
#' @examples
#' \dontrun{
#'    # create files in current package
#'    use_pkgr(copyright_holder = "Office of Epidemiology and Health Analytics")
#' }
use_pkgr <- function(copyright_holder, config_file = "_pkgdown.yml",
                     destdir = "inst/pkgdown_docs", logo_overwrite = TRUE){
  if(is.na(copyright_holder) | is.null(copyright_holder) | copyright_holder == ""){
    NULL
  } else if(!desc_url_exists()) {
    ui_oops("The package DESCRIPTION does not have a URL. Please add the package
    repo URL from Azure DevOps as the URL in the DESCRIPTION file. This will
    enable {ui_code('zkgr')} to automatically generate links to the source
    code.

    You can use {ui_code('desc::desc_add_urls(PASTE_URL_HERE)')} to add the URL
            from the console.")
  } else {
    cli::cli_rule(left = "Configuring package")
    usethis::use_roxygen_md()
    cli::cli_alert_success("Package configured")
    cli::cli_rule(left = "Copying DBHDS license")
    use_dbhds_license(copyright_holder)
    cli::cli_alert_success("License copied")
    cli::cli_rule(left = "Updating documentation")
    devtools::document()
    cli::cli_rule(left = "Copying DBHDS documentation functions")
    use_dbhds_docs()
    cli::cli_alert_success("DBHDS documentation functions copied")
    cli::cli_rule(left = sprintf("Creating %s", config_file))
    use_pkgr_yaml(config_file, destdir, strict = FALSE)
    cli::cli_alert_success(sprintf("%s created", config_file))
    cli::cli_rule(left = "Copying logo")
    use_dbhds_logo(logo_overwrite)
    cli::cli_alert_success("Logo copied")
    cli::cli_rule(left = "Updating package documentation")
    devtools::document()
    cli::cli_alert_success("Documentation updated")
    cli::cli_rule("Create README.Rmd and render README.md")
    use_dbhds_readme()
    devtools::build_readme()
    devtools::document()
    cli::cli_alert_success("README files created")
    cli::cli_rule(left = "Recommendations")
    cli::cli_ul(c(
      "Run `pkgdown::build_site()` or `update_docs()` to render a pkgdown site
      that will be installed with your package",
      "Run `docs()` or `serve_docs()` to view the documentation rendered with the package"
      ))
  }
}
