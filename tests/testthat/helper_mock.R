# the function below is a function factory, a function that creates and returns
# another function

# it create a mock object that returns user inputs in sequence

# outer function initialises the index. inner function increments counter i
# every time it is called and returns i-th element in the responses vector

# The <<- operator is used to modify the i variable in the parent environment
# (the environment of helper_mock)

# new_mock <- helper_mock("3", "This is a note", "n")
# new_mock()  # [1] "3"
# new_mock()  # [1] "This is a note"
# new_mock()  # [1] "n"
# new_mock()  # [1] NA
# new_mock()  # [1] NA

helper_mock <- function(...) {
  responses <- c(...)
  i <- 0
  function(...) {
    i <<- i + 1
    responses[i]
  }
}
