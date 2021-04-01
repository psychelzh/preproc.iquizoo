#' Calculates index scores for games related to congruency effect
#'
#' Count of correct responses and congruency effect of correct response and
#' reaction time are all included. The congruency effect here is just the mean
#' difference between congruenct and incongruent trials. See Stroop effect as an
#' example.
#'
#' @templateVar by low
#' @templateVar vars_input TRUE
#' @template params-template
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{mrt_inc}{Mean reaction time for incogruent trials.}
#'   \item{mrt_con}{Mean reaction time for congruent trials.}
#'   \item{cong_eff_rt}{Congruence effect of reaction time (RT), i.e.,
#'     incongruent RT - congruent RT.}
#'   \item{pc_inc}{Percent of correct for incogruent trials.}
#'   \item{pc_con}{Percent of correct for congruent trials.}
#'   \item{cong_eff_pc}{Congruence effect of percent of correct (PC), i.e.,
#'     congruent PC - incongruent PC}
#' @export
congeff <- function(data, by, vars_input) {
  data_cor <- data %>%
    dplyr::mutate(
      # remove rt of 100 or less
      rt_cor = ifelse(
        .data[[vars_input[["name_rt"]]]] > 100,
        .data[[vars_input[["name_rt"]]]], NA
      ),
      dplyr::across(
        tidyselect::vars_select_helpers$where(is.character),
        tolower
      )
    )
  calc_cong_eff(
    data_cor, by = by,
    name_cong = vars_input[["name_cong"]],
    name_acc = vars_input[["name_acc"]],
    name_rt = "rt_cor"
  )
}
