

#' Function for plot_frq y.offset
#'
#' The purpose of `y.off` is to ensure the count and percent remains "on screen" regardless of number of rows when using `plot_frq()`.
#'
#' @param datavar Data frame $ variable
#'
#' @return a number that is equal 1/100th of the max category in the selected variable
#' @importFrom sjPlot plot_frq
#' @export
#'
#' @examples
#' df <- bns2_pkg_data |> head(15)
#'
#' # Without adjusting the y.offset
#' sjPlot::plot_frq(df$q13)
#'
#' # Using y.off function
#' sjPlot::plot_frq(df$q13, y.offset = y.off(bns2_pkg_data$q13))


y.off <- function(datavar) {
  max(table(datavar))*.01
}

## Testing ----
# library(sjPlot)
# datavar <- bns2_pkg_data$q13
#
# plot_frq(bns2_pkg_data$q14_3, y.offset = y.off(bns2_pkg_data$q14_3))

# data("mtcars")
# plot_frq(ChickWeight$Diet, y.offset = y.off(ChickWeight$Diet))
#

## Attempt 1 ----

# y.off <- function(datavar) {
#   rows <- max(table(datavar)) # Get the category with the most responses
#   if (rows < 6) {
#     return(.02)
#   }
#   else if (rows > 6 & rows <= 20) {
#     return(.1)
#   }
#   else if (rows > 20 & rows <= 50) {
#     return(.3)
#   }
#   else if (rows > 50 & rows <= 100) {
#     return(.5)
#   }
#   else if (rows > 100) {
#     return(1)
#   }
# }


