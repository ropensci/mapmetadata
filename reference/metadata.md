# Internal: CSV metadata File

Example metadata for a health dataset, to demo metadata_map  
  
This data was created with these steps:

1.  Go to https://healthdatagateway.org

2.  Navigate to the dataset of interest, select 'Download data' and
    download the Structural Metadata file

3.  Shorten name of downloaded file e.g. 360_NCCHD_Metadata.csv

4.  `metadata <- read.csv(system.file('inputs', '360_NCCHD_Metadata.csv', package = 'mapmetadata'))`

5.  `usethis::use_data(metadata)`

## Usage

``` r
data(metadata)
```

## Format

Nested lists

## Source

https://healthdatagateway.org/en/dataset/360
