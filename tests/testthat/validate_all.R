### Download all data for unit testing

# Imports ---------------------------------------------------------------------

source("tests/testthat/validate_get_members.R")
source("tests/testthat/validate_fetch_all_contributions2.R")
source("tests/testthat/validate_fetch_pmbs.R")
source("tests/testthat/validate_fetch_petitions.R")
source("tests/testthat/validate_fetch_debate.R")
source("tests/testthat/validate_fetch_proceedings.R")
source("tests/testthat/validate_fetch_questions.R")

# Fetch all data --------------------------------------------------------------

get_members_test_data()
get_all_contributions_test_data()

fetch_petitions_test_data()
fetch_pmbs_test_data()

fetch_debate_test_data()
fetch_all_proceedings_test_data()

fetch_questions_test_data()
