# CHC Snippets

### Intro and Purpose

A code snippet is quick way to access code. For example, if you find
yourself loading in the dplyr package on a daily basis, you could create
snippet called `dp` that contains the code
[`library(dplyr)`](https://dplyr.tidyverse.org). Then you can type `dp`
and hit “tab” and the [`library(dplyr)`](https://dplyr.tidyverse.org)
will appear. You can check what code snippets you have and edit them by
going to “Tools” and selecting “Edit Code Snippets”. Along with reducing
unnecessary typing, snippets are a great way to quickly access code that
is easily forgotten. The dplyr syntax for applying a function across
multiple columns can be tricky to remember and tedious to find. So we
can make snippet, lets call it `ac` that contains
`across(COLS), ~ifelse(is.na(.x), 0, 1)`. So, when we type `ac` in the
console or a code chunk and hit “tab”,
`across(COLS), ~ifelse(is.na(.x), 0, 1)` will appear.

Snippets are not just for R code! You can have snippets for HTML,
Quarto, JavaScript, etc.. Lets start with the R code snippets first.

#### R

snippet sc select(starts_with(““))

snippet ac across(COLS), ~ifelse(is.na(.x), 0, 1)

#### Quarto

##### Callout boxes

### red important

snippet def :::{.callout-important} \### Definition \${1:text} :::
snippet redbox :::{.callout-important} \#### Title text

    :::

## 2 columns

snippet column :::: {.columns} ::: {.column width=“50%”} Left stuff :::
::: {.column width=“50%”} Right stuff ::: ::::

## panel tabset

snippet tabset ::: {.panel-tabset} \## header1

    Tab content

    ## header2

    Tab content
    :::

## aside

snippet aside

#### HTML

#### Latex
