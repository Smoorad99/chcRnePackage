#' This is data included in the chcRne package
#'
#' @name bns2_pkg_data
#' @docType data
#' @author CHC
#' @keywords dataset
#' @source {Data created in the project for function examples}
#' @examples bns2_pkg_data
"bns2_pkg_data"


#' California counties
#'
#' A character vector of all 58 counties in California.
#'
#' @format A character vector of length 58.
#' @keywords datasets
"ca_counties"

#' California public higher education campuses
#'
#' A dataset of public higher education campuses in California, including
#' University of California (UC), California State University (CSU), and
#' California Community Colleges (CCC).
#'
#' @format A tibble with one row per campus and the following columns:
#' \describe{
#'   \item{campus_full}{Character string giving the campuses full name}
#'   \item{campus_short}{Character string giving the campuses short name}
#'   \item{sector}{Character string indicating the sector: \code{"UC"}, \code{"CSU"}, or \code{"CCC"}}
#' }
#'
#' @details
#' Campus names reflect commonly used public-facing names. The dataset is
#' intended for filtering, matching, and categorizing institutions by sector.
#'
#' @keywords datasets
"campuses"


#' Unhelpful feedback
#'
#' A vector of free-text responses that don't offer much information.
#'
#' @format A character vector.
#'
#' @details
#' This vector includes variations in casing, punctuation, spelling,
#' and phrasing (e.g., \code{"no"}, \code{"N/A"}, \code{"none"}, \code{"Nope"},
#' \code{"Thank you"}, numeric entries, and similar responses).
#'
#' The vector is intended for use in filtering or normalizing free-text
#' response fields.
#'
#' @keywords datasets
"toss_feedback"



#' CalFresh spelling variants
#'
#' A character vector of common spelling, casing, and formatting variants
#' used to refer to the CalFresh program in free-text data.
#'
#' @format A character vector.
#'
#' @details
#' This dataset is intended for use in identifying or matching references
#' to CalFresh in survey responses.
#'
#' @keywords datasets
"calfresh_spellings"
