# valid_comparison

Internal Function: Called within the map_compare.R function.  
  
It reads two inputs to see if they are equal.  
  
Warning severity: if unequal inputs, gives warning but continues.  
  
Danger severity: if unequal inputs, exits with error message.  
  

## Usage

``` r
valid_comparison(input_1, input_2, severity, severity_text)
```

## Arguments

- input_1:

  Input 1

- input_2:

  Input 2

- severity:

  Level of severity. Only 'danger' or 'warning'

- severity_text:

  The text to print if inputs are not equal.

## Value

Returns nothing if inputs are equal. If inputs are not equal, returns
variable text depending on level of severity.

## See also

Other map_compare_internal:
[`consensus_on_mismatch()`](https://docs.ropensci.org/mapmetadata/reference/consensus_on_mismatch.md),
[`user_categorisation()`](https://docs.ropensci.org/mapmetadata/reference/user_categorisation.md)
