#' Calculates index scores for games only considering correct response numbers.
#'
#' This is just to find out the count of correct responses.
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{nc}{Count of correct responses.}
#'   \item{pc}{Percent of correct responses.}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
countcorrect <- function(data, ...) {
  vars_output <- c("nc", "pc")
  vars_required <- tibble::tribble(
    ~field, ~name,
    "name_acc", c("ACC", "Repetition", "Correctness")
  )
  vars_matched <- match_data_vars(data, vars_required)
  if (is.null(vars_matched)) {
    return(
      rlang::set_names(
        rep(NA, length(vars_output)),
        nm = vars_output
      ) %>%
        tibble::as_tibble_row() %>%
        tibble::add_column(is_normal = FALSE)
    )
  }
  if (utils::hasName(data, "RT")) {
    data_cor <- correct_rt_acc(
      data,
      correct_type = "acc",
      name_acc = vars_matched["name_acc"]
    )
  } else {
    data_cor <- data %>%
      dplyr::mutate(acc_cor = .data[[vars_matched["name_acc"]]])
  }
  if (is.character(data_cor[["acc_cor"]])) {
    data_cor <- data_cor %>%
      dplyr::filter(
        !is.na(.data[["acc_cor"]]),
        .data[["acc_cor"]] != "NULL"
      ) %>%
      dplyr::summarise(
        acc_cor = .data[["acc_cor"]] %>%
          stringr::str_c(collapse = "-") %>%
          stringr::str_split("-", simplify = TRUE) %>%
          as.numeric() %>%
          list()
      ) %>%
      tidyr::unnest(.data[["acc_cor"]])
  }
  tibble(data_cor) %>%
    dplyr::summarise(
      nc = sum(.data[["acc_cor"]] == 1),
      pc = mean(.data[["acc_cor"]] == 1),
      is_normal = TRUE
    )
}
