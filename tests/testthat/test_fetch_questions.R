### Test functions in fetch_all_proceedings.R
# Imports ---------------------------------------------------------------------

source("validate.R")

# Mocks -----------------------------------------------------------------------

mock_download_csv <- function(url) {
  read("fetch_questions_mocks_data")
}


# Tests -----------------------------------------------------------------------

test_that("fetch_questions processes results correctly.", {

  mockery::stub(fetch_questions, "download_csv", mock_download_csv)

  cols <- c(
    "type",
    "ref",
    "date",
    "title",
    "summary",
    "attachment_title",
    "member",
    "member_party",
    "asking_member",
    "asking_member_party",
    "lead_member",
    "lead_members_party",
    "answering_member",
    "answering_members_party",
    "department",
    "legislature",
    "place",
    "subject",
    "legislation",
    "procedure",
    "web_location")

  obs <- fetch_questions("2020-03-02", "2020-03-09", 19, 21)
  exp <- readRDS("data/fetch_questions_data.RData")
  compare_obs_exp(obs, exp, cols, "ref")
})

# TEST PASSED BUT ONLY IF SOURCED MANUALLY


