#' Calculates index scores for Continuous Performance Test game.
#'
#' Many indices are returned: d', c (i.e., bias), hits, commissions, ommissions,
#' mean reaction time (mrt), standard deviation of reaction times (rtsd).
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{pc}{Percentage of correct responses.}
#'   \item{dprime}{Sensitivity (d').}
#'   \item{c}{Bias index.}
#'   \item{hits}{Number of hits.}
#'   \item{commissions}{Number of errors caused by action.}
#'   \item{omissions}{Number of errors caused by inaction.}
#'   \item{count_error}{Count of incorrect responses.}
#'   \item{mrt}{Mean reaction time of hits.}
#'   \item{rtsd}{Standard deviation of reaction times of hits.}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
cpt <- function(data, ...) {
  vars_output <- c(
    "pc", "dprime", "c",
    "hits", "commissions", "omissions", "count_error",
    "mrt", "rtsd"
  )
  vars_required <- tibble::tribble(
    ~field, ~name,
    "name_type", "Type",
    "name_acc", "ACC",
    "name_rt", "RT"
  )
  vars_matched <- match_data_vars(data, vars_required)
  if (is.null(vars_matched)) {
    return(compose_abnormal_output(vars_output))
  }
  data_cor <- data %>%
    dplyr::mutate(
      type_cor = dplyr::if_else(
        .data[[vars_matched["name_type"]]] == "Target",
        "s", "n"
      ),
      correct_type = dplyr::if_else(
        .data[["type_cor"]] == "s",
        "both", "rt"
      )
    ) %>%
    dplyr::group_by(.data[["correct_type"]]) %>%
    dplyr::group_modify(
      ~ correct_rt_acc(data = .x, correct_type = .y[["correct_type"]])
    ) %>%
    dplyr::ungroup()
  pc <- data_cor %>%
    dplyr::summarise(pc = mean(.data[["acc_cor"]]))
  sdt <- calc_sdt(
    data_cor,
    name_type = "type_cor",
    name_acc = "acc_cor"
  )
  counts <- data_cor %>%
    dplyr::group_by(.data[["type_cor"]]) %>%
    dplyr::summarise(
      nc = sum(.data[["acc_cor"]] == 1),
      ne = sum(.data[["acc_cor"]] == 0)
    ) %>%
    tidyr::pivot_wider(names_from = "type_cor", values_from = c("nc", "ne")) %>%
    dplyr::transmute(
      hits = .data[["nc_s"]],
      commissions = .data[["ne_n"]],
      omissions = .data[["ne_s"]],
      count_error = .data[["ne_n"]] + .data[["ne_s"]]
    )
  rt <- data_cor %>%
    dplyr::filter(.data[["acc_cor"]] == 1 & .data[["type_cor"]] == "s") %>%
    dplyr::summarise(
      mrt = mean(.data[["rt_cor"]]),
      rtsd = stats::sd(.data[["rt_cor"]])
    )
  is_normal <- check_resp_metric(data_cor, check_type = "accuracy")
  tibble(pc, sdt, counts, rt, is_normal)
}
