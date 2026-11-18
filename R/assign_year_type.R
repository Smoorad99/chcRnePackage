## Assign calendar, state fiscal, or federal fiscal year
#' Assigns a year type based on a date variable
#' @description
#' This function takes a date variable and assigns each date to a calendar year,
#' California state fiscal year, or federal fiscal year.
#'
#' Calendar years run from January through December. California state fiscal years
#' run from July through June, with the year labeled by the ending year. Federal
#' fiscal years run from October through September, also labeled by the ending year.
#'
#' The function accepts R date and datetime objects as well as common character
#' date formats. Character dates are interpreted using year-month-day or U.S.
#' month-day-year conventions. Day-month-year character formats are not supported.
#'
#' @param date A date or datetime variable to classify by year type.
#' @param year_type The type of year to assign. Must be one of `"CY"`, `"SFY"`,
#' or `"FFY"`. `"CY"` returns calendar year, `"SFY"` returns California state
#' fiscal year, and `"FFY"` returns federal fiscal year.
#'
#' @return An integer vector containing the assigned year for each value in `date`.
#' Values that cannot be interpreted as dates are returned as `NA`.
#'
#' @export
#'
#' @examples
#' example_data <- data.frame(
#'   date = as.Date(c(
#'     "2025-06-30",
#'     "2025-07-01",
#'     "2025-09-30",
#'     "2025-10-01"
#'   ))
#' )
#'
#' example_data$SFY <- assign_year_type(example_data$date, "SFY")
#' example_data$FFY <- assign_year_type(example_data$date, "FFY")
#'
#' example_data


assign_year_type <- function(date, year_type = c("CY", "SFY", "FFY")) {

  year_type <- match.arg(toupper(year_type), c("CY", "SFY", "FFY"))

  # Convert common date/datetime formats to Date
  if (inherits(date, "Date")) {

    parsed_date <- date

  } else if (inherits(date, c("POSIXct", "POSIXlt"))) {

    parsed_date <- as.Date(date)

  } else {

    parsed_date <- lubridate::parse_date_time(
      as.character(date),
      orders = c(
        "ymd",
        "mdy",
        "ymd HMS",
        "mdy HMS",
        "ymd HM",
        "mdy HM"
      ),
      quiet = TRUE
    ) |>
      as.Date()
  }

  # Warn if any non-missing values could not be interpreted as dates
  failed <- !is.na(date) & is.na(parsed_date)

  if (any(failed)) {
    warning(
      sum(failed),
      " value(s) could not be interpreted as dates and were returned as NA."
    )
  }

  # Assign year type
  if (year_type == "CY") {

    lubridate::year(parsed_date)

  } else if (year_type == "SFY") {

    lubridate::year(parsed_date) +
      ifelse(lubridate::month(parsed_date) >= 7, 1L, 0L)

  } else {

    lubridate::year(parsed_date) +
      ifelse(lubridate::month(parsed_date) >= 10, 1L, 0L)
  }
}
