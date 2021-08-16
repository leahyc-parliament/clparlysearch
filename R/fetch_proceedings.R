#' Get data on proceedings initiated by Members by Session
#'
#'\code{get_urls} Generate urls to download data
#'
#' @param session_start The start year of the Session (yy)
#' @param session_end The end year of the Session (yy)
#' @return A list of urls
#' @keywords internal
#'

get_urls <- function(session_start, session_end){

  # Data on adjournment debates and emergency debates
  url_adj_ed <- paste0("https://search.parliament.uk/export?q=%28%28type%3A%22Adjournment+debates",
                       "%22%29+OR+%28type%3A%22Emergency+debates%22%29%29+session%3A",
                        session_start, "%2F", session_end,
                        "+legislature%3A%22House+of+Commons%22", collapse = ", ")
  # Data on urgent questions and backbench business debates
  url_uq_bbb <- paste0("https://search.parliament.uk/export?q=%28%28type%3A%22Backbench+debates",
                       "%22%29+OR+%28type%3A%22Urgent+questions%22%29%29+session%3A",
                        session_start, "%2F", session_end,
                        "+legislature%3A%22House+of+Commons%22", collapse = ", ")
  # Data on westminster hall debates
  url_wh <- paste0("https://search.parliament.uk/export?q=type%3ADebates+place%3A%22Westminster+Hall%22+session%3A",
                   session_start, "%2F", session_end,
                   "+legislature%3A%22House+of+Commons%22+-type%3A%28%22e-petition+debates%22+OR+%22backbench+debates%22+OR+%22debates+on+select+committee+reports%22%29&rows=10&view=default&s=date", collapse = ", ")

  list(url_adj_ed, url_uq_bbb, url_wh)

}

#'\code{fetch_all_proceedings} Download data for proceedings
#'
#' @param session_start The start year of the Session (yy)
#' @param session_end The end year of the Session (yy)
#' @return A dataframe including contributions data for proceedings
#' @export
#

fetch_all_proceedings <- function(session_start, session_end) {

  urls <- get_urls(session_start, session_end)
  proceedings <- purrr::map_dfr(urls, ~ download_csv(.))

  proceedings$title <- purrr::map_chr(proceedings$title, ~ stringr::str_squish(textclean::replace_html(.)))
  proceedings$date <- as.Date(lubridate::dmy_hms(proceedings$date))

  proceedings$type <- stringr::str_replace_all(proceedings$type, "Debates", "Westminster Hall debates")

  proceedings
}

