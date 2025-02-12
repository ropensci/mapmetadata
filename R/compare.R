#' valid_comparison
#'
#' Internal Function: Called within the map_compare.R function. \cr \cr
#' It reads two inputs to see if they are equal. \cr \cr
#' Warning severity: if unequal inputs, gives warning but continues. \cr \cr
#' Danger severity: if unequal inputs, exits with error message. \cr \cr
#'
#' @param input_1 Input 1
#' @param input_2 Input 2
#' @param severity Level of severity. Only 'danger' or 'warning'
#' @param severity_text The text to print if inputs are not equal.
#' @return Returns nothing if inputs are equal. If inputs are not equal,
#' returns variable text depending on level of severity.
#' @keywords internal
#' @importFrom cli cli_alert_warning

valid_comparison <- function(input_1, input_2, severity, severity_text) {
  if (!severity %in% c("danger", "warning")) {
    stop("Invalid severity. Only 'danger' and 'warning' are allowed.")
  }

  if (severity == "danger") {
    if (input_1 != input_2) {
      cat("\n")
      stop(paste(severity_text, "-> Exiting!"))
    }
  } else if (severity == "warning") {
    if (input_1 != input_2) {
      cat("\n")
      cli_alert_warning(
                        paste(
                              severity_text,
                              "-> Continuing, but check comparison is valid!"))
    }
  }
}

#' consensus_on_mismatch
#'
#' Internal Function: Called within the map_compare.R function. \cr \cr
#' For a specific data element, it compares the domain code categorisation
#' between two sessions. If the categorisation differs, it prompts the user for
#' a new consensus decision by presenting the metadata info. \cr \cr
#'
#' @param ses_join The joined dataframes from the two sessions
#' @param table_df Metadata, for one table in the dataset
#' @param datavar Data Element n
#' @param domain_code_max The maximum allowable domain code integer
#' @return Returns list of 2: domain code and note from the consensus decision
#' @keywords internal
#' @importFrom cli cli_alert_warning

consensus_on_mismatch <- function(ses_join, table_df, datavar,
                                  domain_code_max) {
  if (ses_join$domain_code_ses1[datavar]
      != ses_join$domain_code_ses2[datavar]) {
    cat("\n\n")
    cli_alert_warning("Mismatch found, provide concensus decision below.")
    cli_alert_warning(paste("\nDOMAIN CODE (note) for session 1 --> ",
                      ses_join$domain_code_ses1[datavar],
                      "(", ses_join$note_ses1[datavar], ")"))
    cli_alert_warning(paste("\nDOMAIN CODE (note) for session 2 --> ",
                      ses_join$domain_code_ses2[datavar],
                      "(", ses_join$note_ses2[datavar], ")\n"))
    decision_output <- user_categorisation(table_df$Column.name[datavar],
                                           table_df$Column.description[datavar],
                                           table_df$Data.type[datavar],
                                           domain_code_max)
    domain_code_join <- decision_output$decision
    note_join <- decision_output$decision_note
  } else {
    domain_code_join <- ses_join$domain_code_ses1[datavar]
    note_join <- "No mismatch!"
  }
  return(list(domain_code_join = domain_code_join, note_join = note_join))
}
