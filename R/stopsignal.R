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
  data <- data %>%
    dplyr::mutate(
      acc_adj = dplyr::if_else(
        .data[[vars_matched["name_rt"]]] >= 100,
        .data[[vars_matched["name_acc"]]], 0L
      )
    )
  indices_from_acc <- data %>%
    dplyr::mutate(pc_all = mean(.data$acc_adj)) %>%
    dplyr::filter(.data[[vars_matched["name_type"]]] == "Go") %>%
    dplyr::group_by(.data[["pc_all"]]) %>% # to keep `pc_all` variable
    dplyr::summarise(pc_go = mean(.data[["acc_adj"]]), .groups = "drop")
  indices_from_rt <- data %>%
    dplyr::mutate(
      rt_go = dplyr::if_else(
        .data[[vars_matched["name_type"]]] == "Go" & .data[["acc_adj"]] == 1,
        .data[[vars_matched["name_rt"]]], NA_integer_
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
  validation <- data %>%
    dplyr::filter(.data[[vars_matched["name_type"]]] == "Go") %>%
    dplyr::summarise(
      nt = dplyr::n(),
      nr = sum(.data[[vars_matched["name_acc"]]] != -1),
      nc = sum(.data[["acc_adj"]] == 1)
    ) %>%
    dplyr::transmute(
      is_normal = (.data[["nr"]] / .data[["nt"]]) > 0.8 && # response rate > 80%
        .data[["nc"]] > stats::qbinom(0.95, .data[["nt"]], 0.5) &&
        !is.na(indices_from_rt[["mean_ssd"]]) # fail in stop trials
    )
  tibble(indices_from_acc, indices_from_rt, validation)
}
