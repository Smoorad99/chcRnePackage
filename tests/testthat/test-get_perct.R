test_that("t1 get percent", {
  expect_equal(get_perct(bns2_pkg_data$q14_1, "No"), "27/47 (57.4%)")
})

test_that("t2 get percent", {
  expect_equal(get_perct(bns2_pkg_data$q13, "Some college"), "7/49 (14.3%)")
})
