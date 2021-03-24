#' Get the matched variables for input data
#'
#' Input data require several variables to be existed, and some variables can
#' have alternatives. Here we check if all the variables exist, and if only one
#' of the alternatives exists for each variable. If the check is passed, the
#' matched result (a character vector) will be returned, or else a `NULL` value
#' will be returned.
#'
#' @param data Required. Raw data, a `data.frame`.
#' @param vars_config Required. A `data.frame` containing the configuration of
#'   required variables. Possible variables are:
#'   * `field`: Required. Name references of all data variable names.
#'   * `name`: Required. Data variable names, in which lists all the possible
#'   names for current data variable.
#'   * `type`: Optional. Can be "required" (must exist) or "optional" (try to
#'     match, if not find, `NA` is returned and it must be handled in another
#'     place). If this variable is not specified, it will default to "required".
#' @keywords internal
match_data_vars <- function(data, vars_config) {
  # set default type to "required"
  if (!utils::hasName(vars_config, "type")) {
    vars_config$type <- "required"
  }
  vars_chk_result <- vars_config %>%
    dplyr::mutate(
      purrr::map_df(
        .data$name,
        ~ {
          match_result <- utils::hasName(data, .x)
          tibble(
            is_found = any(match_result),
            is_confused = sum(match_result) > 1,
            # the match can be of length 0, so use `if` instead of `if_else`
            matched = if (sum(match_result) == 1) .x[match_result] else NA
          )
        }
      )
    )
  if (!all(vars_chk_result$is_found[vars_chk_result$type == "required"])) {
    warning("At least one of the required variables are missing.")
    return(NULL)
  }
  if (any(vars_chk_result$is_confused)) {
    warning("At least one of the variables have more than one match.")
    return(NULL)
  }
  return(
    vars_chk_result %>%
      dplyr::select(.data$field, .data$matched) %>%
      tibble::deframe()
  )
}

#' Correct reaction time and accuracy values
#'
#' Generally speaking, a response time that is no more than 100 milliseconds is
#' impossible for human beings, which is possibly accompanied by an error
#' operation. This function tried to correct that by setting reaction time to
#' `NA` and accuracy to `-1` (can be opted out) for those trials.
#'
#' @param data Required. Raw data, a `data.frame`.
#' @param crit_rt Minimal reaction time in milliseconds. Reaction times that are
#'   equal or less than this will be treated as illegal.
#' @param correct_type Four types are supported. `"both"` (default) means that
#'   both response time and accuracy are corrected, `"none"` means no
#'   correction, and `"rt"`/`"acc` means correct the corresponding one.
#' @param name_rt The variable name of reaction time in the input `data`.
#' @param name_acc The variable name of accuracy in the input `data`.
#' @return The data is added with two new columns. `rt_cor`: the corrected
#'   reaction time; `acc_cor`: the corrected accuracy. They can both disappear,
#'   because if there is no such correction, the column is added only if the
#'   corresponding variable exists in the original `data`.
#' @keywords internal
correct_rt_acc <- function(data, ...,
                           crit_rt = 100,
                           correct_type = c("both", "rt", "acc", "none"),
                           name_rt = "RT",
                           name_acc = "ACC") {
  correct_type <- match.arg(correct_type)
  data_out <- data
  if (correct_type %in% c("both", "rt")) {
    data_out <- data_out %>%
      dplyr::mutate(
        rt_cor = dplyr::if_else(
          .data[[name_rt]] > crit_rt,
          .data[[name_rt]], NA_integer_
        )
      )
  }
  if (correct_type %in% c("both", "acc")) {
    data_out <- data_out %>%
      dplyr::mutate(
        acc_cor = dplyr::if_else(
          .data[[name_rt]] > crit_rt,
          .data[[name_acc]], -1L
        )
      )
  }
  # add corrected name (with uncorrected value) if name found in original data
  if (rlang::has_name(data, name_rt) & !rlang::has_name(data_out, "rt_cor")) {
    data_out <- data_out %>%
      dplyr::mutate(rt_cor = .data[[name_rt]])
  }
  if (rlang::has_name(data, name_acc) & !rlang::has_name(data_out, "acc_cor")) {
    data_out <- data_out %>%
      dplyr::mutate(acc_cor = .data[[name_acc]])
  }
  return(data_out)
}
#' Compose output containing `NA`s with names required
#'
#' @param vars_output Variable names in the output
#' @return Use `NA_real` as values. And a variable of `FALSE` value is added.
#' @keywords internal
compose_abnormal_output <- function(vars_output) {
  rlang::set_names(
    rep(NA_real_, length(vars_output)),
    nm = vars_output
  ) %>%
    tibble::as_tibble_row() %>%
    tibble::add_column(is_normal = FALSE)
}
