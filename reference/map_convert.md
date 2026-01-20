# map_convert

The 'MAPPING\_' file groups multiple categorisations onto one line e.g.
Domain_code could read '1,3'  
  
This function creates a new longer output 'L-MAPPING\_' which gives each
categorisation its own row.  
  
This 'L-MAPPING\_' may be useful when using these csv files in later
analyses

## Usage

``` r
map_convert(
  csv_to_convert,
  csv_to_convert_dir,
  output_dir = csv_to_convert_dir,
  quiet = FALSE
)
```

## Arguments

- csv_to_convert:

  Name of 'MAPPING\_' csv file created from metadata_map

- csv_to_convert_dir:

  Location of csv_to_convert

- output_dir:

  Location where the 'L-MAPPING\_' csv file will be saved.

- quiet:

  Default is FALSE. Change to TRUE to quiet the cli_alert_info and
  cli_alert_success messages. Default is csv_to_convert_dir.

## Value

Returns 'L-MAPPING\_' file in specified directory

## Examples

``` r
# Locate file path and file name for the example files in the package
demo_csv_to_convert_dir <- system.file("outputs", package = "mapmetadata")
demo_csv_to_convert <- "MAPPING_360_NCCHD_CHILD_2025-02-14-18-14-01.csv"
temp_output_dir <- tempdir()
# Run the function
map_convert(
csv_to_convert = demo_csv_to_convert,
csv_to_convert_dir = demo_csv_to_convert_dir,
output_dir = temp_output_dir)
#> ✔ Long format categorisations saved to:
#> /tmp/RtmpUcxt96/L-MAPPING_360_NCCHD_CHILD_2025-02-14-18-14-01.csv
```
