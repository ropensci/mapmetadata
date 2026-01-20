# empty_count

Internal Function: Called within the metadata_map function.  
  
It reads in the metadata dataframe and counts how many of the variables
have empty descriptions.

## Usage

``` r
empty_count(dataframe)
```

## Arguments

- dataframe:

  Dataframe representing metadata, 'Section' column as factor

## Value

Returns a long dataframe with 3 columns: Empty (No, Yes), Table (table
name), N_Variables (count).

## See also

Other metadata_map_internal:
[`data_load()`](https://docs.ropensci.org/mapmetadata/reference/data_load.md),
[`empty_plot()`](https://docs.ropensci.org/mapmetadata/reference/empty_plot.md),
[`end_plot()`](https://docs.ropensci.org/mapmetadata/reference/end_plot.md),
[`output_copy()`](https://docs.ropensci.org/mapmetadata/reference/output_copy.md),
[`user_categorisation()`](https://docs.ropensci.org/mapmetadata/reference/user_categorisation.md),
[`user_categorisation_loop()`](https://docs.ropensci.org/mapmetadata/reference/user_categorisation_loop.md)
