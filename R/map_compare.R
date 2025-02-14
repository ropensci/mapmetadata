#' map_compare
#'
#' This function is to be used after running the metadata_map function. \cr \cr
#' It compares csv outputs from two sessions, finds their differences,
#' and asks for a consensus. \cr \cr
#'
#' @param session_dir This directory should contain 2 csv files for each session
#' (LOG_ and OUTPUT_), 4 csv files in total.
#' @param session1_base Base file name for session 1 e.g.
#' 'NCCHD_BLOOD_TEST_2024-07-05-16-07-38'
#' @param session2_base Base file name for session 2 e.g.
#' 'NCCHD_BLOOD_TEST_2024-07-08-12-03-30'
#' @param metadata_file The full path to the metadata file used when running
#' metadata_map (should be the same for session 1 and session 2)
#' @param domain_file The full path to the domain file used when running
#' metadata_map (should be the same for session 1 and session 2)
#' @param output_dir The path to the directory where the consensus output file
#' will be saved. By default, the session_dir is used.
#' @param quiet Default is FALSE. Change to TRUE to quiet the cli_alert_info
#' and cli_alert_success messages.
#' @return It returns a csv output, which represents the consensus decisions
#' between session 1 and session 2
#' @export
#' @importFrom utils read.csv write.csv
#' @importFrom cli cli_alert_success
#' @importFrom dplyr left_join join_by
#' @examples
#' # Demo run requires no function inputs but requires user interaction.
#' # See package documentation to guide user inputs.
#' if(interactive()) {
#'     temp_output_dir <- tempdir()
#'     # Locate file paths for the example files in the package
#'     demo_session_dir <- system.file("outputs", package = "mapmetadata")
#'     demo_session1_base <- "360_NCCHD_CHILD_2024-12-19-14-11-55"
#'     demo_session2_base <- "360_NCCHD_CHILD_2024-12-19-14-17-45"
#'     demo_metadata_file <- system.file("inputs","360_NCCHD_Metadata.csv",
#'     package = "mapmetadata")
#'     demo_domain_file <- system.file("inputs","domain_list_demo.csv",
#'     package = "mapmetadata")
#'
#'     map_compare(
#'     session_dir = demo_session_dir,
#'     session1_base = demo_session1_base,
#'     session2_base = demo_session2_base,
#'     metadata_file = demo_metadata_file,
#'     domain_file = demo_domain_file,
#'     output_dir = temp_output_dir
#'     )}
map_compare <- function(session_dir,
                        session1_base,
                        session2_base,
                        metadata_file,
                        domain_file,
                        output_dir = session_dir,
                        quiet = FALSE) {
  timestamp_now_fname <- format(Sys.time(), "%Y-%m-%d-%H-%M-%S")

  # DEFINE INPUTS ----

  csv_1a <- read.csv(file.path(session_dir,
                               paste0("MAPPING_LOG_", session1_base, ".csv")))
  csv_2a <- read.csv(file.path(session_dir,
                               paste0("MAPPING_LOG_", session2_base, ".csv")))
  csv_1b <- read.csv(file.path(session_dir,
                               paste0("MAPPING_", session1_base, ".csv")))
  csv_2b <- read.csv(file.path(session_dir,
                               paste0("MAPPING_", session2_base, ".csv")))

  dataset <- read.csv(metadata_file)
  domains <- read.csv(domain_file, header = FALSE)

  ## Extract name of dataset
  metadata_file_base <- basename(metadata_file)
  metadata_file_base_0suffix <- sub("_Metadata.csv$", "",
                                    metadata_file_base)
  dataset_name <- gsub(" ", "", metadata_file_base_0suffix)

  # VALIDATION CHECKS ----

  ## Use 'valid_comparison.R' to check if sessions can be compared to each other
  #and to the metadata file (min requirements):

  valid_comparison(
    input_1 = csv_1a$dataset[1],
    input_2 = csv_2a$dataset[1],
    severity = "danger",
    severity_text = "Session 1 and 2 have different datasets"
  )

  valid_comparison(
    input_1 = csv_1a$table[1],
    input_2 = csv_2a$table[1],
    severity = "danger",
    severity_text = "Session 1 and 2 have different tables"
  )

  valid_comparison(
    input_1 = csv_1a$dataset[1],
    input_2 = dataset_name,
    severity = "danger",
    severity_text = "Different dataset to metadata"
  )

  valid_comparison(
    input_1 = nrow(csv_1b),
    input_2 = nrow(csv_2b),
    severity = "danger",
    severity_text = "Different number of variavles!"
  )

  ##  Check if sessions can be compared (warnings for user to check):

  valid_comparison(
    input_1 = csv_1a$mapmetadata[1],
    input_2 = csv_2a$mapmetadata[1],
    severity = "warning",
    severity_text = "Different version of mapmetadata package!"
  )

  # DISPLAY TO USER ----

  ## Use 'ref_plot.R' to plot domains for the user's ref (save df for later use)
  df_plots <- ref_plot(domains)

  # EXTRACT TABLE INFO FROM METADATA ----
  table_name <- csv_1a$table[1]
  table_df <- dataset %>% filter(Section == table_name)

  # JOIN DATAFRAMES FROM SESSIONS IN ORDER TO COMPARE ----
  ses_join <- left_join(csv_1b, csv_2b, suffix = c("_ses1", "_ses2"),
                        join_by(variable))
  ses_join <- select(ses_join, contains("_ses"), "variable")
  ses_join$domain_code_join <- NA
  ses_join$note_join <- NA

  # FIND MISMATCHES AND ASK FOR CONSENSUS DECISION ----
  for (variable in seq_len(nrow(ses_join))) {
    consensus <- consensus_on_mismatch(ses_join, table_df, variable,
                                       max(df_plots$code$code))
    ses_join$domain_code_join[variable] <- consensus$domain_code_join
    ses_join$note_join[variable] <- consensus$note_join
  } # end of loop for variable

  # SAVE TO NEW CSV ----
  output_fname <- file.path(output_dir,
                            paste0("CONSENSUS_MAPPING_",
                                   gsub(" ", "", dataset_name), "_",
                                   table_name, "_",
                                   timestamp_now_fname, ".csv"))

  write.csv(ses_join, output_fname, row.names = FALSE)

  if (!quiet) {
    cli_alert_success("Consensus categorisations saved to: {output_fname}")
  }
}
