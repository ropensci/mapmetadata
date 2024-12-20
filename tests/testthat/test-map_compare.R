test_that("map_compare function works correctly with user input", {
  # Setup
  temp_dir <- withr::local_tempdir()

  demo_session_dir <- system.file("outputs", package = "mapmetadata")
  demo_session1_base <- "360_NationalCommunityChildHealthDatabase(NCCHD)_CHILD_2024-12-19-14-11-55"
  demo_session2_base <- "360_NationalCommunityChildHealthDatabase(NCCHD)_CHILD_2024-12-19-14-17-45"
  demo_metadata_file <- system.file("inputs", "360_NationalCommunityChildHealth Database(NCCHD)_Structural_Metadata.csv", package = "mapmetadata")
  demo_domain_file <- system.file("inputs", "domain_list_demo.csv", package = "mapmetadata")

  # mock concensus_on_mismatch
  local_mocked_bindings(
    concensus_on_mismatch = function(ses_join, table_df, datavar, domain_code_max) {
      domain_code_join <- "0"
      note_join <- "concensus note"
      return(list(domain_code_join = domain_code_join, note_join = note_join))
    }
  )

  # Run the function - requires user interaction
  map_compare(
    session_dir = demo_session_dir,
    session1_base = demo_session1_base,
    session2_base = demo_session2_base,
    metadata_file = demo_metadata_file,
    domain_file = demo_domain_file,
    output_dir = temp_dir
  )

  consensus_files <- list.files(temp_dir, pattern = "^CONSENSUS_", full.names = TRUE)
  concensus_df <- read.csv(consensus_files[1])
  demo_1_df <- read.csv(paste0(demo_session_dir, "/", "MAPPING_", demo_session1_base, ".csv"))
  demo_2_df <- read.csv(paste0(demo_session_dir, "/", "MAPPING_", demo_session2_base, ".csv"))

  expect_equal(nrow(concensus_df), 20)
  expect_equal(ncol(concensus_df), 13)
  expect_true(all(concensus_df$domain_code_join == 0))
  expect_true(all(concensus_df$note_join == "concensus note"))
  expect_equal(demo_1_df$data_element, concensus_df$data_element)
  expect_equal(demo_2_df$data_element, concensus_df$data_element)
  expect_equal(demo_1_df$timestamp, concensus_df$timestamp_ses1)
  expect_equal(demo_1_df$table, concensus_df$table_ses1)
  expect_equal(demo_1_df$data_element_n, concensus_df$data_element_n_ses1)
  expect_equal(demo_1_df$domain_code, concensus_df$domain_code_ses1)
  expect_equal(demo_1_df$note, concensus_df$note_ses1)
  expect_equal(demo_2_df$timestamp, concensus_df$timestamp_ses2)
  expect_equal(demo_2_df$table, concensus_df$table_ses2)
  expect_equal(demo_2_df$data_element_n, concensus_df$data_element_n_ses2)
  expect_equal(demo_2_df$domain_code, concensus_df$domain_code_ses2)
  expect_equal(demo_2_df$note, concensus_df$note_ses2)
})
