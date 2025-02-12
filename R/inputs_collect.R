#' data_load
#'
#' Internal Function: Called within the metadata_map function. \cr \cr
#' Collects inputs needed for metadata_map function (defaults or user inputs)
#' If some inputs are NULL, it loads the default inputs. If defaults not
#' available, it prints error for the user.
#' If inputs are not NULL, it loads the user-specified inputs.
#' @param csv_file As defined in metadata_map
#' @param domain_file As defined in metadata_map
#' @param look_up_file As defined in metadata_map
#' @return A list of 6: all inputs needed for the metadata_map function to run.
#' @keywords internal
#' @importFrom cli cli_alert_info cli_alert_danger
#' @importFrom utils read.csv
#' @importFrom tools file_path_sans_ext

data_load <- function(csv_file, domain_file, look_up_file) {
  # Collect metadata and domains
  if (is.null(csv_file) && is.null(domain_file)) {
    metadata <- get("metadata")
    metadata_desc <- "360_NCCHD"
    domains <- get("domain_list")
    domain_list_desc <- "DemoList"
    cli_alert_info("Running demo mode using package data files")
    demo_mode <- TRUE
  } else if (is.null(csv_file) || is.null(domain_file)) {
    cli_alert_danger("Provide both csv & domain file (or neither to run demo)")
    stop()
  } else { # read in user specified files
    demo_mode <- FALSE
    metadata <- read.csv(csv_file)
    metadata_base <- basename(csv_file)
    metadata_base_0suffix <- sub("_Metadata.csv$", "", metadata_base)
    metadata_desc <- gsub(" ", "", metadata_base_0suffix)
    domains <- read.csv(domain_file, header = FALSE)
    domain_list_desc <- file_path_sans_ext(basename(domain_file))
  }

  # Collect look up table
  if (is.null(look_up_file)) {
    cli_alert_info("Using the default look-up table in data/look-up.rda")
    lookup <- get("look_up")
  } else {
    lookup <- read.csv(look_up_file)
    cli_alert_info("Using look up file inputted by user")
  }

  list(metadata = metadata,
       metadata_desc = metadata_desc,
       domains = domains,
       domain_list_desc = domain_list_desc,
       demo_mode = demo_mode,
       lookup = lookup)
}

#' output_copy
#'
#' Internal Function: Called within the metadata_map function. \cr \cr
#' Searches for previous OUTPUT files in the output_dir, that match the dataset
#' name. \cr \cr
#' If files exist, it removes duplicates and autos, and stores the rest of the
#' data elements in a dataframe. \cr \cr
#'
#' @param dataset_name Name of the dataset
#' @param output_dir Output directory to be searched
#' @return It returns a list of 2: df_prev_exist (a boolean) and df_prev
#' (NULL or populated with data elements to copy)
#' @keywords internal
#' @importFrom dplyr %>% distinct
#' @importFrom cli cli_alert_info

output_copy <- function(dataset_name, output_dir) {
  o_search <- paste0("^MAPPING_", gsub(" ", "", dataset_name), "*")
  csv_list <- data.frame(file = list.files(output_dir, pattern = o_search))
  if (nrow(csv_list) != 0) {
    df_list <- lapply(file.path(output_dir, csv_list$file), read.csv)
    df_prev <- do.call("rbind", df_list) # combine all df
    ## make a new date column, order by earliest, remove duplicates & auto
    df_prev$time2 <- as.POSIXct(df_prev$timestamp, format = "%Y-%m-%d-%H-%M-%S")
    df_prev <- df_prev[order(df_prev$time2), ]
    df_prev <- df_prev %>% distinct(data_element, .keep_all = TRUE)
    df_prev <- df_prev[-(which(df_prev$note %in% "AUTO CATEGORISED")), ]
    df_prev_exist <- TRUE
    cli_alert_info(paste0("Copying from previous session(s):\n",
                          paste(csv_list$file, collapse = "\n"),"\n\n"))
  } else {
    df_prev <- NULL
    df_prev_exist <- FALSE
  }

  copy_prev <- list(df_prev = df_prev, df_prev_exist = df_prev_exist)
  copy_prev
}
