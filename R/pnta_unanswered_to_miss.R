
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
#' @examples updated_data <- pnta.unanswered.to.miss(data = bns2_pkg_data,
#'                                   prefix = "q14_2",
#'                                   pnta = bns2_pkg_data$q14_30)
#' updated_data |> dplyr::select(q14_20:q14_26, q14_30)
#'


pnta.unanswered.to.miss <- function(data, prefix, pnta){
  these.cols <- grepl(prefix , colnames(data)) # get all relevant columns
  n.answer <- rowSums(data[,these.cols])       # count number of response per row
  n.answer <- replace(n.answer, pnta == 1, 0)  # if prefer not to answer (PNTA) is marked, set # answers to 0
  data[n.answer == 0, these.cols] <- NA         # if #answers is 0, set all to NA missing.
  return(data)
}


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
