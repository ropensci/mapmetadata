# Internal: user_categorisation_loop

Internal Function: Called within the metadata_map function.  
  
Given a specific table and a number of variables to search, it checks
for 3 different sources of domain categorisation:  
  
1 - If variables match look-up table, auto categorise  
  
2 - If variables match to previous table output, copy them  
  
3 - If no match for 1 or 2, variables are categorised by the user  
  

## Usage

``` r
user_categorisation_loop(
  start_v,
  end_v,
  table_df,
  df_prev_exist,
  df_prev,
  lookup,
  n_codes,
  output_df,
  quiet = FALSE
)
```

## Arguments

- start_v:

  Index of variable to start

- end_v:

  Index of variables to end

- table_df:

  Dataframe with table info, extracted from metadata file

- df_prev_exist:

  Boolean to indicate if previous dataframes exists

- df_prev:

  Previous dataframes to copy from (or NULL)

- lookup:

  The lookup table to enable auto categorisations

- n_codes:

  Number of domain codes permissible

- output_df:

  Empty output dataframe, to fill

- quiet:

  Default is FALSE. Change to TRUE to quiet the cli_alert_info and
  cli_alert_success messages.

## Value

An output dataframe containing info about the table, variables and
categorisations

## See also

Other metadata_map_internal:
[`data_load()`](https://docs.ropensci.org/mapmetadata/reference/data_load.md),
[`empty_count()`](https://docs.ropensci.org/mapmetadata/reference/empty_count.md),
[`empty_plot()`](https://docs.ropensci.org/mapmetadata/reference/empty_plot.md),
[`end_plot()`](https://docs.ropensci.org/mapmetadata/reference/end_plot.md),
[`output_copy()`](https://docs.ropensci.org/mapmetadata/reference/output_copy.md),
[`user_categorisation()`](https://docs.ropensci.org/mapmetadata/reference/user_categorisation.md)
