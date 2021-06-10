### Download data for unit testing fetch_questions.R

# Imports ---------------------------------------------------------------------

source("tests/testthat/validate.R")

# Mocks data ------------------------------------------------------------------

#' Fetch mocks data for unit tests of fetch_questions
#' @keywords internal

fetch_questions_mocks_data <- function() {

  # Get questions data for a test period: 2-9 March 2020
  url <- "https://search.parliament.uk/export?q=type%3A%22Parliamentary+questions%22+status%3A%28tabled+OR+answered+OR+holding%29+date%3A02%2F03%2F2020..09%2F03%2F2020+session%3A19%2F21+legislature%3A%22House+of+Commons%22"
  m <- download_csv(url)
  write(m, "fetch_questions_mocks_data")
}

# Validation data -------------------------------------------------------------

#' Fetch validation data for unit tests of fetch_questions
#'
#' @keywords internal

fetch_questions_validation_data <- function() {

  m <- fetch_questions("2020-03-02", "2020-03-09", 19, 21)
  write(m, "fetch_questions_data")
}

# Fetch all data --------------------------------------------------------------

#' Fetch mocks and validation data for unit tests of fetch_questions
#'
#' @keywords internal
#'

fetch_questions_test_data <- function() {
  fetch_questions_mocks_data()
  fetch_questions_validation_data()
}
