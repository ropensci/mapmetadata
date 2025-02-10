#' map_convert
#'
#' The 'OUTPUT_' file groups multiple categorisations onto one line e.g.
#' Domain_code could read '1,3' \cr \cr
#' This function creates a new longer output 'L-MAPPING_' which gives each
#' categorisation its own row. \cr \cr
#' This 'L-MAPPING_' may be useful when using these csv files in later analyses
#' @param csv_to_convert Name of 'MAPPING_' csv file created from metadata_map
#' @param csv_to_convert_dir Location of csv_to_convert
#' @param output_dir Location where the 'L-MAPPING_' csv file will be saved.
#' Default is csv_to_convert_dir.
#' @return Returns 'L-MAPPING_' file in specified directory
#' @export
#' @importFrom utils read.csv write.csv
#' @examples
#' # Locate file path and file name for the example files in the package
#' demo_output_dir <- system.file("outputs", package = "mapmetadata")
#' demo_csv_to_convert <- "MAPPING_360_NCCHD_CHILD_2024-12-19-14-17-45.csv"
#'
#' # Run the function
#' map_convert(
#' csv_to_convert = demo_csv_to_convert, csv_to_convert_dir = demo_output_dir)
map_convert <- function(csv_to_convert,
                        csv_to_convert_dir,
                        output_dir = csv_to_convert_dir) {
  output <- read.csv(file.path(csv_to_convert_dir, csv_to_convert))
  output_long <- output[0, ] # make duplicate

  for (row in seq_len(nrow(output))) {
    if (grepl(",", output$domain_code[row])) { # Domain_code for row is list
      domain_code_list <- output$domain_code[row] # extract Domain_code list
      domain_code_list_split <- unlist(strsplit(domain_code_list, ",")) # split
      for (code in seq_len(length(domain_code_list_split))) { # create new row
        row_to_copy <- output[row, ] # extract row
        row_to_copy$domain_code <- domain_code_list_split[code] # extract single
        output_long[nrow(output_long) + 1, ] <- row_to_copy # copy altered row
      }
    } else { # Domain_code for this row is not list
      row_to_copy <- output[row, ] # extract row
      output_long[nrow(output_long) + 1, ] <- row_to_copy # copy unaltered row
    }
  }

  # Save output_long
  output_long_fname <- file.path(output_dir, paste0("L-", csv_to_convert))
  write.csv(output_long, output_long_fname,row.names = FALSE)
  cat("\n")
  cli_alert_success(paste("Long format categorisations have been saved to:,",
                          "{output_long_fname}"))
}
