readline <- NULL
scan <- NULL

#' Internal: user_categorisation
#'
#' Internal Function: Called within the metadata_map function. \cr \cr
#' It displays data properties to the user and requests a categorisation into
#' a domain. \cr \cr
#' An optional note can be included with the categorisation.
#'
#' @param data_element Name of the variable
#' @param data_desc Description of the variable
#' @param data_type Data type of the variable
#' @param domain_code_max Max code in the domain list (0-3 auto included,
#' then N included via domain_file)
#' @keywords internal
#' @return It returns a list containing the decision and decision note
#' @importFrom cli cli_alert_warning

user_categorisation <- function(data_element, data_desc, data_type,
                                domain_code_max) {
  first_run <- TRUE
  go_back <- ""

  while (go_back == "Y" || go_back == "y" || first_run == TRUE) {
    go_back <- ""
    # print text to R console
    cat(paste(
      "\nDATA ELEMENT -----> ", data_element,
      "\n\nDESCRIPTION -----> ", data_desc,
      "\n\nDATA TYPE -----> ", data_type, "\n\n"
    ))

    # ask user for categorisation:

    decision <- ""
    validated <- FALSE

    while (decision == "" || validated == FALSE) {
      decision <- readline(paste("Categorise data element into domain(s).",
                                 "E.g. 3 or 3,4: "))

      # validate input given by user
      decision_int <- as.integer(unlist(strsplit(decision, ",")))
      decision_int_na <- any(is.na((decision_int)))
      suppressWarnings(decision_int_max <- max(decision_int, na.rm = TRUE))
      suppressWarnings(decision_int_min <- min(decision_int, na.rm = TRUE))
      if (decision_int_na == TRUE || decision_int_max > domain_code_max ||
            decision_int_min < 0) {
        cli_alert_warning("Formatting is invalid or integer out of range.
                          Provide one integer or a comma seperated list of
                          integers.")
        validated <- FALSE
      } else {
        validated <- TRUE
        # standardize output
        decision_int <- sort(decision_int)
        decision <- paste(decision_int, collapse = ",")
      }
    }

    # ask user for note on categorisation:

    decision_note <- readline(paste("Categorisation note (or press enter to",
                                    "continue): "))

    while (go_back != "Y" && go_back != "y" && go_back
           != "N" && go_back != "n") {
      go_back <- readline(prompt = paste("Response to be saved is '",
                                         decision,
                                         "'. Would you like to re-do?",
                                         "(y/n): "))
    }

    first_run <- FALSE
  }

  return(list(decision = decision, decision_note = decision_note))
}

#' Internal: user_categorisation_loop
#'
#' Internal Function: Called within the metadata_map function. \cr \cr
#' Given a specific table and a number of data elements to search, it checks for
#' 3 different sources of domain categorisation: \cr \cr
#' 1 - If data elements match look-up table, auto categorise \cr \cr
#' 2 - If data elements match to previous table output, copy them \cr \cr
#' 3 - If no match for 1 or 2, data elements are categorised by the user \cr \cr
#' @param start_v Index of data element to start
#' @param end_v Index of data element to end
#' @param table_df Dataframe with table info, extracted from metadata file
#' @param df_prev_exist Boolean to indicate if previous dataframes exists
#' @param df_prev Previous dataframes to copy from (or NULL)
#' @param lookup The lookup table to enable auto categorisations
#' @param df_plots Output from ref_plot, to indicate mac domain code allowed
#' @param output_df Empty output dataframe, to fill
#' @return An output dataframe containing info about the table, data elements
#' and categorisations
#' @keywords internal
#' @importFrom dplyr %>% add_row
#' @importFrom cli cli_alert_info

user_categorisation_loop <- function(start_v, end_v, table_df, df_prev_exist,
                                     df_prev, lookup, df_plots, output_df) {
  for (data_v in start_v:end_v) {
    cli_alert_info(paste(length(data_v:end_v), "left to process",
                         "(Data element {data_v} of {nrow(table_df)})"))
    this_data_element <- table_df$Column.name[data_v]
    this_data_element_n <- paste(
      as.character(data_v), "of",
      as.character(nrow(table_df))
    )
    data_v_index <- which(lookup$data_element ==
                            table_df$Column.name[data_v]) # improve: ignore case
    lookup_subset <- lookup[data_v_index, ]
    ##### search if data element matches any data elements from previous table
    if (df_prev_exist == TRUE) {
      data_v_index <- which(df_prev$data_element ==
                              table_df$Column.name[data_v])
      df_prev_subset <- df_prev[data_v_index, ]
    } else {
      df_prev_subset <- data.frame()
    }
    ##### decide how to process the data element out of 3 options
    if (nrow(lookup_subset) == 1) {
      ###### 1 - auto categorisation
      output_df <- output_df %>% add_row(
        data_element = this_data_element,
        data_element_n = this_data_element_n,
        domain_code = as.character(lookup_subset$domain_code),
        note = "AUTO CATEGORISED"
      )
    } else if (df_prev_exist == TRUE &&
                 nrow(df_prev_subset) == 1) {
      ###### 2 - copy from previous table
      output_df <- output_df %>% add_row(
        data_element = this_data_element,
        data_element_n = this_data_element_n,
        domain_code = as.character(df_prev_subset$domain_code),
        note = paste0("COPIED FROM: ", df_prev_subset$table)
      )
    } else {
      ###### 3 - collect user responses with 'user_categorisation.R'
      decision_output <- user_categorisation(
        table_df$Column.name[data_v],
        table_df$Column.description[data_v],
        table_df$Data.type[data_v],
        max(df_plots$code$code)
      )
      output_df <- output_df %>% add_row(
        data_element = this_data_element,
        data_element_n = this_data_element_n,
        domain_code = decision_output$decision,
        note = decision_output$decision_note
      )
    }
  } # end of loop for data_element
  output_df
}
