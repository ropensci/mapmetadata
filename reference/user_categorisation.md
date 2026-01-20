# Internal: user_categorisation

Internal Function: Called within the metadata_map function.  
  
It displays data properties to the user and requests a categorisation
into a domain.  
  
An optional note can be included with the categorisation.

## Usage

``` r
user_categorisation(var, desc, type, domain_code_max)
```

## Arguments

- var:

  Name of the variable

- desc:

  Description of the variable

- type:

  Data type of the variable

- domain_code_max:

  Max code in the domain list (0-3 auto included, then N included via
  domain_file)

## Value

It returns a list containing the decision and decision note

## See also

Other metadata_map_internal:
[`data_load()`](https://docs.ropensci.org/mapmetadata/reference/data_load.md),
[`empty_count()`](https://docs.ropensci.org/mapmetadata/reference/empty_count.md),
[`empty_plot()`](https://docs.ropensci.org/mapmetadata/reference/empty_plot.md),
[`end_plot()`](https://docs.ropensci.org/mapmetadata/reference/end_plot.md),
[`output_copy()`](https://docs.ropensci.org/mapmetadata/reference/output_copy.md),
[`user_categorisation_loop()`](https://docs.ropensci.org/mapmetadata/reference/user_categorisation_loop.md)

Other map_compare_internal:
[`consensus_on_mismatch()`](https://docs.ropensci.org/mapmetadata/reference/consensus_on_mismatch.md),
[`valid_comparison()`](https://docs.ropensci.org/mapmetadata/reference/valid_comparison.md)
