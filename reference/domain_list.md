# Internal: List of Domains

Internal Dataset: A simplified list of domains, to demo the function
metadata_map  
  
This data was created with these two steps:

1.  `domain_list <- read.csv(system.file('inputs', 'domain_list_demo.csv', package = 'mapmetadata'))`

2.  `usethis::use_data(domain_list)`

## Usage

``` r
data(domain_list)
```

## Format

A data frame with 8 rows and 2 columns

## Source

The csv was manually created
