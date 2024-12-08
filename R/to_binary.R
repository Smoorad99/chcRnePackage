#' Convert Yes/No variables to binary
#'
#' This function converts all "String"/"NA" or "Yes/"No" responses in the selected columns to
#' binary (1/0) where the strings are replaced by 1s and the NAs are replaced by 0s.
#'
#' @param data A dataframe containing the variables to be converted.
#' @param these.cols A prefix used to select all columns with the prefix or the columns specified like you would using `dplyr::select()`
#' @param prefix A logical argument that indicates whether or not you are using a prefix to select columns. This argument defaults to FALSE
#' i.e. assumes your not using a prefix unless you tell it otherwise.
#' @param yesno A logical argument that indicates the values of the the columns you are selecting. If TRUE you are using `to_binary`
#' on columns with values of Yes/No. If FALSE, you are indicating the column values are string/NA.
#'
#' @return The original dataframe with specified variables converted
#' to binary.
#'
#' @export
#'
#' @examples
#' # Convert "Yes"/"No" responses in columns starting with "q14" to 1/0
#' df_converted <- to_binary(data = bns2_pkg_data,
#'                           these.cols = "q14_",
#'                           prefix = TRUE, yesno = TRUE)
#'
#' # View the converted dataframe side-by-side
#' old <- bns2_pkg_data |> dplyr::select(q14_1, q14_4)
#' new <- df_converted |> dplyr::select(q14_1, q14_4)
#' cbind(old, new) |> head(10)
#'
#'
#' # Selecting columns by column name
#' df_converted <- to_binary(data = bns2_pkg_data,
#'                           these.cols = c(q14_5, q14_6),
#'                           prefix = FALSE, yesno = TRUE)
#'
#' # View
#' old <- bns2_pkg_data |> dplyr::select(q14_5, q14_6)
#' new <- df_converted |> dplyr::select(q14_5, q14_6)
#' cbind(old, new) |> head(10)

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
  if (!prefix & yesno) {
    data <- data |> mutate(across({{these.cols}}, ~ifelse(.x == "Yes", 1, ifelse(.x == "No", 0, NA))))
  }
  return(data)
}

## Testing ----
# data <- bns2_pkg_data
# these.cols <- "q14_"

# to_binary(data = bns2_pkg_data, these.cols = "q14_", prefix = TRUE, yesno = FALSE)

# V3
# to_binary2 <- function(data, these.cols, value) {
#   data |> mutate(across({{these.cols}},  ~ifelse(.x == value, 1, ifelse(.x == "NA", NA, 0)))) #NA part of this is WHACK
# }

# a <- to_binary2(data = bns2_pkg_data, these.cols = c(q14_1, q14_4), value = "No")

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
