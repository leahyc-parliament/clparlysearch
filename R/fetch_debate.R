#' Get contributions data for a specific debate
#'
#'\code{fetch_debate} Downloads Members' contributions to a specific debate
#'
#' @param title The title of the debate (e.g. "Brexit transition")
#' @param date The date of the debate ("yyyy-mm-dd")
#' @param session_start The start year of the session in which contributions were made (yy)
#' @param session_end The end year of the session in which contributions were made (yy)
#' @return A tibble containing contributions along with details such as Member, date, and subject
#' @export
#'

fetch_debate <- function(title, date, session_start = NULL, session_end = NULL) {

  if (is.null(session_start)) stop("No session start year has been provided")
  if (is.null(session_end)) stop("No session end year has been provided")

  title <- urltools::url_encode(title)

  date <- stringr::str_split_fixed(date, "-", n = 3)
  date <- tibble::tibble(year = date[1], month = date[2], day = date[3])

  url <- paste0("https://search.parliament.uk/export?q=title%3A%22", title,
                "%22+type%3A%22Proceeding+contributions%22+date%3A", date$day, "%2F",
                date$month, "%2F", date$year, "+session%3A", session_start, "%2F",
                session_end, "+legislature%3A%22House+of+Commons%22",
                collapse = ", ")

  df <- download_csv(url)

  if ("content" %in% colnames(df)) {
    df$content <- purrr::map_chr(df$content, ~ stringr::str_squish(textclean::replace_html(.)))
  }

  if("date" %in% colnames(df)) {
    df$date <- as.Date(lubridate::dmy_hms(df$date))
  }

  df

}
