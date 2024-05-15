
# PNTA to MISS ----
#' @title PNTA to NA
#' @description
#' This function sets all options (vars) in a select all that apply question to NA when the "Prefer not to answer" option was selected
#'
#' @param data The data frame of interest.
#' @param prefix The prefix used to identify the relevant columns.
#' @param pnta The variable that contains the "Prefer not to answer" option.
#'
#' @return A modified data frame with NA assigned to cells in specified rows where prefer not to answer was selected.
#' @export
#'
#' @examples
#' subset <- bns2_pkg_data[c(14:15, 17:18), ]
#'
#' updated_data <- pnta.unanswered.to.miss(data = subset,
#'                                   prefix = "q14_2",
#'                                   pnta = subset$q14_30)
#' updated_data |> dplyr::select(q14_20:q14_26, q14_30)
#'


test.dta <- chcRne::bns2_pkg_data

these.cols <- c("q14_20")

updated_data <- pnta.unanswered.to.miss(data = test.dta,
                                        these.cols = these.cols,
                                        pnta = test.dta$q14_30)

test.dta |> dplyr::select(all_of(these.cols), q14_30)
updated_data |> dplyr::select(all_of(these.cols), q14_30)



pnta.unanswered.to.miss <- function(data, these.cols, pnta){
  # If there exists NAs, sum the non-NA answers in the row (for text/NA data)
  if (anyNA(data[, these.cols])) {
    n.answer <- rowSums(!is.na(data[,these.cols]))
  }
  else {
    n.answer <- rowSums(data[,these.cols])   # count number of response per row
  }
  n.answer <- replace(n.answer, pnta == 1 | pnta == "Prefer not to answer", 0)  # if prefer not to answer (PNTA) is marked, set # answers to 0
  data[n.answer == 0, these.cols] <- NA         # if #answers is 0, set all to NA missing.
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
