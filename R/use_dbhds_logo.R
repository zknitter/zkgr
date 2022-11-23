#' Use DBHDS logo in destination package
#'
#' Use this function to copy the DBHDS logo into the destination package. In
#' order to use this package with pkgdown, the DBHDS logo is saved in
#' 'man/figures/logo.svg'.
#'
#' @param .overwrite `logical`
#'
#' @return NULL copies the DBHDS logo to the destination package
#' @export
#'
#' @examples
#' if(FALSE) use_dbhds_logo()
use_dbhds_logo <- function(.overwrite = TRUE){

  if (!.overwrite) {
    rlang::inform(c(x = "Nothing to copy"))
    return(invisible(FALSE))
  }

  # find logo.svg in this package
  logo_src <- system.file("pkgdown", "assets", "logo.svg", package = "zkgr")

  # set destination for logo
  logo_dir  <- "man/figures/"
  logo_dest <- fs::path(logo_dir, "logo.svg")

  # copy logo to destination package
  fs::dir_create(logo_dir)
  fs::file_copy(logo_src, logo_dest, overwrite = .overwrite)

  rlang::inform(c(v = "Resources copied locally."))
  return(invisible(TRUE))
}
