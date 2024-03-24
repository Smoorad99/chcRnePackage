#' @title Creates frequency table
#' @description
#' This function creates a table showing the n counts and percentages for each option in a mark all that apply question.
#'
#' @param df A data frame used to create the table.
#' @param vars A character vector of variable names to include in the table (all vars have to be binary).
#' @param value The value in the rows of `vars` (only one value across all variables).
#' @param row.names The name of each row in the table. Should be equivalent to each option in the select all that apply question
#' @param punc The punctuation at the end of the row names.
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
#'                row.names = c("I am a broke college student","No good restaurants", "I like cooking"),
#'                punc = ".")
#'
#'
nperc_tbl_MATA <- function(df, vars, value, row.names, punc) {
    tmp <- as.data.frame(t(df[vars]))
    tmp2 <- data.frame(Freq=apply(tmp, 1, function(x, value) sum(x == value, na.rm=TRUE), value))
    n.s <- apply(tmp, 1, function(x) sum(!is.na(x))) # get this
    tmp2$label <- paste0(tmp2$Freq, " (", unname(formattable::percent(tmp2$Freq/n.s, digits = 1)), ")")
    rownames(tmp2) <- paste0(row.names, punc, " (n = ", n.s, ")")
    tmp2 <- tmp2 |> dplyr::arrange(dplyr::desc(Freq)) |> dplyr::select(-Freq)
    colnames(tmp2) <- "Yes (%)"
    tmp2
    #tmp2 <- tibble::rownames_to_column(tmp2, var = "Temp")
    #tmp2 |> kableExtra::kable(col.names = c(col.title, "Yes (%)")) |> kableExtra::kable_styling(bootstrap_options = "striped") |> kableExtra::column_spec(2, width='3.5cm')
    }
# Removed col.title as input for the function because we removed the kables styling
