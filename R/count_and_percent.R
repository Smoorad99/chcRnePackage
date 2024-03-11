

## Get the count and percent for n (...) categories
#' Creates a string with count and percent
#' @description
#' This function calculates counts and percentages for specified categories within a variable
#' then returns a string including the total count and total percent of those categories relative to the
#' variable they reside in.
#'
#' @param var A variable for which the counts and percents are calculated.
#' @param ... One or more categories of `var` to get the counts and calculate the percentages.
#'
#' @return A string including the total count and percentage of the
#' categories in the input variable.
#' @export
#'
#' @examples
#'count_and_percent(var = bns2_pkg_data$q14_1, "Yes")
#'
count_and_percent <-  function(var, ...) {  # Takes in a variable and an ellipsis ('...') which represents multiple categories
  values <- list(...)  # Stores the values of each of the selected categories as a list
  counts <- lapply(values, function(val) sum(var == val, na.rm = TRUE))  # Applies the function to each element of the list
  total <- sum(!is.na(var)) # Calculates the total count of non-missing values
  percent <- sapply(counts, function(count) formattable::percent(count/total, digits = 5))
  total_count <- sum(unlist(counts))
  total_percent <- formattable::percent(total_count/total, digits = 1)
  paste0(total_count, " (", total_percent, ")")
}
