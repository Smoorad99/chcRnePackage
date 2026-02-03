# Convert Yes/No variables to binary

This function converts all "String"/"NA" or "Yes/"No" responses in the
selected columns to binary (1/0) where the strings are replaced by 1s
and the NAs are replaced by 0s.

## Usage

``` r
to_binary(data, these.cols, prefix = FALSE, yesno = FALSE)
```

## Arguments

- data:

  A dataframe containing the variables to be converted.

- these.cols:

  A prefix used to select all columns with the prefix or the columns
  specified like you would using \`dplyr::select()\`

- prefix:

  A logical argument that indicates whether or not you are using a
  prefix to select columns. This argument defaults to FALSE i.e. assumes
  your not using a prefix unless you tell it otherwise.

- yesno:

  A logical argument that indicates the values of the the columns you
  are selecting. If TRUE you are using \`to_binary\` on columns with
  values of Yes/No. If FALSE, you are indicating the column values are
  string/NA.

## Value

The original dataframe with specified variables converted to binary.

## Examples

``` r
# Convert "Yes"/"No" responses in columns starting with "q14" to 1/0
df_converted <- to_binary(data = bns2_pkg_data,
                          these.cols = "q14_",
                          prefix = TRUE, yesno = TRUE)

# View the converted dataframe side-by-side
old <- bns2_pkg_data |> dplyr::select(q14_1, q14_4)
new <- df_converted |> dplyr::select(q14_1, q14_4)
cbind(old, new) |> head(10)
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


# Selecting columns by column name
df_converted <- to_binary(data = bns2_pkg_data,
                          these.cols = c(q14_5, q14_6),
                          prefix = FALSE, yesno = TRUE)

# View
old <- bns2_pkg_data |> dplyr::select(q14_5, q14_6)
new <- df_converted |> dplyr::select(q14_5, q14_6)
cbind(old, new) |> head(10)
#>    q14_5 q14_6 q14_5 q14_6
#> 1    Yes    No     1     0
#> 2     No    No     0     0
#> 3     No    No     0     0
#> 4     No    No     0     0
#> 5    Yes    No     1     0
#> 6     No    No     0     0
#> 7   <NA>  <NA>    NA    NA
#> 8     No    No     0     0
#> 9     No    No     0     0
#> 10    No    No     0     0
```
