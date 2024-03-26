


## Get percent for variable for given value (ex: Housing - Sleeping Places)
get_perct <- function(x, value) {
  paste0(sum(x==value, na.rm=TRUE), "/", sum(!is.na(x)),
         " (", percent(mean(x==value, na.rm = TRUE), accuracy=.1), ")")
}


get_perct(data[[question]], values[idx])
