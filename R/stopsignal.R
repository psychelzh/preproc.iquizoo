#' Calculates index scores for stop signal game
#'
#' The main index for stop signal games is the so-called stop signal reaction
#' time (*SSRT*). Here the method used is the same as that in stair-case method.
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A [tibble][tibble::tibble-package] with the following variables:
#'   \item{pc_all}{Percent of correct for all the responses.}
#'   \item{pc_go}{Percent of correct for the go trials only.}
#'   \item{medrt_go}{Median reaction time (ms) of go trials.}
#'   \item{mean_ssd}{Mean stop signal delay time (ms).}
#'   \item{ssrt}{Stop signal reaction time (ms).}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
stopsignal <- function(data, ...) {
  vars_output <- c(
    "pc_all", "pc_go",
    "medrt_go", "mean_ssd", "ssrt"
  )
  vars_required <- tibble::tribble(
    ~field, ~name,
    "name_type", "Type",
    "name_ssd", "SSD",
    "name_acc", "ACC",
    "name_rt", "RT"
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
  data_cor <- data %>%
    dplyr::mutate(
      correct_type = dplyr::if_else(
        .data[[vars_matched["name_type"]]] == "Go",
        "both", "none"
      )
    ) %>%
    dplyr::group_by(.data[["correct_type"]]) %>%
    dplyr::group_modify(
      ~ correct_rt_acc(data = .x, correct_type = .y[["correct_type"]])
    ) %>%
    dplyr::ungroup()
  indices_from_acc <- data_cor %>%
    dplyr::mutate(pc_all = mean(.data[["acc_cor"]])) %>%
    dplyr::filter(.data[[vars_matched["name_type"]]] == "Go") %>%
    dplyr::group_by(.data[["pc_all"]]) %>% # to keep `pc_all` variable
    dplyr::summarise(pc_go = mean(.data[["acc_cor"]]), .groups = "drop")
  indices_from_rt <- data_cor %>%
    dplyr::mutate(
      rt_go = dplyr::if_else(
        .data[[vars_matched["name_type"]]] == "Go",
        .data[["rt_cor"]], NA_integer_
      ),
      medrt_go = stats::median(.data[["rt_go"]], na.rm = TRUE)
    ) %>%
    dplyr::filter(
      stringr::str_detect(.data[[vars_matched["name_type"]]], "Stop")
    ) %>%
    dplyr::group_by(
      .data[[vars_matched["name_type"]]],
      .data[["medrt_go"]]
    ) %>%
    dplyr::summarise(
      ssd = purrr::possibly(
        ~ c(
          pracma::findpeaks(.x)[, 1],
          -pracma::findpeaks(-.x)[, 1]
        ) %>%
          mean(),
        otherwise = NA_real_
      )(.data[["SSD"]]),
      .groups = "drop"
    ) %>%
    dplyr::group_by(.data[["medrt_go"]]) %>% # to keep `medrt_go` variable
    dplyr::summarise(mean_ssd = mean(.data[["ssd"]])) %>%
    dplyr::mutate(ssrt = .data[["medrt_go"]] - .data[["mean_ssd"]])
  validation <- data_cor %>%
    dplyr::filter(.data[[vars_matched["name_type"]]] == "Go") %>%
    dplyr::summarise(
      nt = dplyr::n(),
      nr = sum(.data[["acc_cor"]] != -1),
      nc = sum(.data[["acc_cor"]] == 1)
    ) %>%
    dplyr::transmute(
      is_normal = (.data[["nr"]] / .data[["nt"]]) > 0.8 && # response rate > 80%
        .data[["nc"]] > stats::qbinom(0.95, .data[["nt"]], 0.5) &&
        !is.na(indices_from_rt[["mean_ssd"]]) # fail in stop trials
    )
  tibble(indices_from_acc, indices_from_rt, validation)
}
