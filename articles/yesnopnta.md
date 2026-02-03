# PNTA unanswered to miss tutorial

``` r
library(chcRne)
library(dplyr)
```

### Purpose

This vignette focuses on the
[`to_binary()`](https://smoorad99.github.io/chcRnePackage/reference/to_binary.md)
and `pnta_unaswered_to_miss()` functions. The purpose of this section is
to help users identify when to use `pnta_unaswered_to_miss()`, how to
get the data in a format the function can use, and finally, how to apply
the function.

### When to use

We use `pnta_unanswered_to_miss()` when working with a select all that
apply question that has a column for prefer not to answer. This is most
commonly a column filled with “Yes” and “No”, “0” and “1”, or “Prefer
not to answer” and “NA”. The issue arises when someone marks the prefer
not to answer option along with at least one other of the options of the
select all that apply question. When someone selects the prefer not to
answer option, we want to mark all other cells of that row in the
columns relevant to the prefer not to answer question as `NA`.

Lets take a look at what this may look like

``` r
data <- bns2_pkg_data %>% select(q14_1:q14_10) %>% mutate(pnta = bns2_pkg_data$q14_30)
data[8:12, 7:10]
#> # A tibble: 5 × 4
#>   q14_8 q14_9 q14_10  pnta
#>   <chr> <chr> <chr>  <dbl>
#> 1 No    Yes   Yes        1
#> 2 No    No    Yes        0
#> 3 No    Yes   Yes        1
#> 4 No    No    Yes        0
#> 5 No    Yes   Yes        0
```

As we can see from the above snippet there are “Yes” and “No” responses
in the same row someone marked prefer not to answer (`pnta == 1`).
Before we can change these rows to `NA` we want the data to be in a 1/0
format because the `pnta_unanswered_to_miss()` function is not
compatible with non-binary data.

### Changing the columns from yes/no to 1/0

``` r
df_converted <- to_binary(data, these.cols = "q14_", prefix = TRUE, yesno = TRUE)
# View the converted dataframe side-by-side
old <- bns2_pkg_data |> dplyr::select(q14_1, q14_4)
new <- df_converted |> dplyr::select(q14_1, q14_4)
cbind(old, new) %>% head(10)
#>    q14_1 q14_4 q14_1 q14_4
#> 1    Yes   Yes     1     1
#> 2     No   Yes     0     1
#> 3    Yes   Yes     1     1
#> 4    Yes   Yes     1     1
#> 5     No   Yes     0     1
#> 6     No   Yes     0     1
#> 7   <NA>  <NA>    NA    NA
#> 8     No   Yes     0     1
#> 9     No   Yes     0     1
#> 10    No   Yes     0     1
```

### Applying the pnta function

Each column of our mark all that apply question is now 1/0, which allows
us to use
[`pnta.unanswered.to.miss()`](https://smoorad99.github.io/chcRnePackage/reference/pnta.unanswered.to.miss.md)
to set all cells of a row in relevant columns of the select all that
apply question to NA when the “Prefer not to answer” option was
selected.

``` r
df_unanswered_to_miss <- pnta.unanswered.to.miss(data = df_converted,
                                  these.col = "q14_",
                                  pnta = df_converted$pnta,
                                  prefix = TRUE)

new <- df_unanswered_to_miss %>%  select(q14_3:q14_5, pnta)
new %>% head(10)
#> # A tibble: 10 × 4
#>    q14_3 q14_4 q14_5  pnta
#>    <dbl> <dbl> <dbl> <dbl>
#>  1     0     1     1     0
#>  2     0     1     0     0
#>  3     0     1     0     0
#>  4     0     1     0     0
#>  5     0     1     1     0
#>  6     0     1     0    NA
#>  7    NA    NA    NA     1
#>  8    NA    NA    NA     1
#>  9     0     1     0     0
#> 10    NA    NA    NA     1
```

Success! All rows where `pnta == 1` are `NA`.
