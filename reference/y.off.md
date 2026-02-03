# Function for plot_frq y.offset

The purpose of \`y.off\` is to ensure the count and percent remains "on
screen" regardless of number of rows when using \`plot_frq()\`.

## Usage

``` r
y.off(datavar)
```

## Arguments

- datavar:

  Data frame \$ variable

## Value

a number that is equal 1/100th of the max category in the selected
variable

## Examples

``` r
df <- bns2_pkg_data |> head(10)

# Without adjusting the y.offset
sjPlot::plot_frq(df$q13)


# Using y.off function
sjPlot::plot_frq(df$q13, y.offset = y.off(df$q13))
```
