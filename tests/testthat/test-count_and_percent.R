test_that("two categories", {
  expect_equal(count_and_percent(bns2_pkg_data, q13, c("Associate's degree", "Less than high school")), "28 (57.1%)")
})

test_that("two categories2", {
  expect_equal(count_and_percent(bns2_pkg_data, q13, c("Associate's degree", "Less than high school"), format1 = FALSE), "(n=28, 57.1%)")
})

count_and_percent2(bns2_pkg_data, q13, c("Associate's degree", "Less than high school"))

