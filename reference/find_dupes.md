# Finding dupes in pre/post data

Finding dupes in pre/post data

## Usage

``` r
find_dupes(data, vars)
```

## Arguments

- data:

  A data frame containing at least one key ID variable used to identify
  any duplicates

- vars:

  The ID variable in quotes. If more than one variable is needed to
  identify unique records, pass a comma separated character vector e.g.
  \`c("a", "b")\`

## Value

A data set containing the ID variables and number of copies found

## Examples

``` r
suppressMessages(library(dplyr))
testdata <- datasets::sleep %>% rbind(c(.4, 1, 1)) %>% filter(extra != 3.7) # for example purposes
find_dupes(testdata, "ID")
#> # A tibble: 10 × 2
#>    ID        n
#>    <fct> <int>
#>  1 1         3
#>  2 2         2
#>  3 3         2
#>  4 4         2
#>  5 5         2
#>  6 6         2
#>  7 7         1
#>  8 8         2
#>  9 9         2
#> 10 10        2

# For more than one key variable
find_dupes(testdata, c("ID", "group"))
#> # A tibble: 19 × 3
#>    ID    group     n
#>    <fct> <fct> <int>
#>  1 1     1         2
#>  2 1     2         1
#>  3 2     1         1
#>  4 2     2         1
#>  5 3     1         1
#>  6 3     2         1
#>  7 4     1         1
#>  8 4     2         1
#>  9 5     1         1
#> 10 5     2         1
#> 11 6     1         1
#> 12 6     2         1
#> 13 7     2         1
#> 14 8     1         1
#> 15 8     2         1
#> 16 9     1         1
#> 17 9     2         1
#> 18 10    1         1
#> 19 10    2         1
```
