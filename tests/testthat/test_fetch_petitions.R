# Test functions in fetch_petitions.R

# Imports ---------------------------------------------------------------------

source("validate.R")

# Mocks -----------------------------------------------------------------------

mock_download_csv <- function(url) {
  read("fetch_petitions_mocks_data")
}

# Tests -----------------------------------------------------------------------

testthat::test_that("fetch_petitions processes results correctly.", {

  mockery::stub(fetch_petitions, "download_csv", mock_download_csv)

  cols <- c(
    "type",
    "ref",
    "date",
    "title",
    "summary",
    "lead_member",
    "lead_members_party",
    "answering_member",
    "answering_member_party",
    "department",
    "legislature",
    "place",
    "subject",
    "topic",
    "legislation",
    "procedure",
    "legislative_stage",
    "ec_documents",
    "web_location"
    )

  obs <- fetch_petitions(19, 21)
  exp <- readRDS("data/fetch_petitions_data.RData")
  compare_obs_exp(obs, exp, cols, "ref")
})

# TEST ONLY WORKS IF THE FULL PATH IS SPECIFIED IN VALIDATE.R FOR READ FUNCTION
