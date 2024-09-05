
<img src="man/figures/hex.png" style="width: 18%; float: left;" alt="chcRne logo">

<hr style="height:40px; visibility:hidden;" />

# chcRne

## Overview and Installation

The chcRne package was developed to organize functions, useful code
snippets, and other information relevant to the Research and Evaluation
team at the Center for Healthy Communities.

    # Run the following two lines of code to install chcRne
    install.packages("devtools") 
    devtools::install_github("Smoorad99/chcRnePackage", dependencies = TRUE)

<!-- ## Examples -->

The following sections serve as a walk through to help users see how the
chcRne functions can be used when cleaning data, making figures and
tables, and reporting on those figures and tables.

### Data Management

Functions in this section are used for data management.

- We are using `to_binary` to change q14_1 - q14_10 from yes/no to 1/0.

``` r
library(chcRne)
library(dplyr)

data <- bns2_pkg_data %>% select(q13, q14_1:q14_10)

# Use function
df_converted <- to_binary(data = data, these.cols = "q14_", prefix = TRUE, yesno = TRUE)

# View the converted dataframe side-by-side to check if the function worked
old <- data |> dplyr::select(q14_1, q14_4)
new <- df_converted |> dplyr::select(q14_1, q14_4)
cbind(old, new) %>% head(10)
```

    ##    q14_1 q14_4 q14_1 q14_4
    ## 1    Yes   Yes     1     1
    ## 2     No   Yes     0     1
    ## 3    Yes   Yes     1     1
    ## 4    Yes   Yes     1     1
    ## 5     No   Yes     0     1
    ## 6     No   Yes     0     1
    ## 7   <NA>  <NA>    NA    NA
    ## 8     No   Yes     0     1
    ## 9     No   Yes     0     1
    ## 10    No   Yes     0     1

<br style="line-height: 10px" />

- Each column of our mark all that apply question is now 1/0, which
  allows us to use `pnta.unanswered.to.miss()` to set all columns in the
  select all that apply question to NA when the “Prefer not to answer”
  option was selected.

``` r
df_unanswered_to_miss <- pnta.unanswered.to.miss(data = df_converted,
                                  these.col = "q14_",
                                  pnta = bns2_pkg_data$q14_30,
                                  prefix = TRUE)
new <- df_unanswered_to_miss %>%  select(q14_3:q14_5, q14_30)
new$q14_30 <- df_converted$q14_30
new %>% head(10)
```

    ## # A tibble: 10 × 4
    ##    q14_3 q14_4 q14_5 q14_30
    ##    <dbl> <dbl> <dbl>  <dbl>
    ##  1     0     1     1      0
    ##  2     0     1     0      0
    ##  3     0     1     0      0
    ##  4     0     1     0      0
    ##  5     0     1     1      0
    ##  6     0     1     0     NA
    ##  7    NA    NA    NA      1
    ##  8    NA    NA    NA      1
    ##  9     0     1     0      0
    ## 10    NA    NA    NA      1

<br/>

### Tables

Functions in this section are for the creation tables the R&E team
frequently uses.

- Now that our select all that apply question is clean, we can use
  `nperc_tbl_MATA()` to create a table showing the n counts and
  percentages for each option in a mark all that apply question.

``` r
cols <- c("q14_3", "q14_4", "q14_5")
rnames <- c("I like cooking", "I am a broke college student", "I live with chefs")

# Create table that reports n count and percent for a mark all that apply question
mark_all_that_apply_tbl <- nperc_tbl_MATA(df = df_unanswered_to_miss,
               vars = cols,
               value = "1",
               row.names = rnames,
               punc = ".")
mark_all_that_apply_tbl
```

    ##                                           Yes (%)
    ## I am a broke college student. (n = 38) 27 (71.1%)
    ## I live with chefs. (n = 39)             7 (17.9%)
    ## I like cooking. (n = 39)                 3 (7.7%)

<br style="line-height: 10px" />

- If we were working with a single categorical variable we could use
  `question_table` to create a table with counts and percentages.

``` r
# kbl_styling = FALSE indicating that we do not want any styling for the table
question_tbl <- question_table(data = bns2_pkg_data, 
                               x = 'q13', 
                               cnames = c("Level of Education", "Yes %"), 
                               kbl_styling = FALSE)

question_tbl
```

    ## # A tibble: 5 × 2
    ##   `Level of Education`       `Yes %`   
    ##   <chr>                      <chr>     
    ## 1 Less than high school      25 (51.0%)
    ## 2 High school diploma or GED 12 (24.5%)
    ## 3 Some college               7 (14.3%) 
    ## 4 Associate's degree         3 (6.1%)  
    ## 5 Other/Unknown              2 (4.1%)

<br/>

### Statistics (often used in inline code)

Functions in this section return statistics often used for figure/table
summaries. Many of these functions will be used in inline code. For
these inline code examples we will be looking at `q13`, which captures
the level of education reported by participants.

``` r
table(bns2_pkg_data$q13, useNA = "always")
```

    ## 
    ##         Associate's degree High school diploma or GED 
    ##                          3                         12 
    ##      Less than high school              Other/Unknown 
    ##                         25                          2 
    ##               Some college                       <NA> 
    ##                          7                          1

<br style="line-height: 10px" />

**`print_n_reporting()`** returns the count and percent of non-NA
responses. In the table above we can see that of the 50 responses, 49
are non-NA values.

``` r
print_n_reporting(bns2_pkg_data, "q13")
```

    ## [1] "(n=49, 98.0% of 50 reporting)"

<br style="line-height: 10px" />

**`count_and_percent()`** returns a string that includes the total count
and percent of respondents that selected a category specified in the
function. If you include one category, the function will return the
count and percent of respondents that selected that category relative to
all non-NA responses.

``` r
# Getting the count and percent of respondents reporting a level of education High school diploma or GED.
count_and_percent(df = bns2_pkg_data, var = q13, "High school diploma or GED")
```

    ## [1] "12 (24.5%)"

If you include two or more categories in a vector, the function will
return the count and percent of respondents that selected any of the
included categories. In the example below, we are getting the count and
percent of respondents that reported their level of education as “Some
college” OR a “Bachelor’s degree”.

``` r
# We can also exclude the `df` argument and pipe (|>) in the data
bns2_pkg_data |> count_and_percent(var = q13, values = c("Less than high school", "Some college"))
```

    ## [1] "32 (65.3%)"

If you do not specify a category the function will return the count and
percent of the category with the most responses.

``` r
bns2_pkg_data |> count_and_percent(var = q13)
```

    ## [1] "25 (51.0%)"
