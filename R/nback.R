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
    return(compose_abnormal_output(vars_output))
  }
  data_cor <- correct_rt_acc(data)
  basic <- data_cor %>%
    dplyr::summarise(
      pc = mean(.data[["acc_cor"]] == 1),
      mrt = mean(.data[["rt_cor"]], na.rm = TRUE)
    )
  sdt <- calc_sdt(
    data_cor,
    name_type = vars_matched["name_type"],
    name_acc = "acc_cor",
    values_type = c("Change", "Stay")
  )
  is_normal <- check_resp_metric(data_cor)
  tibble(basic, sdt, is_normal)
}
