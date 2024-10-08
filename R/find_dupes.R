
#' Finding dupes in pre/post data
#'
#' @param data A data frame containing at least one key ID variable used to identify any duplicates
#' @param vars The ID variable in quotes. If more than one variable is needed to identify unique records, pass a comma separated character vector e.g. `c("a", "b")`
#'
#' @return A data set containing the ID variables and number of copies found
#' @export
#' @import dplyr
#'
#' @examples
#' suppressMessages(library(dplyr))
#' testdata <- datasets::sleep %>% rbind(c(.4, 1, 1)) %>% filter(extra != 3.7) # for example purposes
#' find_dupes(testdata, "ID")
#' # For more than one key variable
#' find_dupes(testdata, c("ID", "group"))

find_dupes <- function (data, vars) { # Finding IDs with no matches
  data |> group_by(across({{vars}})) %>%
    tally() |> ungroup()
}



## NO -----
#
# find_dupes <- function (data, vars) { # Finding IDs with no matches
#   count <- data %>% group_by(across({{vars}})) %>%
#     tally() %>% ungroup() # Getting number of rows for each ID
#   if(length(vars) == 1 ) {
#     mult.dupes <- count %>% filter(n > 2) # If you only group by ID
#     matched <- count %>% filter(n == 2)
#     missing.response <- count %>% filter(n == 1)
#   }
#   else if(length(vars == 2)) {
#     mult.dupes <- count %>% filter(n > 1) # If you group by ID and (pre/post)
#     #matched <- count %>% group_by({{vars[1]}}) %>%
#   }
#   mult.dupes
# }
#
# a <- find_dupes(data, "ID")
#
# a$MultipleDupes
# a$Matched
# a$MissingResponse
#
# b <- find_dupes(data, c("ID", "group"))
# -----

# find_dupes(data, "ID")
