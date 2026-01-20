# Internal: Output log dataframe

Internal Dataset: Empty log output dataframe for metadata_map to fill.
Created by:  
  

1.  `log_output_df <- data.frame(timestamp = character(1), mapmetadata = character(1), domain_list_desc = character(1), dataset = character(1), table = character(1), table_note = character(1))`

2.  `usethis::use_data(log_output_df)`

## Usage

``` r
data(log_output_df)
```

## Format

A data frame with 1 empty row and 9 columns

## Source

Dataframe was manually created as package data, using the above code.
