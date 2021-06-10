### Download data for unit testing fetch_all_contributions.R

# Imports ---------------------------------------------------------------------

source("tests/testthat/validate.R")

# Mocks data ------------------------------------------------------------------

#' Fetch mocks data for unit tests of fetch_all_contributions
#' @keywords internal

get_all_contributions_mocks_data <- function() {

  # Get contribution data for a test period: 16 Dec 2019 to 31 March 2020
  url_base <- paste0("+session%3A19%2F21+legislature%3A%22House+of+Commons%22-status%3A%28withdrawn+OR+tabled%29")

  dates <- generate_dates("2019-12-16", "2020-03-30")

  m <- purrr::pmap_dfr(dates, function(start_day, start_month, start_year,
                                              end_day, end_month, end_year) {

    url <- paste0("https://search.parliament.uk/export?q=type%3A%22Members%27+contributions%22+date%3A",
                  start_day, "%2F", start_month, "%2F", start_year, "..", end_day, "%2F", end_month, "%2F",
                  end_year, url_base, collapse = ", ")

    df <- download_csv(url)

    df})

  write(m, "fetch_all_contributions_mocks_data")
}

# Validation data -------------------------------------------------------------

#' Fetch validation data for unit tests of fetch_all_contributions
#'
#' @keywords internal

get_all_contributions_validation_data <- function() {

  # Download all_contributions data
  m <- fetch_all_contributions("2019-12-16", "2020-03-30", 19, 21)
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




# mock, validation and a download using the same dates yield 21435 obs of 24 variables.
# but when i run the test, obs has many more rows
# this must be because each time purrr gets to the download_csv it adds the rows
