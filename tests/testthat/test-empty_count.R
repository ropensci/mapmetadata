test_that("empty_count correctly counts empty descriptions", {
  # Sample input data frame
  table_df <- data.frame(
    Section = c("Table1", "Table1", "Table1", "Table2", "Table2", "Table2"),
    Column.name = c("var1", "var2", "var3", "var4", "var5", "var6"),
    Column.description = c("Description to follow", "Valid description", "NA",
                           "Another valid description", " ", "-"),
    Data.type = c("VARCHAR", "BIGINT", "DATE", "TIMESTAMP", "VARCHAR",
                  "VARCHAR"),
    stringsAsFactors = FALSE
  )

  table_df$Section <- as.factor(table_df$Section)

  # Expected output data frame
  expected_output <- tidyr::tibble(
    Table = c("Table1", "Table1", "Table2", "Table2"),
    Empty = c("No", "Yes", "No", "Yes"),
    N_Variables = c(1, 2, 1, 2)
  )

  expected_output$Table <- as.factor(expected_output$Table)

  # Call the function
  result <- empty_count(table_df)

  # Check if the result matches the expected output
  expect_equal(result, expected_output)
})
