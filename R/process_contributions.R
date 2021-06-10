#' Process contributions data
#'
#' \code{process_contributions} Processes Members' contributions data
#'
#' @param contributions A dataframe containing Members' contribution data
#' @return A dataframe containing contributions attributed to single members, including the number of words per contribution
#' @export
#'

process_contributions <- function(contributions) {

  data <- contributions %>% dplyr::filter(! is.na(.data$content))
  data <- data %>% tidyr::separate(
    col = .data$member,
    into = c("member", "member_second"),
    sep = "; ",
    fill = "right")
  data$words <- sapply(data$content, function(contribution) length(unlist(strsplit(as.character(contribution), "\\W+"))))
  names(data$words) <- NULL

  data
}





