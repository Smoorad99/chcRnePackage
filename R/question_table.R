#' Table of counts percentages for single question
#'
#' This function takes a dataset and a specified column representing a single
#' categorical or binary variable (e.g., level of education) and creates a table of
#' response percentages. The table can be optionally styled using `kableExtra`
#' for better visualization.
#'
#' @param data A data frame containing the dataset to be analyzed.
#' @param x The name of the column in `data` containing the question.
#' @param cnames A character vector of length 2 specifying the column names for the
#'   resulting table. The first element is for the category name and the second for the percentages.
#' @param kbl_styling A logical value indicating whether to style the table with `kableExtra`.
#'   Defaults to TRUE. If TRUE, the table is returned with `kableExtra` styling applied.
#'
#' @return A table of percentages for the specified question. If `kbl_styling` is TRUE,
#'   the table is styled with `kableExtra` and suitable for markdown rendering.
#'   Otherwise, a plain data frame is returned.
#'
#' @examples
#' question_table(data = bns2_pkg_data, x = 'q13', cnames = c("Level of Education", "Yes %"), kbl_styling = TRUE)
#'
#' @import dplyr
#' @importFrom formattable percent
#' @importFrom kableExtra kable kable_styling column_spec
#' @export
#'
question_table <- function (data, x, cnames, kbl_styling = TRUE) {
  temp <- data |>
    filter(!is.na(data[[x]]))
  tbl <- temp |>
    group_by(temp[[x]]) |> summarise(count = n()) |>
    arrange(desc(count)) |>
    mutate(a = paste0(count," (", percent(count/nrow(temp), digits = 1), ")")) |>
    select(-c(count))
  colnames(tbl) <- cnames
  if (kbl_styling) return(tbl |> kable() |>
                            kable_styling(bootstrap_options = "striped") |>
                            column_spec(2, width='3.5cm'))
  if (!kbl_styling) return(tbl)
}



## package::function notation
# question_table <- function (data, x, cnames, kbl_styling = TRUE) {
#   temp <- data |> dplyr::select(x) |> na.omit()
#   tbl <- temp |> dplyr::group_by(x) |> dplyr::summarise(count = dplyr::n()) |>
#     dplyr::arrange(desc(count)) |>
#     dplyr::mutate(a = paste0(count," (", formattable::percent(count/nrow(temp), digits = 1), ")")) |>
#     dplyr::select(-c(count))
#   colnames(tbl) <- cnames
#   if (kbl_styling) return(tbl |> kableExtra::kable() |>
#                             kableExtra::kable_styling(bootstrap_options = "striped") |> kableExtra::column_spec(2, width='3.5cm'))
#   if (!kbl_styling) return(tbl)
# }

