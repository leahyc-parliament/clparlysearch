#' Get Parliamentary Questions data for a defined period
#'
#'\code{fetch_contributions} Downloads Parliamentary Questions asked in a defined period
#'
#' @param start_date The start date of the period for which PQs are downloaded
#' @param end_date The end date of the period for which PQs are downloaded
#' @param session_start The start year of the session in which PQs were asked
#' @param session_end The end year of the session in which PQs were asked
#' @return A tibble containing PQs asked along with details such as member, date, and subject
#' @export
#'

fetch_questions <- function(start_date, end_date, session_start = NULL, session_end = NULL) {

  if (is.null(session_start)) stop("No session start year has been provided")
  if (is.null(session_end)) stop("No session end year has been provided")

  dates <- generate_dates(start_date, end_date)

  url_base <- paste0("+session%3A", session_start, "%2F", session_end,
                     "+legislature%3A%22House+of+Commons%22", collapse = ", ")

  pb <- dplyr::progress_estimated(length(dates$start_day))

  questions_data <- purrr::pmap_dfr(dates, function(start_day, start_month, start_year, end_day, end_month, end_year) {

    url <- paste0("https://search.parliament.uk/export?q=type%3A%22Parliamentary+questions%22+status%3A",
                  "%28tabled+OR+answered+OR+holding%29+date%3A", start_day, "%2F", start_month, "%2F",
                  start_year, "..", end_day, "%2F", end_month, "%2F", end_year, url_base, collapse = ", ")

    pb$tick()$print()

    df <- download_csv(url)

    if ("summary" %in% colnames(df)) {
      df$summary <- purrr::map_chr(df$summary, ~ stringr::str_squish(textclean::replace_html(.)))
    }

    if ("date" %in% colnames(df)) {
      df$date <- as.Date(lubridate::dmy_hms(df$date))
    }

    df})

}
