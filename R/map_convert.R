#' map_convert
#'
#' The 'MAPPING_' file groups multiple categorisations onto one line e.g.
#' Domain_code could read '1,3' \cr \cr
#' This function creates a new longer output 'L-MAPPING_' which gives each
#' categorisation its own row. \cr \cr
#' This 'L-MAPPING_' may be useful when using these csv files in later analyses
#' @param csv_to_convert Name of 'MAPPING_' csv file created from metadata_map
#' @param csv_to_convert_dir Location of csv_to_convert
#' @param output_dir Location where the 'L-MAPPING_' csv file will be saved.
#' @param quiet Default is FALSE. Change to TRUE to quiet the cli_alert_info
#' and cli_alert_success messages.
#' Default is csv_to_convert_dir.
#' @return Returns 'L-MAPPING_' file in specified directory
#' @export
#' @importFrom utils read.csv write.csv
#' @importFrom cli cli_alert_success
#' @examples
#' # Locate file path and file name for the example files in the package
#' demo_csv_to_convert_dir <- system.file("outputs", package = "mapmetadata")
#' demo_csv_to_convert <- "MAPPING_360_NCCHD_CHILD_2024-12-19-14-17-45.csv"
#' temp_output_dir <- tempdir()
#' # Run the function
#' map_convert(
#' csv_to_convert = demo_csv_to_convert,
#' csv_to_convert_dir = demo_csv_to_convert_dir,
#' output_dir = temp_output_dir)
map_convert <- function(csv_to_convert,
                        csv_to_convert_dir,
                        output_dir = csv_to_convert_dir,
                        quiet = FALSE) {

  # VALIDATE INPUTS ----
  if (!dir.exists(output_dir)) {
    stop("The output_dir does not exist.")
  }

  if (!is.logical(quiet)) {
    stop(paste("quiet should take the value of 'TRUE' or 'FALSE'"))
  }

  if (!file.exists(paste0(csv_to_convert_dir, "/", csv_to_convert))) {
    stop("Cannot locate the MAPPING_ file to convert.")
  }

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
  output_long_fname <- paste0(output_dir, "/L-", csv_to_convert)
  write.csv(output_long, output_long_fname, row.names = FALSE)

  if (!quiet) {
    cli_alert_success(paste("Long format categorisations saved to:\n",
                            "{output_long_fname}"))
  }
}
