
# chcRne

The chcRne package was developed to organize functions, useful code
snippets, and other information relevant to the Research and Evaluation
team at the Center for Healthy Communities.

### Data Management

Functions in this section are used used for data management.

- `pnta.unanswered.to.miss()` Sets all options (vars) in select all that
  apply questions to NA when the “Prefer not to answer” option was
  selected.

### Statistics (often used in inline code)

Functions in this section return statistics that are often used for
expalnations on figures. Many of these functions will often be used in
inline code.

- `count_and_percent()` Returns a string that includes the total count
  and percentage of the categories in the input variable.

### Visualization

Functions in this section are used for the creation of figures, tables,
and other visualizations.

- `nperc_tbl_MATA()` Creates a table showing the n counts and
  percentages for each option in a mark all that apply question.

Link to package description:

## How to install:

    install.packages("devtools") 
    devtools::install_github("Smoorad99/chcRnePackage")

## Examples

``` r
library(chcRne)

cols <- c("no_goingout_cooking", "no_goingout_broke")
rnames <- c("I like cooking", "I am a broke college student")

# Create table that reports n count and percent for a mark all that apply question
table1 <- nperc_tbl_MATA(df = exp.data,
               vars = cols,
               value = "1",
               row.names = rnames,
               punc = ".",
               col.title = "Why not go out to eat?")
table1
```

<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;">
Why not go out to eat?
</th>
<th style="text-align:left;">
Yes (%)
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
I like cooking. (n = 20)
</td>
<td style="text-align:left;width: 3.5cm; ">
11 (55.0%)
</td>
</tr>
<tr>
<td style="text-align:left;">
I am a broke college student. (n = 20)
</td>
<td style="text-align:left;width: 3.5cm; ">
9 (45.0%)
</td>
</tr>
</tbody>
</table>

``` r
count_and_percent(var = exp.data$no_goingout_cooking, "1")
```

    ## [1] "11 (55.0%)"
