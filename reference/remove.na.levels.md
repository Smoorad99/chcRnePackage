# Remove NA levels in factor variables

\`remove.na.levels()\` processes a factor variable that includes NA as a
level, removing the level while preserving the NA responses.

## Usage

``` r
remove.na.levels(x)
```

## Arguments

- x:

  A factor variable containing NA as a level.

## Value

The same factor variable with NA levels explicitly marked as NA.

## Examples

``` r
# As seen in the table below, this factor variable has `NA` as a level.

table(bns2_pkg_data$q13.na)
#> 
#>         Associate's degree High school diploma or GED 
#>                          3                         12 
#>      Less than high school              Other/Unknown 
#>                         25                          2 
#>               Some college                       <NA> 
#>                          7                          1 

# Applying `remove.na.levels` TO remove the `NA` level.

remove.na.levels(bns2_pkg_data$q13.na) |>
  table()
#> 
#>         Associate's degree High school diploma or GED 
#>                          3                         12 
#>      Less than high school              Other/Unknown 
#>                         25                          2 
#>               Some college 
#>                          7 

```
