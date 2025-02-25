test_that("user_categorisation works with valid input", {

  # replace `readline` function within the `user_categorisation` function with
  # the `helper-mock_factory.R` mock object
  local_mocked_bindings(
    readline = helper_mock("3", "This is a note", "n")
  )

  response <- user_categorisation(var = "Variable1",
                                  desc = "Description1",
                                  type = "Type1", domain_code_max = 5)
  expect_equal(response, list(decision = "3", decision_note = "This is a note"))
})

test_that("user_categorisation handles invalid input and then valid input", {
  local_mocked_bindings(
    readline = helper_mock("6", "3", "This is a note", "n")
  )

  response <- user_categorisation(var = "Variable1",
                                  desc = "Description1",
                                  type = "Type1", domain_code_max = 5)
  expect_equal(response, list(decision = "3", decision_note = "This is a note"))
})

test_that("user_categorisation handles multiple valid inputs", {
  local_mocked_bindings(
    readline = helper_mock("3,4", "This is another note", "n")
  )
  response <- user_categorisation(var = "Variable1",
                                  desc = "Description1",
                                  type = "Type1", domain_code_max = 5)
  expect_equal(response, list(decision = "3,4",
                              decision_note = "This is another note"))
})

test_that("user_categorisation handles re-do input", {
  local_mocked_bindings(
    readline = helper_mock("3", "This is a note", "y", "4",
                           "Another note", "n")
  )

  response <- user_categorisation(var = "Variable1",
                                  desc = "Description1",
                                  type = "Type1", domain_code_max = 5)
  expect_equal(response, list(decision = "4", decision_note = "Another note"))
})
