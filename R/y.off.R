

#' Function for plot_frq y.offset
#'
#' The purpose of `y.off` is to ensure the count and percent remains "on screen" regardless of number of rows when using `plot_frq()`.
#'
#' @param datavar Data frame $ variable
#'
#' @return A `plot_frq` bar chart with counts and percents on screen.
#' @importFrom sjPlot plot_frq
#' @export
#'
#' @examples
#' df <- bns2_pkg_data |> head(15)
#' sjPlot::plot_frq(df$q13)
#' sjPlot::plot_frq(df$q13, y.offset = y.off(bns2_pkg_data$q13))
#'
#'
#'
y.off <- function(datavar) {
  rows <- max(table(datavar)) # Get the category with the most responses
  if (rows < 6) {
    return(.02)
  }
  else if (rows > 6 & rows <= 20) {
    return(.1)
  }
  else if (rows > 20 & rows <= 50) {
    return(.3)
  }
  else if (rows > 50 & rows <= 100) {
    return(.5)
  }
  else if (rows > 100) {
    return(1)
  }
}
