#' Number and percent of non-NA entries in a column
#'
#' This function calculates and returns the number and
#' percentage of non-NA entries in a column of a dataframe.
#'
#' @param data A dataframe containing the dataset to be analyzed.
#' @param x The name of the column of interest.
#'
#' @return A string formatted as "(n=X, Y of Z reporting)", where X is
#' the number of non-NA entries in the specified column, Y is the percentage of
#' non-NA entries out of the total number of rows in the dataframe, and Z is the
#' total number of rows in the dataframe.
#'
#' @examples
#' print_n_reporting(bns2_pkg_data, "q14_20")
#'
#' @export

print_n_reporting <- function(data, x) {
  paste0("(n=",
         sum(!is.na(data[[x]])), ", ",
         formattable::percent(sum(!is.na(data[[x]]))/nrow(data), digits=1), " of ", nrow(data), " reporting)"
  )
}

