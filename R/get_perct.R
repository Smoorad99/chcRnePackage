#' Calculate the percentage of occurrences for a value in a column
#'
#' This function calculates the percentage of a value within a column,
#' excluding NA values. It returns the count of the specific value,
#' the total count of non-NA values, and the percentage of the specific value out of all the
#' non-NA values.
#'
#' @param x A number or character that contains the value of interest.
#' @param value The specific value to search for in the column `x`.
#'
#' @return A string that provides the count of the specific value, the total count
#' of non-NA values, and the percentage of the specific value in the format of "count/total (percentage%)".
#'
#' @examples
#' get_perct(bns2_pkg_data$q14_9, "Yes")
#'
#' @export
#'

## Get percent for variable for given value (ex: Housing - Sleeping Places)
get_perct <- function(x, value) {
  paste0(sum(x==value, na.rm=TRUE), "/", sum(!is.na(x)),
         " (", formattable::percent(mean(x==value, na.rm = TRUE), digits = 1), ")")
}
