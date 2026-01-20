# metadata_map

This function will read in the metadata file for a chosen dataset and
create a summary plot. It will ask a user to select a table from this
dataset to process, and loop through all the variables in this table,
asking the user to map (categorise) each variable to one or more
domains. The domains will appear in the Plots tab for the user's
reference.  
  
These categorisations will be saved to a csv file, alongside a log file
which summarises the session details. To speed up this process, some
auto-categorisations will be made by the function for commonly occurring
variables, and categorisations for the same variable can be copied from
one table to another.  
  
Example inputs are provided within the package data, for the user to run
this function in a demo mode. Refer to the package website for more
guidance.

## Usage

``` r
metadata_map(
  metadata_file = NULL,
  domain_file = NULL,
  look_up_file = NULL,
  output_dir = getwd(),
  table_copy = TRUE,
  long_output = TRUE,
  demo_number = 5,
  quiet = FALSE
)
```

## Arguments

- metadata_file:

  This should be a csv download from HDRUK gateway (in the form of
  ID_Dataset_Metadata.csv). Run '?mapmetadata::metadata' to see how the
  metadata_file for the demo was created.

- domain_file:

  This should be a csv file created by the user, with two columns
  (Domain_Code and Domain_Name). Run '?mapmetadata::domain_list' to see
  how the domain_file for the demo was created.

- look_up_file:

  The lookup file makes auto-categorisations intended for variables that
  appear regularly in health datasets. It only works for 1:1 mappings
  right now, i.e. variable should only be listed once in the file. Run
  '?mapmetadata::look_up' to see how the default look_up was created.

- output_dir:

  The path to the directory where the two csv output files will be
  saved. Default is the current working directory.

- table_copy:

  Turn on copying between tables (default TRUE). If TRUE,
  categorisations you made for all other tables in this dataset will be
  copied over (if 'OUTPUT\_' files are found in output_dir). This can be
  useful when the same variables appear across multiple tables within
  one dataset; copying from one table to the next will save the user
  time, and ensure consistency of categorisations across tables.

- long_output:

  Run map_convert.R to create a new longer output. Default is TRUE.

- demo_number:

  How many table variables to loop through in the demo. Default is 5.
  'L-OUTPUT\_' which gives each categorisation its own row. Default is
  TRUE.

- quiet:

  Default is FALSE. Change to TRUE to quiet the cli_alert_info and
  cli_alert_success messages.

## Value

A html plot summarising the dataset. Various csv and png outputs to
summarise the user's mapping session for a specific table in the
dataset.

## Examples

``` r
# Demo run requires no function inputs but requires user interaction.
# See package documentation to guide user inputs.
if(interactive()) {
    temp_output_dir <- tempdir()
    metadata_map(output_dir = temp_output_dir)
}
```
