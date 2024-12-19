test_that("metadata_map function works correctly with user input", {
  # Setup
  temp_dir <- withr::local_tempdir()

  demo_log_output <- system.file("outputs/MAPPING_LOG_360_NationalCommunityChildHealthDatabase(NCCHD)_CHILD_2024-12-19-14-11-55.csv", package = "browseMetadata")
  demo_output <- system.file("outputs/MAPPING_360_NationalCommunityChildHealthDatabase(NCCHD)_CHILD_2024-12-19-14-11-55.csv", package = "browseMetadata")
  demo_bar <- system.file("outputs/BAR_360_NationalCommunityChildHealthDatabase(NCCHD)_2024-12-19-14-11-55.csv", package = "browseMetadata")
  # IMPROVE - also test MAPPING_PLOT_360_NationalCommunityChildHealthDatabase(NCCHD)_CHILD_2024-12-19-14-11-55.png
  # IMPROVE - also test BAR_360_NationalCommunityChildHealthDatabase(NCCHD)_2024-12-19-14-11-55.html

  # Mock functions
  local_mocked_bindings(
    readline = function(prompt) {
      response <- switch(prompt,
        "Press 'Esc' key to finish here, or press any other key to continue with mapping variables" = "1", # line 108
        "Enter your initials: " = "rs", # line 127
        "Optional free text note about this table (or press enter to continue): " = "demo run" # line 147
      )
    }
  )

    local_mocked_bindings(
      menu = function(choices, graphics = FALSE, title = NULL) {
        response <- switch(title,
                           "Enter the table numbers you want to process:" = 4,
                           "\nWould you like to review your categorisations?" = 0 # IMPROVE - could test this with not 0
        )
        return(response)
      })


  local_mocked_bindings(
    user_categorisation_loop = function(start_v, end_v, table_df, df_prev_exist, df_prev, lookup, df_plots, output_df) {
      output_df <- read.csv(demo_output)
      output_df$timestamp <- NA
      output_df$table <- NA
      return(output_df)
    }
  )

  local_mocked_bindings(
    select.list = function(choices, preselect = NULL, multiple = FALSE, title = NULL, graphics = getOption("menu.graphics"), inline = getOption("menu.graphics")) {
      response <- switch(title,
                         "\nSelect those you want to manually edit:" = character(0) # IMPROVE - could test this with not 0
      )
      return(response)
    })

  # Run the map.R function
  metadata_map(output_dir = temp_dir, table_copy = FALSE, long_output = FALSE) # IMPROVE - could test with TRUE

  # Dynamically determine the filenames generated during the test run
  log_file <- list.files(temp_dir, pattern = "MAPPING_LOG_360_NationalCommunityChildHealthDatabase\\(NCCHD\\)_CHILD_.*\\.csv", full.names = TRUE)
  output_file <- list.files(temp_dir, pattern = "MAPPING_360_NationalCommunityChildHealthDatabase\\(NCCHD\\)_CHILD_.*\\.csv", full.names = TRUE)
  bar_file <- list.files(temp_dir, pattern = "BAR_360_NationalCommunityChildHealthDatabase\\(NCCHD\\)_.*\\.csv", full.names = TRUE)

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
  expected_log_output$browseMetadata <- NULL
  actual_log_output$browseMetadata <- NULL
  expected_output$timestamp <- NULL
  actual_output$timestamp <- NULL

  # Test that the outputs are the same
  expect_equal(actual_log_output, expected_log_output)
  expect_equal(actual_output, expected_output)
  expect_equal(actual_bar, expected_bar)
})
