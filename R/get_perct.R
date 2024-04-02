#' Calculate the Percentage of Occurrences for a Value in a Column
#'
#' This function calculates the percentage of a value within a column,
#' excluding NA values. It returns a string summarizing the count of the specific value,
#' the total count of non-NA values, and the percentage of the specific value among
#' non-NA values.
#'
#' @param x A numeric or character vector that contains the value of interest.
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
