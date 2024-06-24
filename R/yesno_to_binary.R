#' Convert Yes/No variables to binary
#'
#' This function takes a dataframe and a prefix to identify specific columns
#' by their names. It converts all "Yes"/"No" responses in these columns to
#' binary numeric values, with "No" as 0 and "Yes" as 1.
#'
#' @param data A dataframe containing the variables to be converted.
#' @param these.cols A prefix used to select columns by name or a list of the exact column names. Selected columns
#' will have "Yes"/"No" values converted to 0/1.
#' @param prefix Whether or not you are using a prefix to select columns. This argument defaults to true
#' i.e. assumes your using a prefix unless you tell it otherwise.
#'
#' @return The original dataframe with specified Yes/No variables converted
#' to binary numeric values.
#'
#' @export
#'
#' @examples
#' # Convert "Yes"/"No" responses in columns starting with "q14" to 0/1
#' df_converted <- yesno_to_binary(data = bns2_pkg_data, these.cols = "q14_", prefix = TRUE)
#'
#' # View the converted dataframe side-by-side
#' old <- bns2_pkg_data |> dplyr::select(q14_1, q14_4)
#' new <- df_converted |> dplyr::select(q14_1, q14_4)
#' cbind(old, new)
#'
yesno_to_binary <- function(data, these.cols, prefix = TRUE) {
  if (prefix) {
    these.cols <- grepl(these.cols, names(data)) # Identify columns matching the prefix
  }
  data[these.cols] <- lapply(data[these.cols], function(x) {
    x <- factor(x, levels = c("No", "Yes"))
    ifelse(!is.na(x), as.numeric(x) - 1, NA) # Convert to numeric and subtract 1 to get 0/1 binary values
  })

  return(data)
}

#########
# Code for testing
#########
# data <- bns2_pkg_data
# prefix <- "q14_"
