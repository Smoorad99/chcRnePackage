# Export snippets

`addPackageSnippets` copies all (missing) snippet definitions in
'inst/rstudio/Rsnippets.txt' and 'Rmdsnippets.txt' to the RStudios user
snippet location.

## Usage

``` r
addPackageSnippets()
```

## Value

boolean invisible(FALSE) if nothing was added, invisible(TRUE) if
snipped definitions were added

## Examples

``` r
if (FALSE) addPackageSnippets() # \dontrun{}
```
