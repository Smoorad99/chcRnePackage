% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/count_and_percent.R
\name{count_and_percent}
\alias{count_and_percent}
\title{Creates a string with count and percent}
\usage{
count_and_percent(df, var, values = NULL, format1 = TRUE)
}
\arguments{
\item{df}{The data frame of interest.}

\item{var}{A variable for which the counts and percents are calculated.}

\item{values}{One or more categories of `var` to get the counts and calculate the percentages. If left blank, the function
will calculate the count and percent for the category with highest count.}

\item{format1}{Allows for two different formats of the count and percent. Defaults to `TRUE` which outputs the
the count then the percent in parentheses "count (percent)". If `format1` is set to `FALSE` the function outputs
both the count and percent in parentheses "(n=count, percent)".}
}
\value{
A string including the total count and percentage of the
categories in the input variable.
}
\description{
This function calculates counts and percentages for specified categories within a variable
then returns the total count and total percent of those categories relative to the
variable they reside in.
}
\examples{
count_and_percent(df = bns2_pkg_data, var = q13, values = c("Less than high school", "Some college"))

# Using a pipe and leaving excluding `values` argument (defaults to the level of var with most rows/responses)
bns2_pkg_data |> count_and_percent(var = q13)

}
