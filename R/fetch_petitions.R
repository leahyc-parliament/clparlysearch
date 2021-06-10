#' Get data on petitions by Member, by Session
#'
#' \code{fetch_petitions} Downloads data on petitions introduced by Member, by Session
#'
#' @param session_start The start year of the session (yy)
#' @param session_end The end year of the session (yy)
#' @return A dataframe including data on petitions
#' @export
#'

fetch_petitions <- function(session_start, session_end) {

  url <- paste0("https://search.parliament.uk/export?q=type%3APetitions+session%3A",
                  session_start, "%2F", session_end,
                  "+legislature%3A%22House+of+Commons%22", collapse = ", ")

  petitions <- download_csv(url)

  petitions$date <- as.Date(lubridate::dmy_hms(petitions$date))

  petitions$summary <- purrr::map_chr(petitions$summary,
                                      ~ stringr::str_squish(textclean::replace_html(.)))

  petitions
}


