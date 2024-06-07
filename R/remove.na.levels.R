#' Remove NA levels in factor variables
#'
#' `remove.na.levels()` processes a factor variable that includes NA as a level,
#' removing the level while preserving the NA responses.
#'
#' @param x A factor variable containing NA as a level.
#'
#' @return The same factor variable with NA levels explicitly marked as NA.
#'
#' @examples
#' # As seen in the table below, this factor variable has `NA` as a level.
#'
#' table(bns2_pkg_data$q13.na)
#'
#' # Applying `remove.na.levels` TO remove the `NA` level.
#'
#' remove.na.levels(bns2_pkg_data$q13.na) |>
#'   table()
#'
#' # We can use the `across` function from `dplyr` to apply this function to multiple variables in of fell swoop.
#'
#' @export
remove.na.levels <- function(x){
  levels(x)[which(is.na(levels(x)))] <- NA
  return(x)
}
# # list out all variable names with this problem and apply function

# example using dplyr::across to show how to apply function across multiple levels
