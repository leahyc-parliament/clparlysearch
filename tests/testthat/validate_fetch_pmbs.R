### Download data for unit testing fetch_pmbs.R

# Imports ---------------------------------------------------------------------

source("tests/testthat/validate.R")

# Mocks data ------------------------------------------------------------------

#' Fetch mocks data for unit tests of fetch_pmbs
#'
#' @keywords internal

fetch_pmbs_mocks_data <- function() {

  # Download fetch_pmbs for test Session 19-21
  url <- "https://search.parliament.uk/export?q=type%3A%22Private+members%27+bills%22+session%3A19%2F21+legislature%3A%22House+of+Commons%22"

  m <- download_csv(url)
  write(m, "fetch_pmbs_mocks_data")
}

# Validation data -------------------------------------------------------------

#' Fetch validation data for unit tests of fetch_pmbs
#'
#' @keywords internal

fetch_pmbs_validation_data <- function() {

  # Download get_member_data
  m <- fetch_pmbs(19, 21)
  write(m, "fetch_pmbs_data")
}

# Fetch all data --------------------------------------------------------------

#' Fetch mocks and validation data for unit tests of fetch_pmbs
#'
#' @keywords internal

fetch_pmbs_test_data <- function() {
  fetch_pmbs_mocks_data()
  fetch_pmbs_validation_data()
}
