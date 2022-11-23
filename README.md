
<!-- README.md is generated from README.Rmd. Please edit that file -->

# zkgr

<!-- badges: start -->
<!-- badges: end -->

The goal of `zkgr` (pronounced “DBHDS packager”) is to provide a
template for R packages and documentation standardized across the
Virginia Department of Behavioral Health and Developmental Services
(DBHDS).

This package provides the resources necessary to rapidly develop R
packages that are aligned to DBHDS styles and policies.

## Installation

To install this package, complete the steps below:

1.  Access the DBHDS Azure DevOps instance in a modern Web browser  
2.  Navigate to the `zkgr` repository  
3.  Copy the clone URL for the repository  
4.  Using GitHub Desktop, clone from URL  
5.  Open the `.Rproj` file in RStudio
6.  Run `devtools::install()`
7.  Restart R

TODO: Update this section to reflect use of `remotes::install_git()`
with local copies of the relevant repositories. It appears as though the
`devtools::install()` function, at least with the relevant defaults,
does not install the package in the proper `base::.libPaths()` due to
the use of the `package?renv` package.

## Using `zkgr`

Once you have successfully installed the `zkgr` package, you can
use it to style your own R package.

### Prerequisite: Knowledge of Package Development

If you are creating your own R package for the first time, it is highly
recommended that you read [R Packages](https://r-pkgs.org/) by [Hadley
Wickham](http://hadley.nz/) and [Jenny Bryan](http://jennybryan.org/) to
gain some familiarity with this process before continuing. Reading *R
Packages* will introduce you to the basic workflow involved in building
an R package. More importantly for present purposes, *R Packages* will
orient you to modern tools for developing R packages including
[devtools](https://devtools.r-lib.org/),
[usethis](https://usethis.r-lib.org/), and
[pkgdown](https://pkgdown.r-lib.org/index.html).

If you are interested in learning more about developing R packages, you
can find additional resources in the following vignette:
`vignette("additional-resources")`.

### A Basic Example

``` r
# call this function within your package's project directory
library(devtools)
zkgr::use_pkgr(copyright_holder = "Office of Epidemiology and Health Analytics")
```

<!--
You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this. You could also use GitHub Actions to re-render `README.Rmd` every time you push. An example workflow can be found here: <https://github.com/r-lib/actions/tree/v1/examples>.
-->

## Maintaining this Package

This package is maintained by [Zachary
Knitter](mailto:%20zachary.knitter@dbhds.virginia.gov), but anyone with
access to this [Git
repository](https://dev.azure.com/dbhds-virginia/EHA%20Packages/_git/zkgr)
can contribute by creating a branch, making changes, and submitting a
pull request for the main branch.

This package includes the function `zkgr::update_docs()` to
facilitate updates to its installed documentation stored in
`inst/pkgdown_docs/`. **This function is not exported for use in scripts
or packages.**
