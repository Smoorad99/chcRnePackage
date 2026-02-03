# Removing NA as a level from multiple variables

``` r
# Load in necessary libraries and set seed
set.seed(2025)
library(chcRne)
library(dplyr)
```

### Applying `remove.na.levels()` to multiple variables

First, lets look at the levels of the different variables within the
data frame `na.as.lvl`.

``` r
# Applying the levels function to all variables in the na.as.lvl data frame
sapply(na.as.lvl, levels) 
#>      Var1       Var2      
#> [1,] "Disagree" "Disagree"
#> [2,] "Agree"    "Agree"   
#> [3,] NA         NA
```

As we can see in the above output, both Var1 and Var2 have `NA` as a
level. Now we apply the `remove.na.levels` to Var1 and Var2.

``` r
# List out all variable names of ordered factors
cols.with.na.lvls <- na.as.lvl %>% select(Var1, Var2) %>% names()

# Apply function
na.not.as.lvl <- na.as.lvl |>  mutate(across(all_of(cols.with.na.lvls), ~remove.na.levels(.x)))
```

Now that we have applied the function to the variables of interest, lets
check and make sure NA is no longer a level in Var1 and Var2.

``` r
sapply(na.not.as.lvl, levels)
#>      Var1       Var2      
#> [1,] "Disagree" "Disagree"
#> [2,] "Agree"    "Agree"
```

Success! NA is no longer a level in Var1 and Var2.
