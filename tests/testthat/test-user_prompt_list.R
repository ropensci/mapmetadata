test_that("user_prompt_list works with valid input", {
  mock_scan <- mockery::mock(c(1, 2, 3), cycle = TRUE) # create a mock object that returns a list of integers when called, cycling the same value
  mockery::stub(user_prompt_list, "scan", mock_scan) # replace `scan` function within the `user_prompt_list` function with the `mock_scan` mock object

  response <- user_prompt_list(prompt_text = "Enter numbers: ", list_allowed = 1:5, empty_allowed = FALSE)
  expect_equal(response, c(1, 2, 3))
})

test_that("user_prompt_list handles out of range input and then valid input", {
  mock_scan <- mockery::mock(c(1, 2, 8), c(1, 2, 3)) # create a mock object that returns out-of-range values first, then valid values
  mockery::stub(user_prompt_list, "scan", mock_scan) # replace `scan` function within the `user_prompt_list` function with the `mock_scan` mock object

  response <- user_prompt_list(prompt_text = "Enter numbers: ", list_allowed = 1:5, empty_allowed = FALSE)
  expect_equal(response, c(1, 2, 3)) # expect the valid input after the out-of-range input
})

test_that("user_prompt_list handles empty input when not allowed", {
  mock_scan <- mockery::mock(list(), c(1, 2, 3)) # create a mock object that returns an empty list first, then valid values
  mockery::stub(user_prompt_list, "scan", mock_scan) # replace `scan` function within the `user_prompt_list` function with the `mock_scan` mock object

  response <- user_prompt_list(prompt_text = "Enter numbers: ", list_allowed = 1:5, empty_allowed = FALSE)
  expect_equal(response, c(1, 2, 3)) # expect the valid input after the empty input
})

test_that("user_prompt_list handles empty input when allowed", {
  mock_scan <- mockery::mock(list(), cycle = TRUE) # create a mock object that returns an empty list when called, cycling the same value
  mockery::stub(user_prompt_list, "scan", mock_scan) # replace `scan` function within the `user_prompt_list` function with the `mock_scan` mock object

  response <- user_prompt_list(prompt_text = "Enter numbers: ", list_allowed = 1:5, empty_allowed = TRUE)
  expect_equal(response, list()) # expect an empty list
})

test_that("user_prompt_list exits function when input is 0", {
  mock_scan <- mockery::mock(0) # create a mock object that returns 0 when called
  mockery::stub(user_prompt_list, "scan", mock_scan) # replace `scan` function within the `user_prompt_list` function with the `mock_scan` mock object

  response <- user_prompt_list(prompt_text = "Enter numbers: ", list_allowed = 1:5, empty_allowed = FALSE)
  expect_null(response) # expect NULL when input is 0
})
