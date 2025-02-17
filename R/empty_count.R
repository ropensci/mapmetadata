#' empty_count
#'
#' Internal Function: Called within the metadata_map function. \cr \cr
#' It reads in the metadata dataframe and counts how many of the variables have
#' empty descriptions.
#' @param dataframe Dataframe representing metadata, 'Section' column as factor
#' @return Returns a long dataframe with 3 columns: Empty (No, Yes),
#' Table (table name), N_Variables (count).
#' @importFrom tidyr pivot_longer
#' @importFrom dplyr %>% group_by summarise mutate select arrange n
#' @keywords internal
#' @family metadata_map_internal
#' @dev generate help files for unexported objects, for developers

empty_count <- function(dataframe) {
  empty_count_df <- dataframe %>%
    group_by(Section) %>%
    summarise(
      empty_count = sum(
                        (nchar(as.character(Column.description)) <= 1) |
                          Column.description %in% c("NA",
                                                    "Description to follow",
                                                    NA)),
      total_variables = n()
    ) %>%
    mutate(
      no_count = total_variables - empty_count
    ) %>%
    select(Section, no_count, empty_count) %>%
    pivot_longer(cols = c(no_count, empty_count), names_to = "Empty",
                 values_to = "N_Variables") %>%
    mutate(Empty = ifelse(Empty == "empty_count", "Yes", "No")) %>%
    arrange(Section)

  # Rename the Section column to Table
  colnames(empty_count_df)[colnames(empty_count_df) == "Section"] <- "Table"

  empty_count_df
}
