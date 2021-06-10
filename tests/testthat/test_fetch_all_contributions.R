### Test functions in fetch_all_contributions.R
# Imports ---------------------------------------------------------------------

source("validate.R")

# Mocks -----------------------------------------------------------------------

mock_download_csv <- function(url) {
  read("fetch_all_contributions_mocks_data")
}

# Tests -----------------------------------------------------------------------

test_that("fetch_all_contributions processes results correctly.", {

  mockery::stub(fetch_all_contributions, "download_csv", mock_download_csv)

  cols <- c(
    "type",
    "ref",
    "date",
    "title",
    "content",
    "member",
    "member_party",
    "asking_member",
    "asking_member_party",
    "answering_member",
    "answering_member_party",
    "department",
    "legislature",
    "place",
    "subject",
    "legislation",
    "procedure",
    "web_location")

  obs <- fetch_all_contributions("2021-05-20", "2021-05-27", 21, 22)
  exp <- readRDS("data/fetch_all_contributions_data.RData")
  compare_obs_exp(obs, exp, cols, "ref")
})


# TEST PASSED BUT ONLY IF RUN MANUALLY
