# Number and percent of non-NA entries in a column

This function calculates and returns the number and percentage of non-NA
entries in a column of a dataframe.

## Usage

``` r
print_n_reporting(data, x)
```

## Arguments

- data:

  A dataframe containing the dataset to be analyzed.

- x:

  The name of the column of interest.

## Value

A string formatted as "(n=X, Y of Z reporting)", where X is the number
of non-NA entries in the specified column, Y is the percentage of non-NA
entries out of the total number of rows in the dataframe, and Z is the
total number of rows in the dataframe.

## Examples

``` r
print_n_reporting(bns2_pkg_data, "q14_20")
#> [1] "(n=46, 92.0% of 50 reporting)"
```
