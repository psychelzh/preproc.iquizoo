#' Convert character responses
#'
#' Simple function converts character correctness to numeric one.
#'
#' @param x The character vector to be parsed.
#' @param delim Delimiter used to join correctness when forming the character.
#'   Usually is hyphen (i.e., `"-"`), which is the default.
#' @param convert_numeric A logical value indicating if the values should be
#'   converted to `numeric` ones.
#' @return A list of the parsed result, the same length as the input vector.
#' @keywords internal
parse_char_resp <- function(x, delim = "-", convert_numeric = TRUE) {
  parsed <- stringr::str_split(x, delim)
  if (convert_numeric) {
    parsed <- purrr::map(parsed, as.numeric)
  }
  parsed
}


#' Update settings with option settings
#'
#' Options are set in list can be tricky to update. This function makes partly
#' adding custom options work.
#'
#' @param origin The original settings.
#' @param updates The updates to settings
#' @return An update list of settings.
#' @keywords internal
update_settings <- function(origin, updates) {
  if (is.null(updates)) {
    return(origin)
  }
  purrr::imap(origin, ~ updates[[.y]] %||% .x)
}
