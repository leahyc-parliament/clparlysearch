#' Get contributions data for a defined period
#'
#'\code{fetch_all_contributions} Downloads Members' contributions for a defined period in any location, excluding Questions not (yet) asked
#'
#' @param start_date The start date of the period for which contributions are downloaded ("yyyy-mm-dd")
#' @param end_date The end date of the period for which contributions are downloaded ("yyyy-mm-dd")
#' @param session_start The start year of the session in which contributions were made (yy)
#' @param session_end The end year of the session in which contributions were made (yy)
#' @return A tibble containing contributions along with details such as member, date, and subject
#' @export
#'

fetch_all_contributions <- function(start_date, end_date, session_start = NULL, session_end = NULL) {

  if (is.null(session_start)) stop("No session start year has been provided")
  if (is.null(session_end)) stop("No session end year has been provided")

  dates <- generate_dates(start_date, end_date)

  url_base <- paste0("+session%3A", session_start, "%2F", session_end,
                     "+legislature%3A%22House+of+Commons%22-status%3A%28withdrawn+OR+tabled%29",
                     collapse = ", ")

  pb <- progress::progress_bar$new(total = length(dates$start_day))

  get_data <- purrr::pmap_dfr(dates, function(start_day, start_month, start_year,
                                              end_day, end_month, end_year) {

    url <- paste0("https://search.parliament.uk/export?q=type%3A%22Members%27+contributions%22+date%3A",
                  start_day, "%2F", start_month, "%2F", start_year, "..", end_day, "%2F", end_month, "%2F",
                  end_year, url_base, collapse = ", ")

    pb$tick()

    df <- download_csv(url)

    if ("content" %in% colnames(df)) {
      df$content <- purrr::map_chr(df$content, ~ stringr::str_squish(textclean::replace_html(.)))
    }

    if ("question_text" %in% colnames(df)) {
      df$question_text <- purrr::map_chr(df$question_text, ~ stringr::str_squish(textclean::replace_html(.)))

      colnames(df)[colnames(df)=="question_text"] <- "content"
    }

    if ("date" %in% colnames(df)) {
      df$date <- as.Date(lubridate::dmy_hms(df$date))
    }

    df})

}



