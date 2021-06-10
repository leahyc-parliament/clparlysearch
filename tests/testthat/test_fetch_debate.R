# Test functions in fetch_debate.R
# Imports ---------------------------------------------------------------------

source("validate.R")

# Mocks -----------------------------------------------------------------------
mock_download_csv <- function(url) {
  read("fetch_debate_mocks_data")
}

# Tests -----------------------------------------------------------------------

test_that("fetch_debate processes results correctly.", {

  mockery::stub(fetch_debate, "download_csv", mock_download_csv)

  cols <- c(
    "type",
    "ref",
    "date",
    "title",
    "content",
    "member",
    "member_party",
    "department",
    "legislature",
    "place",
    "subject",
    "legislation",
    "procedure",
    "web_location"
    )

  obs <- fetch_debate("Agricultural Exports from Australia: Tariffs", "2021-05-27", 21, 22)
  exp <- readRDS("data/fetch_debate_data.RData")
  compare_obs_exp(obs, exp, cols, "ref")
})

# ERROR: ARGUMENT 15 IS EMPTY
