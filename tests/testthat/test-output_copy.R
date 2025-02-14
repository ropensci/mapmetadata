test_that("output_copy works correctly when there are files to copy from", {
  # Create a temporary directory
  temp_dir <- withr::local_tempdir()

  # Create test CSV files
  # Criteria for test files: one must have 'AUTO CATEGORISED' as Note,
  # overlap in variables across files, different timestamps across files)
  utils::write.csv(data.frame(timestamp = "2024-08-22-13-35-40",
                              variable = c("Variable1", "Variable2"),
                              note = c("note1", "note2")),
    file = file.path(temp_dir, "MAPPING_TestDataset_1.csv"), row.names = FALSE
  )
  utils::write.csv(data.frame(timestamp = "2024-09-22-13-00-05",
                              variable = c("Variable1", "Variable3"),
                              note = c("note3", "note4")),
    file = file.path(temp_dir, "MAPPING_TestDataset_2.csv"), row.names = FALSE
  )
  utils::write.csv(data.frame(timestamp = "2024-10-22-11-12-02",
                              variable = c("Variable4", "Variable2"),
                              note = c("AUTO CATEGORISED", "note5")),
    file = file.path(temp_dir, "MAPPING_TestDataset_3.csv"), row.names = FALSE
  )

  # Call the function
  result <- output_copy("TestDataset", temp_dir)

  # Check the results
  expect_true(result$df_prev_exist)
  expect_equal(nrow(result$df_prev), 3)
  expect_equal(result$df_prev$timestamp,
               c("2024-08-22-13-35-40",
                 "2024-08-22-13-35-40", "2024-09-22-13-00-05"))
  expect_equal(result$df_prev$variable,
               c("Variable1", "Variable2", "Variable3"))
  expect_equal(result$df_prev$note, c("note1", "note2", "note4"))
})

test_that("output_copy works correctly when there are no files to copy from", {
  # Create a temporary directory
  temp_dir <- withr::local_tempdir()

  # Call the function
  result <- output_copy("TestDataset", temp_dir)

  # Check the results
  expect_null(result$df_prev)
  expect_false(result$df_prev_exist)
})
