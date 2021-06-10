### Test functions in fetch_pmbs.R
# Imports ---------------------------------------------------------------------

source("validate.R")

# Mocks -----------------------------------------------------------------------

mock_download_csv <- function(url) {
  read("fetch_pmbs_mocks_data")
}

# Tests -----------------------------------------------------------------------

test_that("fetch_pmbs processes results correctly.", {

  mockery::stub(fetch_pmbs, "download_csv", mock_download_csv)

  cols <- c(
    "type",
    "ref",
    "date",
    "title",
    "member",
    "members_party",
    "department",
    "legislature",
    "subject",
    "legislation",
    "certified_category",
    "library_location",
    "web_location"
    )

  obs <- fetch_pmbs(19, 21)
  exp <- readRDS("data/fetch_pmbs_data.RData")
  compare_obs_exp(obs, exp, cols, "ref")
})


# TEST PASSED BUT I HAD TO SOURCE VALIDATE.R MANUALLY
# Error: cannot open the connection

