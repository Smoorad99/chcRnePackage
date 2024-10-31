## Testing combinations of prefix & yesno and basic function function :=)

data <- bns2_pkg_data[, 1:10]

t1 <- data |> mutate(across(q14_1:q14_11, ~ifelse(is.na(.x), 0, 1)))
t2 <- data |> mutate(across(q14_1:q14_11, ~ifelse(.x == "Yes", 1, ifelse(.x == "No", 0, NA))))
t3 <- data |> mutate(across(starts_with("q14_"), ~ifelse(is.na(.x), 0, 1)))
t4 <- data |> mutate(across(starts_with("q14_"), ~ifelse(.x == "Yes", 1, ifelse(.x == "No", 0, NA))))

test_that("string/na and no prefix", {
  expect_equal(to_binary(data = data, these.cols = c(q14_1:q14_11), prefix = FALSE, yesno = FALSE), t1)
})

test_that("yes/no and no prefix", {
  expect_equal(to_binary(data = data, these.cols = c(q14_1:q14_11), prefix = FALSE, yesno = TRUE), t2)
})


test_that("string/na no prefix", {
  expect_equal(to_binary(data = data, these.cols = "q14_", prefix = TRUE, yesno = FALSE), t3)
})


test_that("yes/no and prefix", {
  expect_equal(to_binary(data = data, these.cols = "q14_", prefix = TRUE, yesno = TRUE), t4)
})



## Testing that the function still works when dealing with unusual data situations

### Ideas: Columns with only NAs

data$na <- NA

