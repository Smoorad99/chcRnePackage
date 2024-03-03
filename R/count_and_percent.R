

## Get the count and percent for n (...) categories
#' Count and Percent
#'
#' @param var The variable for which the count and percent are calculated.
#' @param ... One or more categories of `var` to count and calculate percentages.
#'
#' @return A string including the total count and percentage of the
#' categories in the input variable.
#' @export
#'
#' @examples
#'count_and_percent(var = exp.data$no_goingout_cooking, "1")
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
