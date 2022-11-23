#' Use pkgr YAML file to load styles from this package
#'
#' @description
#' [pkgdown](https://pkgdown.r-lib.org) makes it easy to turn your package into
#' a beautiful website.
#'
#' `use_pkgr_yaml` creates a YAML file  entitled `_pkgdown.yml` within a package
#' that automatically includes a reference to this package's template styles.
#' The structure of the YAML file is very basic, but the goal of this function
#' is to facilitate rapid development and minimize the amount of boilerplate
#' code necessary to style a new package.
#'
#' Below is the structure of the YAML file.
#'
#' ```yaml
#' template:
#'    package: zkgr
#' ```
#' Using this YAML template will enable a user to adopt styles aligned to DBHDS
#' package guidelines with a single line of code.
#'
#'
#' @seealso <https://pkgdown.r-lib.org/articles/customise.html#template-packages>
#'
#' @param config_file Path to the pkgdown yaml config file, relative to the
#'  project
#' @param destdir Target directory for pkgdown docs
#' @param strict `logical` If `TRUE`, requires that prompts be answered in an
#' interactive session
#'
#' @export
use_pkgr_yaml <- function(config_file = "_pkgdown.yml",
                          destdir = "inst/pkgdown_docs", strict = TRUE) {
  check_is_package("use_pkgdown()")
  rlang::check_installed("pkgdown")

  usethis::use_build_ignore(c(config_file, "pkgdown"))

  if(!desc_url_exists()){
    question <- "
    DESCRIPTION does not have a URL defined.
    This will cause _pkgdown.yml to be created with a default URL of:
    https://dev.azure.com/dbhds-virginia/{project_name}/{package_repo}

    You will need to replace the values {project_name} and {package_repo}
    manually in multiple places in _pkgdown.yml

    Would you still like to proceed?
    "
    if(!can_proceed(question, strict)) stop("Action cancelled by user")
  }
  config <- pkgdown_custom_config(destdir)
  config_path <- usethis::proj_path(config_file)
  usethis::write_over(config_path, yaml::as.yaml(config))
  usethis::edit_file(config_path)

  invisible(TRUE)
}

pkgdown_custom_config <- function(destdir) {
  # get URL from DESCRIPTION
  pkg_url <- desc::desc_get_urls()[1]

  # define values to pipe into template
  if(is.na(pkg_url) | !is_devops_url(pkg_url)){
    pkg_url     <- "https://dev.azure.com/dbhds-virginia/project_name/_git/package_repo"
    repo_source <- "https://dev.azure.com/dbhds-virginia/project_name/_git/package_repo?path=/"
  } else{
    repo_source <- sprintf("%s?path=/", pkg_url)
  }

  pkg_link_text <- "View source code on Azure DevOps"

  # create YAML
  config <- list(
    template = list(package = "zkgr"), # close template
    navbar = list(
      structure = list(
        right = c("devops")
        ),
      components = list(
        devops = list(
          text = pkg_link_text,
          icon = "fa-code",
          href = pkg_url,
          aria_label = pkg_link_text
        )
      )
    ), # close navbar
    home = list(
      links = list(
        list(
          text = pkg_link_text,
          href = pkg_url
          )
      )
    ), # close home
    repo = list(
      url = list(
        source = repo_source
      )
    ), # close repo
    reference = list(
      list(
        title    = "Access package documentation",
        desc     = "Open package documentation rendered with `pkgdown`",
        contents = list("docs", "serve_docs")
        )
      ) # close reference
    ) # close config

  if (!identical(destdir, "docs")) {
    config$destination <- destdir
  }

  config
}

# Related utility functions ----

desc_url_exists <- function(){
  !is.na(desc::desc_get_urls()[1])
}

can_proceed <- function(question, strict = TRUE){
  if(rlang::is_interactive()){
    usethis::ui_yeah(question)
  } else {
    !strict
  }
}

is_devops_url <- function(url){
  grepl(url, pattern = "^https://dev.azure.com/dbhds-virginia/[[:graph:]]{+}/_git/[[:graph:]]{+}")
}
