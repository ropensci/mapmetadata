# data_load

Internal Function: Called within the metadata_map function.  
  
Collects inputs needed for metadata_map function (defaults or user
inputs) If some inputs are NULL, it loads the default inputs. If
defaults not available, it prints error for the user. If inputs are not
NULL, it loads the user-specified inputs.

## Usage

``` r
data_load(metadata_file, domain_file, look_up_file, quiet = FALSE)
```

## Arguments

- metadata_file:

  As defined in metadata_map

- domain_file:

  As defined in metadata_map

- look_up_file:

  As defined in metadata_map

- quiet:

  Default is FALSE. Change to TRUE to quiet the cli_alert_info and
  cli_alert_success messages.

## Value

A list of 6: all inputs needed for the metadata_map function to run.

## See also

Other metadata_map_internal:
[`empty_count()`](https://docs.ropensci.org/mapmetadata/reference/empty_count.md),
[`empty_plot()`](https://docs.ropensci.org/mapmetadata/reference/empty_plot.md),
[`end_plot()`](https://docs.ropensci.org/mapmetadata/reference/end_plot.md),
[`output_copy()`](https://docs.ropensci.org/mapmetadata/reference/output_copy.md),
[`user_categorisation()`](https://docs.ropensci.org/mapmetadata/reference/user_categorisation.md),
[`user_categorisation_loop()`](https://docs.ropensci.org/mapmetadata/reference/user_categorisation_loop.md)
