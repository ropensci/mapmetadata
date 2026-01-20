# Internal: end_plot

This function is called within the metadata_map function.  
  
A summary plot is created that includes the domain code reference table
and counts of domain code categorisations  
  

## Usage

``` r
end_plot(df, table_name, ref_table)
```

## Arguments

- df:

  The Output dataframe with all the domain categorisations

- table_name:

  Table name

- ref_table:

  Domain code reference table (domains mapped to integers)

## Value

It returns a ggplot

## See also

Other metadata_map_internal:
[`data_load()`](https://docs.ropensci.org/mapmetadata/reference/data_load.md),
[`empty_count()`](https://docs.ropensci.org/mapmetadata/reference/empty_count.md),
[`empty_plot()`](https://docs.ropensci.org/mapmetadata/reference/empty_plot.md),
[`output_copy()`](https://docs.ropensci.org/mapmetadata/reference/output_copy.md),
[`user_categorisation()`](https://docs.ropensci.org/mapmetadata/reference/user_categorisation.md),
[`user_categorisation_loop()`](https://docs.ropensci.org/mapmetadata/reference/user_categorisation_loop.md)
