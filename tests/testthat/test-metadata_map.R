test_that("metadata_map function works correctly with user input", {
  # Setup
  temp_dir <- withr::local_tempdir()

  demo_log_output <-
    system.file("outputs/MAPPING_LOG_360_NCCHD_CHILD_2025-02-14-18-14-01.csv",
                package = "mapmetadata")
  demo_output <-
    system.file("outputs/MAPPING_360_NCCHD_CHILD_2025-02-14-18-14-01.csv",
                package = "mapmetadata")

  demo_bar <- system.file("outputs/BAR_360_NCCHD_2025-02-14-18-14-01.csv",
                          package = "mapmetadata")

  # IMPROVE - also test MAPPING_PLOT_360_NCCHD_CHILD_2025-02-14-18-14-01.png
  # IMPROVE - also test BAR_360_NCCHD_2025-02-14-18-14-01.html

  # Mock functions
  local_mocked_bindings(
    readline = function(prompt) {
      response <- switch(prompt,
        "Optional note about this table: " = "demo run 1"
      )
    }
  )

  local_mocked_bindings(
    menu = function(choices, graphics = FALSE, title = NULL) {
      response <- switch(title,
        "Enter the table number you want to process:" = 4,
        "\nWould you like to review your categorisations?" = 0 #IMPROVE, !=0
      )
      return(response)
    }
  )


  local_mocked_bindings(
    user_categorisation_loop = function(start_v, end_v, table_df, df_prev_exist,
                                        df_prev, lookup, df_plots, output_df,
                                        quiet) {
      output_df <- read.csv(demo_output)
      output_df$timestamp <- NA
      output_df$table <- NA
      return(output_df)
    }
  )

  local_mocked_bindings(
    select.list = function(choices, preselect = NULL, multiple = FALSE,
                           title = NULL, graphics = getOption("menu.graphics"),
                           inline = getOption("menu.graphics")) {
      response <- switch(title,
        "\nSelect those you want to manually edit:" = character(0)#IMPROVE, !=0
      )
      return(response)
    }
  )

  # Run the map.R function
  metadata_map(output_dir = temp_dir, table_copy = FALSE, long_output = FALSE)
  # IMPROVE - could test with TRUE

  # Dynamically determine the filenames generated during the test run
  log_file <- list.files(temp_dir,
                         pattern = "MAPPING_LOG_360_NCCHD_CHILD_.*\\.csv",
                         full.names = TRUE)
  output_file <- list.files(temp_dir,
                            pattern = "MAPPING_360_NCCHD_CHILD_.*\\.csv",
                            full.names = TRUE)
  bar_file <- list.files(temp_dir, pattern = "BAR_360_NCCHD_.*\\.csv",
                         full.names = TRUE)

  # Read the expected and actual output files
  expected_log_output <- read.csv(demo_log_output)
  actual_log_output <- read.csv(log_file)

  expected_output <- read.csv(demo_output)
  actual_output <- read.csv(output_file)

  expected_bar <- read.csv(demo_bar)
  actual_bar <- read.csv(bar_file)

  # Remove the timestamp and package version columns for comparison
  expected_log_output$timestamp <- NULL
  actual_log_output$timestamp <- NULL
  expected_log_output$mapmetadata <- NULL
  actual_log_output$mapmetadata <- NULL
  expected_output$timestamp <- NULL
  actual_output$timestamp <- NULL

  # Test that the outputs are the same
  expect_equal(actual_log_output, expected_log_output)
  expect_equal(actual_output, expected_output)
  expect_equal(actual_bar, expected_bar)
})


test_that("metadata_map errors with incorrect output_dir", {
  expect_error(metadata_map(output_dir = "non_existent_directory"),
               "The output_dir does not exist.")
})

test_that("metadata_map errors with non-boolean table_copy", {
  expect_error(metadata_map(table_copy = "not_boolean"),
               paste("table_copy, long_output and quiet should take the value",
                     "of 'TRUE' or 'FALSE'"))
})

test_that("metadata_map errors with non-boolean long_output", {
  expect_error(metadata_map(long_output = "not_boolean"),
               paste("table_copy, long_output and quiet should take the value",
                     "of 'TRUE' or 'FALSE'"))
})

test_that("metadata_map errors with non-boolean quiet", {
  expect_error(metadata_map(quiet = "not_boolean"),
               paste("table_copy, long_output and quiet should take the value",
                     "of 'TRUE' or 'FALSE'"))
})

test_that("metadata_map errors with non-integer demo_number", {
  expect_error(metadata_map(demo_number = "not_integer"),
               "demo_number should be an integer of 5 or greater")
})

test_that("metadata_map errors with demo_number <= 5", {
  expect_error(metadata_map(demo_number = 4),
               "demo_number should be an integer of 5 or greater")
})
