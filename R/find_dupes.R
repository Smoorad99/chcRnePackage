library(dplyr)
data <- datasets::sleep %>% rbind(c(.4, 1, 1)) %>% filter(extra != 3.7)

find_dupes <- function (data, vars) { # Finding IDs with no matches
  count <- data |> group_by(across({{vars}})) %>%
    tally() |> ungroup()
}




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
#
#   list(MultipleDupes = mult.dupes,
#        Matched = matched,
#        MissingResponse = missing.response)
# }
#
# a <- find_dupes(data, "ID")
#
# a$MultipleDupes
# a$Matched
# a$MissingResponse
#
# b <- find_dupes(data, c("ID", "group"))

