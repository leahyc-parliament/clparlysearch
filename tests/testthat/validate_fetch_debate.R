### Download data for unit testing fetch_debate.R

# Imports ---------------------------------------------------------------------

source("tests/testthat/validate.R")

# Mocks data ------------------------------------------------------------------

#' Fetch mocks data for unit tests of fetch_debate
#'
#' @keywords internal

fetch_debate_mocks_data <- function() {

  # Download debate on Australian Exports (Tariffs)
  url <- "https://search.parliament.uk/export?q=title%3A%22Agricultural%20Exports%20from%20Australia%3a%20Tariffs%22+type%3A%22Proceeding+contributions%22+date%3A27%2F05%2F2021+session%3A21%2F22+legislature%3A%22House+of+Commons%22"
  m <- download_csv(url)
  write(m, "fetch_debate_mocks_data")
}

# Validation data -------------------------------------------------------------

#' Fetch validation data for unit tests of fetch_debate
#'
#' @keywords internal

fetch_debate_validation_data <- function() {

  # Download fetch_debate validation data
  m <- fetch_debate("Agricultural Exports from Australia: Tariffs", "2021-05-27", 21, 22)
  write(m, "fetch_debate_data")
}

# Fetch all data --------------------------------------------------------------

#' Fetch mocks and validation data for unit tests of fetch_debate
#'
#' @keywords internal

fetch_debate_test_data <- function() {
  fetch_debate_mocks_data()
  fetch_debate_validation_data()
}
