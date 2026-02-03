# California public higher education campuses

A dataset of public higher education campuses in California, including
University of California (UC), California State University (CSU), and
California Community Colleges (CCC).

## Usage

``` r
campuses
```

## Format

A tibble with one row per campus and the following columns:

- campus_full:

  Character string giving the campuses full name

- campus_short:

  Character string giving the campuses short name

- sector:

  Character string indicating the sector: `"UC"`, `"CSU"`, or `"CCC"`

## Details

Campus names reflect commonly used public-facing names. The dataset is
intended for filtering, matching, and categorizing institutions by
sector.
