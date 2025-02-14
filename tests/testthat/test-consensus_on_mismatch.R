test_that("consensus_on_mismatch handles mismatch correctly", {
  # Mock the user_categorisation function
  local_mocked_bindings(user_categorisation = function(var = NULL,
                                                       desc = NULL,
                                                       type = NULL,
                                                       domain_code_max = NULL) {
    return(list(decision = "mock_decision", decision_note = "mock_note"))
  })

  # Mock data
  ses_join <- data.frame(
    domain_code_ses1 = c("1", "1,2"),
    domain_code_ses2 = c("1", "2"),
    variable = c("Variable1", "Variable2"),
    note_ses1 = c("Note1", "Note2"),
    note_ses2 = c("Note3", "Note4"),
    stringsAsFactors = FALSE
  )

  table_df <- data.frame(
    label = c("Variable1", "Variable2"),
    description = c("Description1", "Description2"),
    type = c("Type1", "Type2"),
    stringsAsFactors = FALSE
  )

  table_var <- 2
  domain_code_max <- 5

  # Call the function
  result <- consensus_on_mismatch(ses_join, table_df, table_var,
                                  domain_code_max)

  # Check the result
  expect_equal(result$domain_code_join, "mock_decision")
  expect_equal(result$note_join, "mock_note")
})

test_that("consensus_on_mismatch handles no mismatch correctly", {
  # Mock data
  ses_join <- data.frame(
    domain_code_ses1 = c("2", "2,4"),
    domain_code_ses2 = c("2", "2,4"),
    variable = c("Variable1", "Variable2"),
    note_ses1 = c("Note1", "Note2"),
    note_ses2 = c("Note3", "Note4"),
    stringsAsFactors = FALSE
  )

  table_df <- data.frame(
    label = c("Variable1", "Variable2"),
    description = c("Description1", "Description2"),
    type = c("Type1", "Type2"),
    stringsAsFactors = FALSE
  )

  table_var <- 2
  domain_code_max <- 5

  # Call the function
  result <- consensus_on_mismatch(ses_join, table_df, table_var,
                                  domain_code_max)

  # Check the result
  expect_equal(result$domain_code_join, "2,4")
  expect_equal(result$note_join, "No mismatch!")
})
