#' Use standard DBHDS package license
#'
#' Call this function to create a proprietary license aligned to DBHDS standards.
#' The license accepts an office name as the copyright holder.
#'
#' @param copyright_holder `character` The office within DBHDS that owns and
#' maintains the package
#'
#' @return A logical vector indicating if file was modified
#'
#' @export
#'
#' @examples
#' \dontrun{
#'   use_dbhds_license("Office of Epidemiology and Health Analytics")
#' }
use_dbhds_license <- function(copyright_holder) {

  data <- list(
    year = substr(Sys.Date(), 1, 4),
    copyright_holder = copyright_holder
  )

  if (is_package()) {
    use_description_field("License", "file LICENSE", overwrite = TRUE)
  }

  use_template("license-dbhds.txt", save_as = "LICENSE", data = data)
  use_license_template(data = data)
}


#' Helper function to create license.md and add it to .Rbuildignore
#'
#' @noRd
use_license_template <- function(data = list()) {

  use_template("license-dbhds.md",
               save_as = "LICENSE.md",
               data = data,
               ignore = TRUE
  )

}
