
# PNTA to MISS ----
#' @title PNTA to NA
#' @description
#' This function sets all options (vars) in a select all that apply question to NA when the "Prefer not to answer" option was selected
#'
#' @param data The data frame of interest.
#' @param these.cols The columns containing the observations we want to convert to NA when the rows of the pnta variable are marked.
#' This parameter can be a prefix that all the columns of interest contain, or a list of the specific columns you want converted.
#' @param pnta The variable that contains the "Prefer not to answer" option.
#' @param prefix If prefix = TRUE you can use a prefix to select columns, if prefix = FALSE
#' you must select columns by name. The function defaults to prefix = FALSE
#'
#' @return A modified data frame with NA assigned to cells in specified rows where prefer not to answer was selected.
#' @export
#'
#' @examples
#' # Using a prefix
#'
#' updated_data <- pnta.unanswered.to.miss(data = bns2_pkg_data,
#'                                   these.cols = "q14_2",
#'                                   pnta = bns2_pkg_data$q14_30,
#'                                   prefix = TRUE)
#' updated_data |> dplyr::select(q14_20:q14_26, q14_30)
#'
#' # Selecting columns by name
#' updated_data2 <- pnta.unanswered.to.miss(data = bns2_pkg_data,
#'                                   these.cols = c("q14_20", "q14_21"),
#'                                   pnta = bns2_pkg_data$q14_30,
#'                                   prefix = FALSE)
#' updated_data2 |> dplyr::select(q14_20:q14_26, q14_30)

# test.dta <- chcRne::bns2_pkg_data
#
# these.cols <- c("q14_20", "q14_21")
#
# updated_data <- pnta.unanswered.to.miss(data = test.dta,
#                                         these.cols = these.cols,
#                                         pnta = test.dta$q14_30,
#                                         prefix = FALSE)
#
# test.dta |> dplyr::select(all_of(these.cols), q14_30)
# updated_data |> dplyr::select(all_of(these.cols), q14_30)



pnta.unanswered.to.miss <- function(data, these.cols, pnta, prefix = TRUE){
  # If the user sets prefix to TRUE, get all columns with the prefix in their name.
  if (prefix) {
    these.cols <- grepl(these.cols, names(data))
  }
  # If there are NAs in the these.cols, sum the number of non-NA values in each row of these.cols
  if (anyNA(data[, these.cols])) {
    n.answer <- rowSums(!is.na(data[,these.cols]))
  }
  # If there aren't NAs, sum each row in these.cols
  if (!anyNA(data[, these.cols])) {
    n.answer <- rowSums(data[,these.cols])
  }
  # if prefer not to answer (PNTA) is marked, set # answers to 0
  n.answer <- replace(n.answer, pnta == 1 | pnta == "Prefer not to answer", 0)
  # if #answers is 0, set all to NA missing.
  data[n.answer == 0, these.cols] <- NA
  return(data)
}


# Note: If a row in the `data` for the columns used in above function (i.e q14_20:q14_26) does not have any responses,
# the function breaks


# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'


# pkgdown::build_site()
## builds website

# devtools::document()
## updates documentation

# usethis::use_data(df, overwrite = TRUE)
## Update data
