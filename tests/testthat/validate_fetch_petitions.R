### Download data for unit testing fetch_petitions.R

# Imports ---------------------------------------------------------------------

source("tests/testthat/validate.R")

# Mocks data ------------------------------------------------------------------

#' Fetch mocks data for unit tests of fetch_petitions
#' @keywords internal

fetch_petitions_mocks_data <- function() {

  # Get petitions data for a test Session:  19-21
  url <- "https://search.parliament.uk/export?q=type%3APetitions+session%3A19%2F21+legislature%3A%22House+of+Commons%22"
  m <- download_csv(url)
  write(m, "fetch_petitions_mocks_data")
}

# Validation data -------------------------------------------------------------

#' Fetch validation data for unit tests of fetch_petitions
#'
#' @keywords internal

fetch_petitions_validation_data <- function() {

  m <- fetch_petitions(19, 21)
  write(m, "fetch_petitions_data")
}

# Fetch all data --------------------------------------------------------------

#' Fetch mocks and validation data for unit tests of fetch_petitions
#'
#' @keywords internal
#'

fetch_petitions_test_data <- function() {
  fetch_petitions_mocks_data()
  fetch_petitions_validation_data()
}
