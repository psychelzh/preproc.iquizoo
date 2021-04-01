#' Convert character accuracy
#'
#' Simple function converts character correctness to numeric one.
#'
#' @param x The character to be parsed.
#' @param delim Delimiter used to join correctness when forming the character.
#'   Usually is hyphen (i.e., `"-"`), which is the default.
#' @return A numeric vector of the parsed correctness. Might produce `NA`s.
#' @keywords internal
parse_char_acc <- function(x, delim = "-") {
  x %>%
    stringr::str_split(delim, simplify = TRUE) %>%
    as.numeric()
}
