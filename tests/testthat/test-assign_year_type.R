test_that("CY is assigned correctly", {

  dates <- as.Date(c(
    "2024-01-01",
    "2024-12-31",
    "2025-01-01"
  ))

  expect_equal(
    assign_year_type(dates, "CY"),
    c(2024, 2024, 2025)
  )
})


test_that("SFY changes on July 1", {

  dates <- as.Date(c(
    "2025-06-30",
    "2025-07-01",
    "2026-06-30",
    "2026-07-01"
  ))

  expect_equal(
    assign_year_type(dates, "SFY"),
    c(2025, 2026, 2026, 2027)
  )
})


test_that("FFY changes on October 1", {

  dates <- as.Date(c(
    "2025-09-30",
    "2025-10-01",
    "2026-09-30",
    "2026-10-01"
  ))

  expect_equal(
    assign_year_type(dates, "FFY"),
    c(2025, 2026, 2026, 2027)
  )
})


test_that("common character date formats work", {

  dates <- c(
    "2025-07-01",
    "7/1/2025",
    "July 1 2025"
  )

  expect_equal(
    assign_year_type(dates, "SFY"),
    c(2026, 2026, 2026)
  )
})


test_that("invalid year types fail", {

  expect_error(
    assign_year_type(Sys.Date(), "ABC")
  )
})
