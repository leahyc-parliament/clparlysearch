#' Get Parliamentary Questions data for a defined period
#'
#'\code{fetch_contributions} Downloads Parliamentary Questions asked in a defined period
#'
#' @param start_date The start date of the period for which PQs are downloaded
#' @param end_date The end date of the period for which PQs are downloaded
#' @return A tibble containing PQs asked along with details such as member, date, and subject
#' @export
#'

fetch_questions <- function(start_date, end_date) {

  dates <- generate_dates(start_date, end_date)

  url_base <- "+legislature%3A%22House+of+Commons%22"

  pb <- progress::progress_bar$new(total = length(dates$start_day))

  questions_data <- purrr::pmap_dfr(dates, function(start_day, start_month, start_year, end_day, end_month, end_year) {

    url <- paste0("https://search.parliament.uk/export?q=type%3A%22Parliamentary+questions%22+status%3A",
                  "%28tabled+OR+answered+OR+holding%29+date%3A", start_day, "%2F", start_month, "%2F",
                  start_year, "..", end_day, "%2F", end_month, "%2F", end_year, url_base, collapse = ", ")

    pb$tick()

    df <- download_csv(url)

    if ("summary" %in% colnames(df)) {
      df$summary <- purrr::map_chr(df$summary, ~ stringr::str_squish(textclean::replace_html(.)))
    }

    if ("date" %in% colnames(df)) {
      df$date <- as.Date(lubridate::dmy_hms(df$date))
    }

    df})

}
