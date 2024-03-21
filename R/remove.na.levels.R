#' Remove NA Levels in Ordered Factors
#'
#' This function explicitly marks NA levels in a factor as `NA`, without removing them.
#' It is useful for cleaning up factors by ensuring that NA levels are properly recognized,
#' especially before conducting further data analysis or modeling.
#'
#' @param x A factor variable containing
#'
#' @return The same factor variable with NA levels explicitly marked as `NA`.
#'         No levels are actually removed from the factor; instead, they are
#'         just marked to ensure correct recognition and handling in R.
#'
#' @examples
#' # Given a factor with NA as one of its levels
#' factor_var <- factor(c("low", "medium", "high", NA),
#'                      levels = c("low", "medium", "high", NA), ordered = TRUE)
#' # Applying remove.na.levels to clean up NA levels
#' cleaned_factor_var <- remove.na.levels(factor_var)
#' levels(cleaned_factor_var)
#'
#' @export
remove.na.levels <- function(x){
  levels(x)[which(is.na(levels(x)))] <- NA
  return(x)
}
# # list out all variable names with this problem and apply function
# cols.with.na.lvls <- pisaitems |> dplyr::select(where(is.ordered)) |> names()
# pisaitems <- pisaitems |> dplyr::mutate(across(all_of(cols.with.na.lvls), ~remove.na.levels(.x)))
