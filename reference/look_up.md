# Internal: Auto-categorisations

Pre-defined pairings between table variables and domain codes.  
  
For each variable that metadata_map processes:  
  
If it is contained within this look-up table, it uses the
auto-categorised domain code rather than asking the user to
categorise.  
  
This data was created with these two steps:

1.  `look_up <- read.csv(system.file('inputs', 'look_up.csv',package = 'mapmetadata'))`

2.  `usethis::use_data(look_up)`

## Usage

``` r
data(look_up)
```

## Format

A data frame with a variable number of rows and 2 columns

## Source

The csv was manually created
