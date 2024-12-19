# Define file paths to demo data relative to the package directory
csv_file <- system.file("inputs/360_National Community Child Health Database (NCCHD)_Structural_Metadata.csv", package = "browseMetadata")
look_up_file <- system.file("inputs/look_up.csv", package = "browseMetadata")
domains_file <- system.file("inputs/domain_list_demo.csv", package = "browseMetadata")

# Define package demo data
metadata <- get("metadata")
look_up <- get("look_up")
domains <- get("domain_list")

test_that("data_load runs in demo mode when both csv_file and domain_file are NULL", {
  result <- data_load(NULL, NULL, NULL)
  expect_true(result$demo_mode)
  expect_equal(result$metadata, metadata)
  expect_equal(result$domains, domains)
  expect_equal(result$domain_list_desc, "DemoList")
})

test_that("data_load throws error if only one of csv_file or domain_file is NULL", {
  expect_error(data_load(csv_file, NULL, NULL))
  expect_error(data_load(NULL, domains_file, NULL))
})

test_that("data_load reads user-specified files correctly", {
  result <- data_load(csv_file, domains_file, NULL)
  expect_false(result$demo_mode)
  expect_true(is.list(result$metadata))
  expect_true(is.data.frame(result$domains))
  expect_equal(result$domain_list_desc, tools::file_path_sans_ext(basename(domains_file)))
})

test_that("data_load uses default look-up table when look_up_file is NULL", {
  result <- data_load(csv_file, domains_file, NULL)
  expect_equal(result$lookup, look_up)
})

test_that("data_load reads user-specified look-up table correctly", {
  result <- data_load(csv_file, domains_file, look_up_file)
  expect_true(is.data.frame(result$lookup))
  expect_equal(nrow(result$lookup), nrow(utils::read.csv(look_up_file)))
})
