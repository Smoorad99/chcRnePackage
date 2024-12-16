

#' Yes and percent
#'
#' yes_pct calculates the count and percent of a user specified value in var2 for each level of a var1.
#'
#'
#' @param df A data frame containing the data set to be analyzed.
#' @param var1 The variable containing the levels to be grouped and summarized.
#' @param var2 The variable you want to count the number of occurrences of a certain value.
#' @param value The value from var2 to be counted.
#' @param plot If plot = FALSE `yes_pct` will return a data
#' frame with summarized data. If plot = TRUE `yes_pct` will return a ggplot object
#' to visualize the summarized data. Defaults to plot = FALSE.
#'
#' @export
#'
#' @examples
#' # Output a data frame
#' yes_pct(bns2_pkg_data, q13, q14_1, value = "Yes")
#'
#' # Output a plot
#' yes_pct(bns2_pkg_data, q13, q14_1, value = "Yes", plot = TRUE)

yes_pct <-  function(df, var1, var2, value, plot = FALSE) {
  tmp <- df |> select({{var1}}, {{var2}}) |> na.omit()
  summarized_df <- tmp |>
    group_by({{var1}}) |>
    summarize(
      count = n(),
      val_count = sum({{var2}} == {{value}}),
      pct = val_count/count,
      npct = paste0(val_count, " (", unname(formattable::percent(pct, digits = 1)), ")")
    ) |>
      arrange(desc(pct))
  if (plot) {
    summarized_df |> ggplot(aes(x = {{var1}}, y = val_count)) + geom_col() +
      geom_text(aes(label = npct))
  }
  else {
    summarized_df
  }
}

# test code
#yes_pct(bns2_pkg_data, q13, q14_1, value = "Yes")
