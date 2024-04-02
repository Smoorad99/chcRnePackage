#' Remove NA Levels in Ordered Factors
#'
#'
#' @param x A factor variable containing
#'
#' @return The same factor variable with NA levels explicitly marked as `NA`.
#'
#' @examples
#' # Given a factor with NA as one of its levels
#'
#' @export
remove.na.levels <- function(x){
  levels(x)[which(is.na(levels(x)))] <- NA
  return(x)
}
# # list out all variable names with this problem and apply function

# example using dplyr::across to show how to apply function across multiple levels
