#' Calculates index scores for Span related games
#'
#' Three indices are returned: maximal span, mean span and count of correct
#' responses.
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{max_span}{Maximal span.}
#'   \item{mean_span}{Mean span.}
#'   \item{nc}{Count of correct responses.}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
span <- function(data, ...) {
  vars_output <- c("max_span", "mean_span", "nc")
  vars_config <- tibble::tribble(
    ~type, ~field, ~name,
    "required", "name_slen", c("NumTarget", "SLen"),
    "optional", "name_correct", c("Correctness", "AccLoc"),
    "required", "name_outcome", "Outcome"
  )
  vars_matched <- match_data_vars(data, vars_config)
  if (is.null(vars_matched)) {
    return(compose_abnormal_output(vars_output))
  }
  delim <- "-"
  if (is.na(vars_matched[["name_correct"]])) {
    vars_matched["name_correct"] <- "Correctness"
    if (!all(utils::hasName(data, c("STIM", "Resp")))) {
      # use na values if cannot be restored
      data <- data %>%
        dplyr::mutate(!!vars_matched["name_correct"] := NA_character_)
    } else {
      data <- data %>%
        dplyr::mutate(
          !!vars_matched[["name_correct"]] := purrr::map2_chr(
            .data[["STIM"]], .data[["Resp"]],
            ~ {
              stims <- unlist(strsplit(.x, delim))
              resps <- unlist(strsplit(.y, delim))
              len_diff <- length(stims) - length(resps)
              if (len_diff > 0) {
                resps <- c(resps, rep(-1, len_diff))
              }
              paste(as.numeric(stims == resps), collapse = delim)
            }
          )
        )
    }
  }
  span_indices <- data %>%
    dplyr::group_by(.data[[vars_matched["name_slen"]]]) %>%
    dplyr::summarise(
      pc = mean(.data[[vars_matched["name_outcome"]]] == 1),
      .groups = "drop"
    ) %>%
    dplyr::summarise(
      max_span = max(.data[[vars_matched["name_slen"]]]),
      mean_span = min(.data[[vars_matched["name_slen"]]]) - .5 +
        sum(.data[["pc"]])
    )
  nc <- data %>%
    dplyr::pull(vars_matched[["name_correct"]]) %>%
    strsplit(delim) %>%
    unlist() %>%
    as.numeric() %>%
    sum()
  tibble(span_indices, nc, is_normal = TRUE)
}
