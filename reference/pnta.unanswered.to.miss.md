# PNTA to NA

This function sets all options (vars) in a select all that apply
question to NA when the "Prefer not to answer" option was selected

## Usage

``` r
pnta.unanswered.to.miss(data, these.cols, pnta, prefix = TRUE)
```

## Arguments

- data:

  The data frame of interest.

- these.cols:

  The columns containing the observations we want to convert to NA when
  the rows of the pnta variable are marked. This parameter can be a
  prefix that all the columns of interest contain, or a list of the
  specific columns you want converted.

- pnta:

  The variable that contains the "Prefer not to answer" option.

- prefix:

  If prefix = TRUE you can use a prefix to select columns, if prefix =
  FALSE you must select columns by name. The function defaults to prefix
  = FALSE

## Value

A modified data frame with NA assigned to cells in specified rows where
prefer not to answer was selected.

## Examples

``` r
# Using a prefix
updated_data <- pnta.unanswered.to.miss(data = bns2_pkg_data,
                                  these.cols = "q14_2",
                                  pnta = bns2_pkg_data$q14_30,
                                  prefix = TRUE)
updated_data |> dplyr::select(q14_20:q14_26, q14_30)
#> # A tibble: 50 × 8
#>    q14_20 q14_21 q14_22 q14_23 q14_24 q14_25 q14_26 q14_30
#>     <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>
#>  1      0      0      0      0      0      0      0      0
#>  2      0      0      0      0      0      0      0      0
#>  3      0      0      0      0     NA      1      0      0
#>  4      1      0      0      0      0      1      0      0
#>  5      0      0      0      0      0      0      0      0
#>  6      0      0      0      0      0      0      0     NA
#>  7     NA     NA     NA     NA     NA     NA     NA      1
#>  8     NA     NA     NA     NA     NA     NA     NA      1
#>  9      0      0      0      0      0      0      0      0
#> 10     NA     NA     NA     NA     NA     NA     NA      1
#> # ℹ 40 more rows

# Selecting columns by name
updated_data2 <- pnta.unanswered.to.miss(data = bns2_pkg_data,
                                  these.cols = c("q14_20", "q14_21"),
                                  pnta = bns2_pkg_data$q14_30,
                                  prefix = FALSE)
updated_data2 |> dplyr::select(q14_20:q14_26, q14_30)
#> # A tibble: 50 × 8
#>    q14_20 q14_21 q14_22 q14_23 q14_24 q14_25 q14_26 q14_30
#>     <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>
#>  1      0      0      0      0      0      0      0      0
#>  2      0      0      0      0      0      0      0      0
#>  3      0      0      0      0     NA      1      0      0
#>  4      1      0      0      0      0      1      0      0
#>  5      0      0      0      0      0      0      0      0
#>  6      0      0      0      0      0      0      0     NA
#>  7     NA     NA     NA     NA     NA     NA     NA      1
#>  8     NA     NA      0      0      0      0      0      1
#>  9      0      0      0      0      0      0      0      0
#> 10     NA     NA      0      0      0      0      0      1
#> # ℹ 40 more rows
```
