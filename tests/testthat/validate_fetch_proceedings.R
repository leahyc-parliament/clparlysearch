### Download data for unit testing fetch_all_proceedings.R

# Imports ---------------------------------------------------------------------

source("tests/testthat/validate.R")

# Mocks data ------------------------------------------------------------------

#' Fetch mocks data for unit tests of fetch_pmbs
#'
#' @keywords internal

fetch_all_proceedings_mocks_data <- function() {

  # Download proceedings for test Session 19-21
  urls <- list(url_adj_ed = "https://search.parliament.uk/export?q=%28%28type%3A%22Adjournment+debates%22%29+OR+%28type%3A%22Emergency+debates%22%29%29+session%3A19%2F21+legislature%3A%22House+of+Commons%22",
               url_uq_bbb = "https://search.parliament.uk/export?q=%28%28type%3A%22Backbench+debates%22%29+OR+%28type%3A%22Urgent+questions%22%29%29+session%3A19%2F21+legislature%3A%22House+of+Commons%22",
               url_wh = "https://search.parliament.uk/export?q=type%3ADebates+place%3A%22Westminster+Hall%22+session%3A19%2F21+legislature%3A%22House+of+Commons%22+-type%3A%28%22e-petition+debates%22+OR+%22backbench+debates%22+OR+%22debates+on+select+committee+reports%22%29&rows=10&view=default&s=date"
  )

  m <- purrr::map_dfr(urls, ~ download_csv(.))
  write(m, "fetch_all_proceedings_mocks_data")
}

# Validation data -------------------------------------------------------------

#' Fetch validation data for unit tests of fetch_all_proceedings
#'
#' @keywords internal

fetch_all_proceedings_validation_data <- function() {

  # Download get_member_data
  m <- fetch_all_proceedings(19, 21)
  write(m, "fetch_all_proceedings_data")
}

# Fetch all data --------------------------------------------------------------

#' Fetch mocks and validation data for unit tests of fetch_all_proceedings
#'
#' @keywords internal

fetch_all_proceedings_test_data <- function() {
  fetch_all_proceedings_mocks_data()
  fetch_all_proceedings_validation_data()
}
