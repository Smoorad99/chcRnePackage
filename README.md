
<img src="man/figures/hex.png" style="width: 20%; float: left;" alt="chcRne logo">

<br/>

# chcRne

## Overview and Installation

The chcRne package was developed to organize functions, useful code
snippets, and other information relevant to the Research and Evaluation
team at the Center for Healthy Communities.

    # Run the following two lines of code to install chcRne
    install.packages("devtools") 
    devtools::install_github("Smoorad99/chcRnePackage")

## Examples

The following sections serve as a walk through to help users see how the
chcRne functions can be used when cleaning data, making figures and
tables, and reporting on those figures and tables.

### Data Management

Functions in this section are used for data management.

- We are using `yesno_to_binary` to change q14_1 - q14_10 from yes/no to
  1/0.

``` r
library(chcRne)
library(dplyr)

data <- bns2_pkg_data %>% select(q13, q14_1:q14_10)

df_converted <- yesno_to_binary(data, "q14_")
# View the converted dataframe side-by-side
old <- bns2_pkg_data |> dplyr::select(q14_1, q14_4)
new <- df_converted |> dplyr::select(q14_1, q14_4)
cbind(old, new) %>% head(10)
```

    ##    q14_1 q14_4 q14_1 q14_4
    ## 1     No    No     0     0
    ## 2    Yes   Yes     1     1
    ## 3   <NA>  <NA>    NA    NA
    ## 4    Yes    No     1     0
    ## 5     No   Yes     0     1
    ## 6    Yes    No     1     0
    ## 7    Yes   Yes     1     1
    ## 8    Yes   Yes     1     1
    ## 9     No   Yes     0     1
    ## 10   Yes   Yes     1     1

- Each column of our mark all that apply question is now 1/0, which
  allows us to use `pnta.unanswered.to.miss()` to set all columns in the
  select all that apply question to NA when the “Prefer not to answer”
  option was selected.

``` r
df_unanswered_to_miss <- pnta.unanswered.to.miss(data = df_converted,
                                  prefix = "q14_",
                                  pnta = bns2_pkg_data$q14_30)
new <- df_unanswered_to_miss %>%  select(q14_3:q14_5, q14_30)
new$q14_30 <- df_converted$q14_30
new %>% head(10)
```

    ## # A tibble: 10 × 4
    ##    q14_3 q14_4 q14_5 q14_30
    ##    <dbl> <dbl> <dbl>  <dbl>
    ##  1    NA    NA    NA      1
    ##  2     0     1     0      0
    ##  3    NA    NA    NA      0
    ##  4     0     0     0      0
    ##  5     0     1     0      0
    ##  6     0     0     0     NA
    ##  7     0     1     0      0
    ##  8     0     1     0      0
    ##  9    NA    NA    NA      1
    ## 10    NA    NA    NA      1

<br/>

### Tables

Functions in this section are for the creation tables the R&E team
frequently uses.

- Now that our select all that apply question is clean, we can use a
  `nperc_tbl_MATA()` to create a table illustrating creates a table
  showing the n counts and percentages for each option in a mark all
  that apply question.

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
    ## I am a broke college student. (n = 37) 15 (40.5%)
    ## I live with chefs. (n = 40)             4 (10.0%)
    ## I like cooking. (n = 40)                 3 (7.5%)

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

    ## # A tibble: 6 × 2
    ##   `Level of Education`       `Yes %`   
    ##   <chr>                      <chr>     
    ## 1 Less than high school      28 (57.1%)
    ## 2 High school diploma or GED 9 (18.4%) 
    ## 3 Some college               8 (16.3%) 
    ## 4 Associate's degree         2 (4.1%)  
    ## 5 Bachelor's degree          1 (2.0%)  
    ## 6 Other/Unknown              1 (2.0%)

<br/>

### Statistics (often used in inline code)

Functions in this section return statistics often used for figure/table
summaries. Many of these functions will often be used in inline code.

- `print_n_reporting()` reports the count and percent of non-NA
  responses.

``` r
print_n_reporting(bns2_pkg_data, "q13")
```

    ## [1] "(n=49, 98.0% of 50 reporting)"

`count_and_percent()` returns a string that includes the total count and
percentage of the categories in the input variable.

``` r
# Getting the count and percent of respondents reporting some college or a bachelors degree.
count_and_percent(bns2_pkg_data$q13, "Some college", "Bachelor's degree")
```

    ## [1] "9 (18.4%)"
