# Define file paths to demo data relative to the package directory
demo_csv_file <- system.file("inputs/360_NCCHD_Metadata.csv",
                             package = "mapmetadata")
look_up_file <- system.file("inputs/look_up.csv",
                            package = "mapmetadata")
demo_domain_file <- system.file("inputs/domain_list_demo.csv",
                                package = "mapmetadata")

# Define package demo data
metadata <- get("metadata")
look_up <- get("look_up")
domains <- get("domain_list")

# Print file paths for debugging
cat("demo_csv_file:", demo_csv_file, "\n")
cat("look_up_file:", look_up_file, "\n")
cat("demo_domain_file:", demo_domain_file, "\n")

# Check if files exist for debugging
cat("demo_csv_file exists:", file.exists(demo_csv_file), "\n")
cat("look_up_file exists:", file.exists(look_up_file), "\n")
cat("demo_domain_file exists:", file.exists(demo_domain_file), "\n")

test_that("data_load runs in demo mode when both csv_file and domain_file are
          NULL", {
            result <- data_load(NULL, NULL, NULL)
            expect_true(result$demo_mode)
            expect_equal(result$metadata, metadata)
            expect_equal(result$domains, domains)
            expect_equal(result$domain_list_desc, "DemoList")
          })

test_that("data_load reads user-specified files correctly", {
  result <- data_load(demo_csv_file, demo_domain_file, NULL)
  expect_false(result$demo_mode)
  expect_true(is.list(result$metadata))
  expect_true(is.data.frame(result$domains))
  expect_equal(result$domain_list_desc,
               tools::file_path_sans_ext(basename(demo_domain_file)))
})

test_that("data_load uses default look-up table when look_up_file is NULL", {
  result <- data_load(demo_csv_file, demo_domain_file, NULL)
  expect_equal(result$lookup, look_up)
})

test_that("data_load reads user-specified look-up table correctly", {
  result <- data_load(demo_csv_file, demo_domain_file, look_up_file)
  expect_true(is.data.frame(result$lookup))
  expect_equal(nrow(result$lookup), nrow(utils::read.csv(look_up_file)))
})

test_that("data_load errors when quiet is not boolean", {
  expect_error(data_load(NULL, NULL, NULL, quiet = "not valid"),
               "quiet should take the value of 'TRUE' or 'FALSE'")
})

test_that("data_load errors when  metadata_file is incorrect format", {
  expect_error(data_load(metadata_file = "Metadata_360NCCHD.csv",
                         demo_domain_file),
               paste("Metadata file name must be a .csv file in the format",
                     "ID_Name_Metadata.csv where ID is an integer"))
})

test_that("data_load errors when metadata_file does not exist", {
  expect_error(data_load(metadata_file = "360_NCCHD_Metadata.csv",
                         demo_domain_file),
               "Metadata filename is the correct format but it does not exist!")
})

test_that("data_load errors when domain_file does not exist", {
  expect_error(data_load(demo_csv_file, domain_file = "not valid"),
               "This domain_file does not exist or is not in csv format.")
})

test_that("data_load errors when metadata_file does not exist", {
  expect_error(data_load(demo_csv_file, demo_domain_file,
                         look_up_file = "not valid"),
               "This look_up_file does not exist or is not in csv format.")
})
