# Framework for exportable pkgdown documentation ----

#' Open package documentation
#'
#' This function launches a browser window for the `{{{package}}}` package
#' documentation. The documentation is automatically rendered using
#' [pkgdown](https://pkgdown.r-lib.org/index.html).
#'
#' @return NULL
#' @export
#'
#' @examples
#' if(interactive()){
#'   docs() # open documentation in Web browser if using standard account
#' }
docs <- function(){
  # documentation is not available for AA accounts due to app limitations
  if(is_AA()){
    stop("Package documentation cannot be accessed from AA accounts.")
  } else {
    utils::browseURL(pkgdown_doc_index(package = "{{{package}}}"))
  }
}


#' Serve package documentation
#'
#' This function launches a browser window for the `{{{package}}}` package
#' documentation. The documentation is automatically rendered using
#' [pkgdown](https://pkgdown.r-lib.org/index.html).
#'
#' @return NULL
#' @export
#'
#' @examples
#' if(interactive()){
#'   serve_docs() # open documentation in Web browser if using standard account
#' }
serve_docs <- function(){
  # documentation is not available for AA accounts due to app limitations
  if(is_AA()){
    stop("Package documentation cannot be accessed from AA accounts.")
  } else {
    servr::httd(pkgdown_doc_root(package = "{{{package}}}"), verbose = FALSE)
  }
}



#' Render pkgdown documentation for local access within package
#'
#'This function is intended to facilitate the maintenance and development of
#'this R package by copying pkgdown documentation from its location outside of
#'resources published with the package to a directory released with the package.
#'
#' @return `NULL` creates updated directory of pkgdown documentation
#' @keywords internal
#'
#' @examples
#' if(FALSE){
#'   update_docs()
#' }
update_docs <- function(){
  published_doc_dir <- fs::path(".", "inst", "pkgdown_docs")
  pkgdown::build_site(override = list("destination" = published_doc_dir))
}



# Project-related utility functions ----

# Retrieve location of pkgdown documentation
#' @noRd
pkgdown_doc_root <- function(package){
  fs::path(system.file(package = package), "pkgdown_docs")
}

# Retrieve location of pkgdown documentation index.html
#' @noRd
pkgdown_doc_index <- function(package){
  fs::path(pkgdown_doc_root(package), "index.html")
}


# Account information utilities ----
#' @noRd
is_AA <- function() {
  grepl(pattern="^(aa)", get_alias())
}

#' @noRd
is_standard <- function() {
  !is_AA()
}

# Helper function to get a user's operating system
#' @noRd
get_os <- function(){
  Sys.getenv("OS")
}

# Helper function to get a user's alias
#' @noRd
get_alias <- function(){
  toupper(Sys.getenv("USERNAME"))
}
