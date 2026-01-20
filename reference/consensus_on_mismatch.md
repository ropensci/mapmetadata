# consensus_on_mismatch

Internal Function: Called within the map_compare.R function.  
  
For each table variable, it compares the domain code categorisation
between two sessions. If the categorisation differs, it prompts the user
for a new consensus decision by presenting the metadata info.  
  

## Usage

``` r
consensus_on_mismatch(ses_join, table_df, var_int, domain_code_max)
```

## Arguments

- ses_join:

  The joined dataframes from the two sessions

- table_df:

  Metadata, for one table in the dataset

- var_int:

  Integer to indicate which variable

- domain_code_max:

  The maximum allowable domain code integer

## Value

Returns list of 2: domain code and note from the consensus decision

## See also

Other map_compare_internal:
[`user_categorisation()`](https://docs.ropensci.org/mapmetadata/reference/user_categorisation.md),
[`valid_comparison()`](https://docs.ropensci.org/mapmetadata/reference/valid_comparison.md)
