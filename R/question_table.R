

## Create table of percentages for single multiple choice question (ex: Housing - Current Housing Situation)
question_table <- function(data, question, values, cnames) {
  temp_df <- data.frame(qs=character(), prc=character(), frq=numeric())
  for (idx in 1:length(values)) {
    temp_df[idx, 1] <- values[idx]
    temp_df[idx, 2] <- chcRne::get_perct(data[[question]], values[idx])
    temp_df[idx, 3] <- sum(data[[question]] == values[idx], na.rm = TRUE)
  }
  temp_df <- temp_df %>% arrange(desc(frq)) %>% select(-frq)
  colnames(temp_df) <- cnames
  temp_df
}

# %>% kable() %>% kable_styling(bootstrap_options = "striped") %>% column_spec(2, width='3.5cm')


cnames <- c('Education:', 'Yes (%)')
qs <- names(table(bns2_pkg_data$q13))

question_table('q13', qs, cnames)
