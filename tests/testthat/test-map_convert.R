test_that("map_convert function outputs files correctly", {
  # Setup
  temp_dir <- withr::local_tempdir()
  file_in <-
    system.file("outputs/MAPPING_360_NCCHD_CHILD_2024-12-19-14-11-55.csv",
                package = "mapmetadata")
  file_out <-
    system.file("outputs/L-MAPPING_360_NCCHD_CHILD_2024-12-19-14-11-55.csv",
                package = "mapmetadata")

  # Copy the demo input file to the temporary directory
  file.copy(file_in, file.path(temp_dir, basename(file_in)))

  # Run the function
  map_convert(csv_to_convert = basename(file_in), csv_to_convert_dir = temp_dir)

  # Read the expected and actual output files
  expected_output <- read.csv(file_out)
  actual_output <- read.csv(file.path(temp_dir,
                                      paste0("L-", basename(file_in))))

  # Test that the outputs are the same
  expect_equal(actual_output, expected_output)
})
