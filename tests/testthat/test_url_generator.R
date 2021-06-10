### Test url generator

test_that("urls for contributions is generated correctly", {

  url_contributions <- "https://search.parliament.uk/export?q=type%3A%22Members%27+contributions%22+place%3A%22House+of+Commons+chamber%22+date%3A1%2F3%2F2019..8%2F3%2F2019+session%3A17%2F19+legislature%3A%22House+of+Commons%22"

  dates <- list(
    start_day = 1,
    start_month = 3,
    start_year = 2019,
    end_day = 8,
    end_month = 3,
    end_year = 2019)

  get_url_base <-   function(session_start, session_end)  {

    url_base <- paste0("+session%3A", session_start, "%2F", session_end, "+legislature%3A%22House+of+Commons%22", collapse = ", ")
  }

  url_base <- get_url_base(17, 19)

  get_url <- purrr::pmap(dates, function(start_day, start_month, start_year, end_day, end_month, end_year) {

    url <- paste0("https://search.parliament.uk/export?q=type%3A%22Members%27+contributions%22+place%3A%22House+of+Commons+chamber%22+date%3A", start_day, "%2F", start_month, "%2F", start_year, "..", end_day, "%2F", end_month, "%2F", end_year, url_base, collapse = ", ")

    testthat::expect_equal(url, url_contributions)
    })
})














