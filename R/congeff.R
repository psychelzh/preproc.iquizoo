#' Calculates index scores for games related to congruency effect
#'
#' Count of correct responses and congruency effect of correct response and
#' reaction time are all included. The congruency effect here is just the mean
#' difference between congruenct and incongruent trials. See Stroop effect as an
#' example.
#'
#' @param data Raw data of class `data.frame`.
#' @param ... Other input argument for future expansion.
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{mrt_inc}{Mean reaction time for incogruent trials.}
#'   \item{mrt_con}{Mean reaction time for congruent trials.}
#'   \item{cong_eff_rt}{Congruency effect of reaction time (RT), i.e., RT
#'     incongruency - RT congruency.}
#'   \item{pc_inc}{Percent of correct for incogruent trials.}
#'   \item{pc_con}{Percent of correct for congruent trials.}
#'   \item{cong_eff_pc}{Congruency effect of percent of correct (PC), i.e., PC
#'     congruency - PC incongruency.}
#'   \item{nc}{Count of correct responses.}
#'   \item{is_normal}{Checking result whether the data is normal.}
#' @export
congeff <- function(data, ...) {
  vars_output <- c(
    "mrt_inc", "mrt_con", "cong_eff_rt",
    "pc_inc", "pc_con", "cong_eff_pc", "nc"
  )
  vars_required <- tibble::tribble(
    ~field, ~name,
    "name_cong", "Type",
    "name_acc", "ACC",
    "name_rt", "RT"
  )
  vars_matched <- match_data_vars(data, vars_required)
  if (is.null(vars_matched)) {
    return(compose_abnormal_output(vars_output))
  }
  data_cor <- correct_rt_acc(data)
  cong_eff <- calc_cong_eff(data_cor)
  is_normal <- check_resp_metric(data_cor)
  tibble(cong_eff, nc = sum(data_cor[["acc_cor"]] == 1), is_normal)
}
