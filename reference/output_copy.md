# output_copy

Internal Function: Called within the metadata_map function.  
  
Searches for previous OUTPUT files in the output_dir, that match the
dataset name.  
  
If files exist, it removes duplicates and autos, and stores the rest of
the table variables in a dataframe.  
  

## Usage

``` r
output_copy(dataset_name, output_dir, quiet = FALSE)
```

## Arguments

- dataset_name:

  Name of the dataset

- output_dir:

  Output directory to be searched

- quiet:

  Default is FALSE. Change to TRUE to quiet the cli_alert_info and
  cli_alert_success messages.

## Value

It returns a list of 2: df_prev_exist (a boolean) and df_prev (NULL or
populated with table variables to copy)

## See also

Other metadata_map_internal:
[`data_load()`](https://docs.ropensci.org/mapmetadata/reference/data_load.md),
[`empty_count()`](https://docs.ropensci.org/mapmetadata/reference/empty_count.md),
[`empty_plot()`](https://docs.ropensci.org/mapmetadata/reference/empty_plot.md),
[`end_plot()`](https://docs.ropensci.org/mapmetadata/reference/end_plot.md),
[`user_categorisation()`](https://docs.ropensci.org/mapmetadata/reference/user_categorisation.md),
[`user_categorisation_loop()`](https://docs.ropensci.org/mapmetadata/reference/user_categorisation_loop.md)
