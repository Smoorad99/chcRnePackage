
# chcRne

The chcRne package was developed to organize functions, useful code
snippets, and other information relevant to the Research and Evaluation
team at the Center for Healthy Communities.

## How to install:

    install.packages("devtools") 
    devtools::install_github("Smoorad99/chcRnePackage")

## Examples

<br/>

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

- Now that each column of our mark all that apply question is 1/0, we
  are using `pnta.unanswered.to.miss()` to set all columns in the select
  all that apply question to NA when the “Prefer not to answer” option
  was selected.

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

- `nperc_tbl_MATA()` Creates a table showing the n counts and
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
    ## I am a broke college student. (n = 37) 15 (40.5%)
    ## I live with chefs. (n = 40)             4 (10.0%)
    ## I like cooking. (n = 40)                 3 (7.5%)

- `question_table` creates a table with counts and percentages for a
  single categorical variable.

``` r
question_tbl <- question_table(data = bns2_pkg_data, 
               x = 'q13', 
               cnames = c("Level of Education", "Yes %"), 
               kbl_styling = TRUE)
question_tbl
```

<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Level of Education
</th>
<th style="text-align:left;">
Yes %
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Less than high school
</td>
<td style="text-align:left;width: 3.5cm; ">
28 (57.1%)
</td>
</tr>
<tr>
<td style="text-align:left;">
High school diploma or GED
</td>
<td style="text-align:left;width: 3.5cm; ">
9 (18.4%)
</td>
</tr>
<tr>
<td style="text-align:left;">
Some college
</td>
<td style="text-align:left;width: 3.5cm; ">
8 (16.3%)
</td>
</tr>
<tr>
<td style="text-align:left;">
Associate’s degree
</td>
<td style="text-align:left;width: 3.5cm; ">
2 (4.1%)
</td>
</tr>
<tr>
<td style="text-align:left;">
Bachelor’s degree
</td>
<td style="text-align:left;width: 3.5cm; ">
1 (2.0%)
</td>
</tr>
<tr>
<td style="text-align:left;">
Other/Unknown
</td>
<td style="text-align:left;width: 3.5cm; ">
1 (2.0%)
</td>
</tr>
</tbody>
</table>

<br/>

### Statistics (often used in inline code)

Functions in this section return statistics that are often used for
explanations on figures. Many of these functions will often be used in
inline code.

`print_n_reporting()`

`count_and_percent()` Returns a string that includes the total count and
percentage of the categories in the input variable.

`get_perct()`
