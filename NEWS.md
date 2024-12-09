# chcRne 0.2.2
## Fixes
* `nperc_tbl_MATA()` - The names were not following the movement of values when arranged in descending order. If you installed chcRne 0.2.1 this function was not working as intended.

# chcRne 0.2.1

## New additions
* `nperc_tbl_MATA()` - If the argument `plot = TRUE` the function will return a bar plot with counts and percentages instead of a table. This bug was resolved in this release.

## Fixes
* `count_and_percent` was returning 0 (0%) when used on a variable that was encapsulated with tick marks and used in inline code.

# chcRne 0.2.0

## New additions
* `y.off()` -  Returns a numeric value equal to 1/100th of the max category in the selected variable. The purpose of 'y.off' is to ensure the count and percent remains "on screen" regardless of number of rows when using 'plot_frq'.

* `find_dupes()` - Helper function when dealing with pre/post data.

## Reworks 
* `count_and_percent()`  - Now we can select categories using a character vector (i.e. c("cat1", "cat2",..., "catn")) instead of comma separated strings. 

* `to_binary()` - Previously `yesno_to_binary`. Allows the option to convert "String/NA" to binary as well as "Yes/No" to binary across columns.


# chcRne 0.1.0
* Alpha release
