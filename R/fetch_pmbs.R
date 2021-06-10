#' Get data on PMBs by Session
#'
#' \code{fetch_pmbs} Get data on Private Members' Bills introduced by Member by Session
#'
#' @param session_start The start year of the Session (yy)
#' @param session_end The end year of the Session (yy)
#' @return A dataframe containing data on bills introduced
#' @export
#'

fetch_pmbs <- function(session_start, session_end) {

  url <- paste0("https://search.parliament.uk/export?q=type%3A%22",
                  "Private+members%27+bills%22+session%3A",
                  session_start, "%2F", session_end,
                  "+legislature%3A%22House+of+Commons%22", collapse = ", ")

  pmbs <- download_csv(url)

  pmbs$date <- as.Date(lubridate::dmy_hms(pmbs$date))

  pmbs
}





