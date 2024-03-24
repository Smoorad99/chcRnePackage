

## Create table of percentages for single multiple choice question (ex: Housing - Current Housing Situation)
question_table <- function(question, values, cnames) {
  temp_df <- data.frame(qs=character(), prc=character(), frq=numeric())
  for (idx in 1:length(values)) {
    temp_df[idx, 1] <- values[idx]
    temp_df[idx, 2] <- get_perct(bns[[question]], values[idx])
    temp_df[idx, 3] <- sum(bns[[question]] == values[idx], na.rm = TRUE)
  }
  temp_df <- temp_df %>% arrange(desc(frq)) %>% select(-frq)
  colnames(temp_df) <- cnames
  temp_df %>% kable() %>% kable_styling(bootstrap_options = "striped") %>% column_spec(2, width='3.5cm')
}
