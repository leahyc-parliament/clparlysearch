# test generate_dates

# This should generate a list of start and end days, months and years
test_dates <- generate_dates("2019-12-16", "2020-01-27")

expect_length(test_dates, 6)
expect_equal(test_dates$start_day[1], 16)
expect_equal(test_dates$start_year[4], 2020)
expect_equal(test_dates$end_month[3], 1)
expect_equal(test_dates$end_day[5], 19)
