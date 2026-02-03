# Table of counts percentages for single question

This function takes a dataset and a specified column representing a
single categorical or binary variable (e.g., level of education) and
creates a table of response percentages. The table can be optionally
styled using \`kableExtra\` for better visualization.

## Usage

``` r
question_table(data, x, cnames = c("Measure", "Yes (%)"), kbl_styling = TRUE)
```

## Arguments

- data:

  A data frame containing the dataset to be analyzed.

- x:

  The name of the column in \`data\` containing the question.

- cnames:

  A character vector of length 2 specifying the column names for the
  resulting table. The first element is for the category name and the
  second for the percentages. Defaults to c("Measure", "Yes (pecent)")

- kbl_styling:

  A logical value indicating whether to style the table with
  \`kableExtra\`. Defaults to TRUE. If TRUE, the table is returned with
  \`kableExtra\` styling applied.

## Value

A table of percentages for the specified question. If \`kbl_styling\` is
TRUE, the table is styled with \`kableExtra\` and suitable for markdown
rendering. Otherwise, a plain data frame is returned.

## Examples

``` r
# Without kable styling
question_table(data = bns2_pkg_data,
               x = 'q13',
               cnames = c("Level of Education", "Yes %"),
               kbl_styling = FALSE)
#> # A tibble: 5 × 2
#>   `Level of Education`       `Yes %`   
#>   <chr>                      <chr>     
#> 1 Less than high school      25 (51.0%)
#> 2 High school diploma or GED 12 (24.5%)
#> 3 Some college               7 (14.3%) 
#> 4 Associate's degree         3 (6.1%)  
#> 5 Other/Unknown              2 (4.1%)  
```
