### Test functions in fetch_all_proceedings.R
# Imports ---------------------------------------------------------------------

source("validate.R")

# Mocks -----------------------------------------------------------------------

mock_map_dfr <- function(url, f) {
  read("fetch_all_proceedings_mocks_data")
}


# Tests -----------------------------------------------------------------------

test_that("fetch_all_proceedings processes results correctly.", {

  mockery::stub(fetch_all_proceedings, "purrr::map_dfr", mock_map_dfr)

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
    "web_location")

  obs <- fetch_all_proceedings(19, 21)
  exp <- readRDS("data/fetch_all_proceedings_data.RData")
  compare_obs_exp(obs, exp, cols, "ref")
})


# TEST PASSED BUT ONLY IF SOURCED MANUALLY

