
#' @title Count and percent table
#' @description
#' Creates a table showing the n counts and percentages for each option in a mark all that apply question.
#'
#' @param df The data frame used to create the table
#' @param vars The variables of interest (all vars have to be binary)
#' @param value The value in the rows of `vars` (should be "Yes" or "1")
#' @param row.names The name of each row in the table. Should be equivalent to each option in the select all that apply question
#' @param punc The punctuation at the end of the row names
#' @param col.title The name of the first column in the table
#'
#' @return A table
#' @export
#'
#' @examples
#' # Save the variable names ti questions and the names of the questions to rnames
#' cols <- c("no_goingout_cooking", "no_goingout_broke")
#' rnames <- c("I like cooking", "I am a broke college student")
#'
#' nperc_tbl_MATA(df = exp.data,
#'                vars = cols,
#'                value = "1",
#'                row.names = rnames,
#'                punc = ".",
#'                col.title = "Why not go out to eat?")
#'
#'
nperc_tbl_MATA <- function(df, vars, value, row.names, punc, col.title = "") {
    tmp <- as.data.frame(t(df[vars]))
    tmp2 <- data.frame(Freq=apply(tmp, 1, function(x, value) sum(x == value, na.rm=TRUE), value))
    n.s <- apply(tmp, 1, function(x) sum(!is.na(x))) # get this
    tmp2$label <- paste0(tmp2$Freq, " (", unname(formattable::percent(tmp2$Freq/n.s, digits = 1)), ")")
    rownames(tmp2) <- paste0(rnames, punc, " (n = ", n.s, ")")
    tmp2 <- tmp2 |> dplyr::arrange(dplyr::desc(Freq)) |> dplyr::select(-Freq)
    colnames(tmp2) <- "Yes (%)"
    tmp2 <- tibble::rownames_to_column(tmp2, var = "Temp")
    tmp2 |> kableExtra::kable(col.names = c(col.title, "Yes (%)")) |> kableExtra::kable_styling(bootstrap_options = "striped") |> kableExtra::column_spec(2, width='3.5cm')
    }
