# Creates a string with count and percent

This function calculates counts and percentages for specified categories
within a variable then returns the total count and total percent of
those categories relative to the variable they reside in.

## Usage

``` r
count_and_percent(df, var, values = NULL, format1 = TRUE)
```

## Arguments

- df:

  The data frame of interest.

- var:

  A variable for which the counts and percents are calculated.

- values:

  One or more categories of \`var\` to get the counts and calculate the
  percentages. If left blank, the function will calculate the count and
  percent for the category with highest count.

- format1:

  Allows for two different formats of the count and percent. Defaults to
  \`TRUE\` which outputs the the count then the percent in parentheses
  "count (percent)". If \`format1\` is set to \`FALSE\` the function
  outputs both the count and percent in parentheses "(n=count,
  percent)".

## Value

A string including the total count and percentage of the categories in
the input variable.

## Examples

``` r
count_and_percent(df = bns2_pkg_data,
                  var = q13,
                  values = c("Less than high school", "Some college"))
#> [1] "32 (65.3%)"

# Excludingthe`values` argument defaults to the level of variable with most rows
bns2_pkg_data |> count_and_percent(var = q13)
#> [1] "25 (51.0%)"

bns2_pkg_data <- bns2_pkg_data |> dplyr::mutate(test = rep_len(1:10, nrow(bns2_pkg_data)))
count_and_percent(df = bns2_pkg_data,
                     var = test,
                     values = c(5:10))
#> [1] "30 (60.0%)"
```
