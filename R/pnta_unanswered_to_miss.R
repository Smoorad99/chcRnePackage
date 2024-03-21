
# PNTA to MISS ----
#' @title PNTA to NA
#' @description
#' This function sets all options (vars) in a select all that apply question to NA when the "Prefer not to answer" option was selected
#'
#' @param data The data frame of interest.
#' @param prefix The prefix used to identify the relevant columns.
#' @param pnta The variable that contains the "Prefer not to answer" option.
#'
#' @return A modified data frame with NA assigned to cells in specified columns for rows with PNTA responses.
#' @export
#'
#' @examples pnta.unanswered.to.miss(data = bns2_pkg_data,
#'                                   prefix = "q14_1",
#'                                   pnta = bns2_pkg_data$q14_27)


pnta.unanswered.to.miss <- function(data, prefix, pnta){
  these.cols <- grepl(prefix , colnames(data)) # get all relevant columns
  n.answer <- rowSums(data[,these.cols])       # count number of responses per row
  n.answer <- replace(n.answer, pnta == "Prefer not to answer", 0)  # if prefer not to answer (PNTA) is marked, set # answers to 0
  data[n.answer == 0, these.cols] <- NA         # if #answers is 0, set all to NA missing.
  return(data)
}




# set up the function
# remove.na.levels <- function(x){
#   levels(x)[which(is.na(levels(x)))] <- NA
#   return(x)
# }
# list out all variable names with this problem and apply function
# cols.with.na.lvls <- pisaitems |> select(where(is.ordered)) |> names()
# pisaitems <- pisaitems |> mutate(across(all_of(cols.with.na.lvls), ~remove.na.levels(.x)))


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
