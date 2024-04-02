


## Get percent for variable for given value (ex: Housing - Sleeping Places)
get_perct <- function(x, value) {
  paste0(sum(x==value, na.rm=TRUE), "/", sum(!is.na(x)),
         " (", formattable::percent(mean(x==value, na.rm = TRUE), digits = 1), ")")
}


get_perct(bns2_pkg_data$q14_17, "Yes")
