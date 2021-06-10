#' Helper functions
#'
#'\code{get_members} Downloads data on all current Members

#' @return A tibble data on all current Members including MNIS id, name, gender, constituency, start date and party
#' @keywords internal
#'

get_members <- function() {

  path <- stringr::str_c(
    "http://data.parliament.uk/membersdataplatform/services/",
    "mnis/members/query/house=Commons|IsEligible=true")

  request <- httr::GET(url = path)

  # Get rid of the byte-order mark warning
  members_text <- request %>% httr::content(as = "text", encoding = "utf-8")

  members <- members_text %>%
    stringr::str_sub(1) %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    data.frame()

  members <- members[, c(1, 5, 6, 10, 12, 13, 17)]
  colnames(members) <- c("MNIS_id", "display_name", "name", "gender",
                         "constituency", "start_date", "party")

  members$MNIS_id <- as.numeric(members$MNIS_id)

  members
}


#'\code{generate_dates} Generates a list of dates to map over

#' @return A list of weeks in a specified period broken down into day, month, year
#' @keywords internal
#'

generate_dates <- function(start_date, end_date) {

  start_date <- as.Date(start_date)
  end_date <- as.Date(end_date)

  week_starts <- seq(start_date, end_date, by = "week")
  week_ends <- seq(start_date, end_date, by = "week") - 1
  week_ends[length(week_ends)] <- week_starts[length(week_starts)]
  week_starts <- week_starts[-length(week_starts)]
  week_ends <- week_ends[-1]

  if (week_ends[length(week_ends)] != end_date) warning("Final days of period not included in data. Consider using a later end_date")

  list(
    start_day = as.numeric(format(week_starts, format = "%d")),
    start_month = as.numeric(format(week_starts, format = "%m")),
    start_year = as.numeric(format(week_starts, format = "%Y")),
    end_day = as.numeric(format(week_ends, format = "%d")),
    end_month = as.numeric(format(week_ends, format = "%m")),
    end_year = as.numeric(format(week_ends, format = "%Y"))
  )
}


#'\code{download_csv} Downloads a csv from a url

#' @return A tibble
#' @keywords internal
#'

download_csv <- function(url) {

  options(timeout= 4000000)

  df <- suppressWarnings(readr::read_csv(
    url,
    skip = 2,
    col_types = readr::cols(.default = readr::col_character())))

  df <- df[1:nrow(df) - 1,]

  if(nrow(df) >= 10000) warning("Data has probably been truncated by the server.")

  df <- janitor::clean_names(df)

  df
}


