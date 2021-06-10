### Download data for unit testing fetch_all_contributions.R

# Imports ---------------------------------------------------------------------

source("tests/testthat/validate.R")

# Mocks data ------------------------------------------------------------------

#' Fetch mocks data for unit tests of fetch_all_contributions
#' @keywords internal

get_all_contributions_mocks_data <- function() {

  # Get contribution data for a test period: 20 to 27 May 2021
  url <- "https://search.parliament.uk/export?q=type%3A%22Members%27+contributions%22+date%3A20%2F05%2F2021..27%2F05%2F2021+session%3A21%2F22+legislature%3A%22House+of+Commons%22-status%3A%28withdrawn+OR+tabled%29"
  m <- download_csv(url)
  write(m, "fetch_all_contributions_mocks_data")
}

# Validation data -------------------------------------------------------------

#' Fetch validation data for unit tests of fetch_all_contributions
#'
#' @keywords internal

get_all_contributions_validation_data <- function() {

  # Download all_contributions data
  m <- fetch_all_contributions("2021-05-20", "2021-05-27", 21, 22)
  write(m, "fetch_all_contributions_data")
}

# Fetch all data --------------------------------------------------------------

#' Fetch mocks and validation data for unit tests of fetch_all_contributions
#'
#' @keywords internal

get_all_contributions_test_data <- function() {
  get_all_contributions_mocks_data()
  get_all_contributions_validation_data()
}
