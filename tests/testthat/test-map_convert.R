test_that("map_convert function outputs files correctly", {
  # Setup
  temp_dir <- withr::local_tempdir()
  file_in <- system.file("outputs/MAPPING_360_NationalCommunityChildHealthDatabase(NCCHD)_CHILD_2024-12-19-14-11-55.csv", package = "browseMetadata")
  file_out <- system.file("outputs/L-MAPPING_360_NationalCommunityChildHealthDatabase(NCCHD)_CHILD_2024-12-19-14-11-55.csv", package = "browseMetadata")

  # Copy the demo input file to the temporary directory
  file.copy(file_in, file.path(temp_dir, basename(file_in)))

  # Run the function
  map_convert(output_csv = basename(file_in), output_dir = temp_dir)

  # Read the expected and actual output files
  expected_output <- read.csv(file_out)
  actual_output <- read.csv(file.path(temp_dir, paste0("L-", basename(file_in))))

  # Test that the outputs are the same
  expect_equal(actual_output, expected_output)
})
