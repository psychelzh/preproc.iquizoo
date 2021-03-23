#' Calculates index scores for N Back games.
#'
#' Several values including percentage of correct responses (pc), mean reaction
#' time (mrt), sensitivity index (i.e, d') and bias (c).
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{pc}{Percentage of correct responses.}
#'   \item{mrt}{Mean reaction time.}
#'   \item{dprime}{Sensitivity index.}
#'   \item{c}{Bias.}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
nback <- function(data, ...) {
  vars_output <- c("pc", "mrt", "dprime", "c")
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
      type_adj = dplyr::if_else(
        .data[[vars_matched["name_type"]]] == "Change",
        "s", "n"
      ),
      acc_adj = dplyr::if_else(
        .data[[vars_matched["name_rt"]]] <= 100,
        0L, .data[[vars_matched["name_acc"]]]
      )
    )
  basic <- data_adj %>%
    dplyr::summarise(
      pc = mean(.data[["acc_adj"]] == 1),
      mrt = mean(.data[[vars_matched["name_rt"]]][.data[["acc_adj"]] == 1])
    )
  sdt <- calc_sdt(
    data_adj,
    name_type = "type_adj",
    name_acc = "acc_adj"
  )
  is_normal <- data_adj %>%
    dplyr::summarise(nt = dplyr::n(), nc = sum(.data[["acc_adj"]] == 1)) %>%
    dplyr::transmute(
      is_normal = .data[["nc"]] > stats::qbinom(0.95, .data[["nt"]], 0.5)
    )
  tibble(basic, sdt, is_normal)
}
