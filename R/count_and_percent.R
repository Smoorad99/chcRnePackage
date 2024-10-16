## Get the count and percent for n categories
#' Creates a string with count and percent
#' @description
#' This function calculates counts and percentages for specified categories within a variable
#' then returns the total count and total percent of those categories relative to the
#' variable they reside in.
#'
#' @param df The data frame of interest.
#' @param var A variable for which the counts and percents are calculated.
#' @param values One or more categories of `var` to get the counts and calculate the percentages. If left blank, the function
#' will calculate the count and percent for the category with highest count.
#' @param format1 Allows for two different formats of the count and percent. Defaults to `TRUE` which outputs the
#' the count then the percent in parentheses "count (percent)". If `format1` is set to `FALSE` the function outputs
#' both the count and percent in parentheses "(n=count, percent)".
#' @return A string including the total count and percentage of the
#' categories in the input variable.
#' @export
#'
#' @examples
#' count_and_percent(df = bns2_pkg_data,
#'                   var = q13,
#'                   values = c("Less than high school", "Some college"))
#'
#' # Excludingthe`values` argument defaults to the level of variable with most rows
#' bns2_pkg_data |> count_and_percent(var = q13)
#'
#' @import dplyr
#'
count_and_percent <- function(df, var, values = NULL, format1 = TRUE) {
  col <- df |>
    dplyr::select({{var}})
  if (is.null(values)) {
    values <- names(which.max(table(col))) # Getting the category with the most responses when values are not provided (setting up default)
  }
  counts <- sum(col[[1]] %in% values, na.rm = TRUE) # Getting counts of the number of occurrences of values in var
  total <- sum(!is.na(col)) # Getting count of non-NA rows in var
  percent <- formattable::percent(counts/total, digits = 1) # Grabbing the percent and saving it
  if (format1) return(paste0(counts, " (", percent, ")"))
  if (!format1) return(paste0("(n=", counts, ", ", percent, ")"))
}

# Testing

# library(chcRne)
# df <- bns2_pkg_data %>% mutate(`Exp Question` = q13)
# var <- "Exp Question"
# values <- c("Less than high school", "Some college")
# # var <- "q13"
# sum(col == values, na.rm = TRUE)

## Code to implement in the function
# stopifnotcolumn <- function(data, string) {
#   if (is.na(match(string, colnames(data)))) {
#     stop(string, " was not found in your data frame.")
#   }
#   return(invisible(TRUE))
# }

## Prior attempt
# count_and_percent <- function(df, var, values = NULL, format1 = TRUE) {
#   col <- df |>
#     dplyr::select({{var}})
#   if (is.null(values)) {
#     values <- names(which.max(table(col))) # Getting the category with the most responses when values are not provided (setting up default)
#   }
#   counts <- col |>
#     dplyr::filter({{var}} %in% {{values}}) |>
#     nrow() # Getting counts of the number of occurrences of values in var
#   total <- df |>
#     dplyr::filter(!is.na({{var}})) |>
#     nrow() # Getting count of non-NA rows in var
#   percent <- formattable::percent(counts/total, digits = 1) # Grabbing the percent and saving it
#   if (format1) return(paste0(counts, " (", percent, ")"))
#   if (!format1) return(paste0("(n=", counts, ", ", percent, ")"))
# }
