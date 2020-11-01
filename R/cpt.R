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
    return(
      rlang::set_names(
        rep(NA, length(vars_output)),
        nm = vars_output
      ) %>%
        tibble::as_tibble_row() %>%
        tibble::add_column(is_normal = FALSE)
    )
  }
  data_adj <- data %>%
    dplyr::mutate(
      type_adj = dplyr::if_else(.data$Type == "Target", "s", "n"),
      acc_adj = dplyr::if_else(.data$RT < 100 & .data$type_adj == "s", 0L, .data$ACC)
    )
  pc <- data_adj %>%
    dplyr::summarise(pc = mean(.data$acc_adj))
  sdt <- calc_sdt(
    data_adj,
    name_type = "type_adj",
    name_acc = "acc_adj"
  )
  counts <- data_adj %>%
    dplyr::group_by(.data$type_adj) %>%
    dplyr::summarise(
      nc = sum(.data$acc_adj == 1),
      ne = sum(.data$acc_adj == 0)
    ) %>%
    tidyr::pivot_wider(names_from = "type_adj", values_from = c("nc", "ne")) %>%
    dplyr::transmute(
      hits = .data$nc_s,
      commissions = .data$ne_n,
      omissions = .data$ne_s,
      count_error = .data$ne_n + .data$ne_s
    )
  rt <- data_adj %>%
    dplyr::filter(.data$acc_adj == 1 & .data$type_adj == "s") %>%
    dplyr::summarise(
      mrt = mean(.data$RT),
      rtsd = stats::sd(.data$RT)
    )
  is_normal <- data_adj %>%
    dplyr::summarise(nt = dplyr::n(), nc = sum(.data$acc_adj == 1)) %>%
    dplyr::transmute(is_normal = .data$nc > stats::qbinom(0.95, .data$nt, 0.5))
  tibble(pc, sdt, counts, rt, is_normal)
}
