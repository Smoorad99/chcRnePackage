#' Convert Yes/No variables to binary
#'
#' This function converts all "String"/"NA" responses in the selected columns to
#' binary (1/0) where a replaces the strings and a 0 replaces the NAs.
#'
#' @param data A dataframe containing the variables to be converted.
#' @param these.cols A prefix used to select all columns with the prefix or the columns specified like you would using dplyr::select()
#' @param prefix A logical argument that indicates whether or not you are using a prefix to select columns. This argument defaults to false
#' i.e. assumes your not using a prefix unless you tell it otherwise.
#' @param yesno A logical argument that indicates the values of the the columns you are selecting. If TRUE you are using to_binary
#' on columns with values of Yes/No. If FALSE, you are indicating the column values are string/NA.
#'
#' @return The original dataframe with specified variables converted
#' to binary.
#'
#' @export
#'
#' @examples
#' # Convert "Yes"/"No" responses in columns starting with "q14" to 1/0
#' df_converted <- to_binary(data = bns2_pkg_data, these.cols = "q14_", prefix = TRUE, yesno = TRUE)
#'
#' # View the converted dataframe side-by-side
#' old <- bns2_pkg_data |> dplyr::select(q14_1, q14_4)
#' new <- df_converted |> dplyr::select(q14_1, q14_4)
#' cbind(old, new)
#'

to_binary <- function(data, these.cols, prefix = FALSE, yesno = FALSE) {
  if (prefix & !yesno) {
    data <- data |> mutate(across(starts_with({{these.cols}}),  ~ifelse(is.na(.x), 0, 1)))
  }
  if (!prefix & !yesno) {
    data <- data |> mutate(across({{these.cols}},  ~ifelse(is.na(.x), 0, 1)))
  }
  if (prefix & yesno) {
    data <- data |> mutate(across(starts_with({{these.cols}}), ~ifelse(.x == "Yes", 1, ifelse(.x == "No", 0, NA))))
  }
  if (!prefiX & yesno) {
    data <- data |> mutate(across({{these.cols}}, ~ifelse(.x == "Yes", 1, ifelse(.x == "No", 0, NA))))
  }
  return(data)
}

## Testing ----
# data <- bns2_pkg_data
# these.cols <- "q14_"

# to_binary(data = bns2_pkg_data, these.cols = "q14_", prefix = TRUE, yesno = FALSE)

## Attempt 1 ----
# yesno_to_binary <- function(data, these.cols, prefix = TRUE) {
#   if (prefix) {
#     these.cols <- grepl(these.cols, names(data)) # Identify columns matching the prefix
#   }
#   data[these.cols] <- lapply(data[these.cols], function(x) {
#     x <- factor(x, levels = c("No", "Yes"))
#     ifelse(!is.na(x), as.numeric(x) - 1, NA) # Convert to numeric and subtract 1 to get 0/1 binary values
#   })
#
#   return(data)
# }
