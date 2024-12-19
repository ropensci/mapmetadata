# Unit test for empty_plot function
test_that("empty_plot function works correctly", {

  # Mock input dataframe
  dataframe <- data.frame(
    Table = c("BLOOD_TEST", "BLOOD_TEST", "BREAST_FEEDING", "BREAST_FEEDING",
              "CHE_HEALTHYCHILDWALESPROGRAMME", "CHE_HEALTHYCHILDWALESPROGRAMME"),
    Empty = c("No", "Yes", "No", "Yes","No", "Yes"),
    N_Variables = c(6, 2, 6, 2, 8, 32))
  n_tables <- 3

  # Call the function
  result <- empty_plot(dataframe,n_tables)

  # Check the structure of the result
  expect_true(is.list(result))

  # Check if the result is a plotly object
  expect_true("plotly" %in% class(result))

})
