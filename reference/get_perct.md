# Calculate the percentage of occurrences for a value in a column

This function calculates the percentage of a value within a column,
excluding NA values. It returns the count of the specific value, the
total count of non-NA values, and the percentage of the specific value
out of all the non-NA values.

## Usage

``` r
get_perct(x, value)
```

## Arguments

- x:

  A number or character that contains the value of interest.

- value:

  The specific value to search for in the column \`x\`.

## Value

A string that provides the count of the specific value, the total count
of non-NA values, and the percentage of the specific value in the format
of "count/total (percentage)".

## Examples

``` r
get_perct(bns2_pkg_data$q14_9, "Yes")
#> [1] "10/44 (22.7%)"
```
