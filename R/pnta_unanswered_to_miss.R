##### Creating a data set to use for functions that require data
set.seed(2024)

## Question for select all that apply: Why don't you eat out?
# Generating data for 20 respondents for 3 questions

# id <- 1:20
Q1 <- sample(c("I like cooking", NA), 30, replace = TRUE)
Q2 <- sample(c("I am a broke college student", NA), 30, replace = TRUE)
Q3 <- sample(c("Prefer not to answer", NA), 30, prob=c(.3, .7), replace = TRUE)

# Creating the data frame
exp.data <- data.frame(Q1, Q2, Q3)

exp.data <- exp.data |>
  dplyr::mutate(
    no_goingout_cooking = as.numeric(grepl("I like cooking", Q1)),
    no_goingout_broke = as.numeric(grepl("I am a broke college student", Q2))) |>
  dplyr::select(-c(Q1, Q2))


# PNTA to MISS ----
#' @title PNTA to MISS
#' @description
#' Sets all options (vars) in select all that apply questions to NA when the "Prefer not to answer" option was selected
#'
#' @param prefix A commonality/string shared by all sub-questions in the select all that applies question.
#' @param data The data frame of interest
#' @param pnta The variable that has the "Prefer not to answer" option
#'
#' @return A new data frame
#' @export
#'
#' @examples pnta.unanswered.to.miss(data = exp.data,
#'                                   prefix = "no_going",
#'                                   pnta = exp.data$Q3)


pnta.unanswered.to.miss <- function(data, prefix, pnta){
  these.cols <- grepl(prefix , colnames(data)) # get all relevant columns
  n.answer <- rowSums(data[,these.cols])       # count number of responses per row
  n.answer <- replace(n.answer, pnta == "Prefer not to answer", 0)  # if prefer not to answer (PNTA) is marked, set # answers to 0
  data[n.answer == 0, these.cols] <- NA         # if #answers is 0, set all to NA missing.
  return(data)
}

# pnta.unanswered.to.miss(data = exp.data, prefix = "no_going", pnta = Q3)




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
