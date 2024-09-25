#' @title Creates frequency table
#' @description
#' `nperc_tbl_MATA` can be used to create a table showing the n counts and percentages for each option in a mark all that apply question.
#'
#' @param df A data frame used to create the table.
#' @param vars A character vector of variable names to include in the table (all vars have to be binary).
#' @param value The value in the rows of `vars` (only one value across all variables).
#' @param row.names The name of each row in the table. Should be equivalent to each option in the select all that apply question.
#' @param punc The punctuation at the end of the row names.
#' @param plot If TRUE, returns a count and percent bar plot instead of a data frame. Defaults to FALSE.
#'
#' @return A frequency table
#' @export
#'
#' @examples
#' # Save the variable names to questions and the names of the questions to rnames
#' cols <- c("q14_1", "q14_3", "q14_4")
#'
#' nperc_tbl_MATA(df = bns2_pkg_data,
#'                vars = cols,
#'                value = "Yes",
#'                row.names = c("I am a broke college student",
#'                              "No good restaurants",
#'                              "I like cooking"),
#'                punc = ".")
#'
#'
nperc_tbl_MATA <- function(df, vars, value, row.names, punc, plot = FALSE) {
  tm <- df |> select(all_of(vars))
  non.na <- tm |> summarise_at(vars(vars), ~sum(!is.na(.))) |> tidyr::pivot_longer(everything())
  tm1 <- tm |> summarise_at(vars(vars), ~sum(. == value, na.rm = TRUE)) |>
    tidyr::pivot_longer(everything())
  tm2 <- tm1 |> mutate(
    n = non.na$value,
    npct = paste0(value, " (", unname(formattable::percent(value/n, digits = 1)), ")"),
    col = paste0(row.names, punc, " (n = ", n, ")")
  )
  tm3 <- tm2 |> select(col, npct)
  if (plot) {
    ggplot2::ggplot(tm2, ggplot2::aes(x = name, y = value)) +
      ggplot2::geom_col() + ggplot2::geom_text(ggplot2::aes(label = npct), vjust = -0.2)
  }
  if (!plot) {
    tm3
  }
}

## Testing ---
df <- bns2_pkg_data
vars <- c("q14_1", "q14_3", "q14_4")
value <- "Yes"
row.names <- c("I am a broke college student","No good restaurants", "I like cooking")
punc <- ""




# Use pivot longer and pivot wider instead of transpose
## First attempt

# nperc_tbl_MATA <- function(df, vars, value, row.names, punc) {
#     tmp <- as.data.frame(t(df[vars]))
#     tmp2 <- data.frame(Freq=apply(tmp, 1, function(x, value) sum(x == value, na.rm=TRUE), value))
#     n.s <- apply(tmp, 1, function(x) sum(!is.na(x))) # get this
#     tmp2$label <- paste0(tmp2$Freq, " (", unname(formattable::percent(tmp2$Freq/n.s, digits = 1)), ")")
#     rownames(tmp2) <- paste0(row.names, punc, " (n = ", n.s, ")")
#     tmp2 <- tmp2 |> dplyr::arrange(dplyr::desc(Freq)) |> dplyr::select(-Freq)
#     colnames(tmp2) <- "Yes (%)"
#     tmp2
#     #tmp2 <- tibble::rownames_to_column(tmp2, var = "Temp")
#     #tmp2 |> kableExtra::kable(col.names = c(col.title, "Yes (%)")) |> kableExtra::kable_styling(bootstrap_options = "striped") |> kableExtra::column_spec(2, width='3.5cm')
#     }



# plot_list <- list()
#
# for (i in 1:ncol(tm)){
#   plot <- plot_frq(tm[,i], y.offset = .05)
#   plot_list[[i]] <- plot
# }
#
# # Use pivot longer and pivot wider instead of transpose
#
# #plot_list[[i]] <- lapply(tm, plot_frq)
# plot_grob <- gridExtra::arrangeGrob(grobs=plot_list)
# gridExtra::grid.arrange(plot_grob)

# Removed col.title as input for the function because we removed the kables styling

# Rework for future release (not the next one)
# Option to show as plot
# If plot = TRUE.. take pre-summarized data call ggplot and use geom_column

